import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../external/Flutter-Resizable-Widget/resizable_widget.dart';
import '../external/Flutter-Resizable-Widget/resizable_widget_controller.dart';
import 'fibonacci_spiral/fibonacci_spiral_drawer.dart';
import 'golden_cut/golden_cut_painter.dart';
import 'save_image.dart';

class CustomImageDisplayOptions {
  CustomImageDisplayOptions();
  
  bool applyGoldenCut = false;
  Color goldenCutColor = const Color.fromARGB(255, 255, 72, 0);
  
  bool applyFibonacci = false;
  bool isFibonacciResizeable = true;
  double fibonacciRotationDegrees = 0;
  double fibonacciScale = 2;
  Color fibonacciColor = Colors.deepOrange;
  
  ImageProvider? image;
  
  Paint get goldenCutPaint{
    final paint = Paint();
    
    paint.strokeWidth = 2;
    paint.color = goldenCutColor;
    
    return paint;
  }
  
  Paint get fibonacciPaint{
    final paint = Paint();
    
    paint.strokeWidth = 2;
    paint.color = fibonacciColor;
    
    return paint;
  }
}

class CustomImageDisplay extends StatefulWidget {
  const CustomImageDisplay({
    super.key,
    required this.options,
    required this.screenshotStream
  });
  
  final StreamController<String> screenshotStream;
  
  final CustomImageDisplayOptions options;
  
  @override
  State<StatefulWidget> createState() {
    return CustomImageDisplayState();
  }
}

class CustomImageDisplayState extends State<CustomImageDisplay> {  
  CustomImageDisplayOptions get options => widget.options;
  ImageProvider get image => options.image!;
  
  Future<Size> _getDimensionsOfCurrentImage() async {
    final Completer<Size> completer = Completer();
    
    image.resolve(ImageConfiguration.empty).addListener(ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        final myImage = image.image;
        final size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      }
    ));
      
    return completer.future;
  }
  
  GlobalKey scr = GlobalKey();
  
  @override
  Widget build(BuildContext context) {   
    if (!widget.screenshotStream.hasListener)
      widget.screenshotStream.stream.listen((event) { saveScreen(); });
     
    final imgSizeFuture = _getDimensionsOfCurrentImage(); // Initiate async operations first, then do calculations
    
    final areaHeight = Get.height * 0.70;
    final areaWidth = Get.width * 0.70;
    final controller = Get.put(
      ResizableWidgetController(
        initialPosition: Offset(areaWidth / 2, areaHeight / 2),
        areaHeight: areaHeight,
        areaWidth: areaWidth,
        height: areaHeight / 2,
        width: areaWidth / 2,
        minWidth: 50,
        minHeight: 50,
      ),
    );
    
    const dragWidgetSize = 25.0;
    
    final screenSize = MediaQuery.of(context).size;
    
    const addedMarginFraction = 0.75;
    final picFrameSize = screenSize * addedMarginFraction;
    
    return FutureBuilder(
      future: imgSizeFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          var targetSize = snapshot.data! as Size;
          
          final heightDifference =  picFrameSize.height / targetSize.height;
          final widthDifference = picFrameSize.width / targetSize.width;
          
          targetSize *= min(heightDifference, widthDifference);
          
          return RepaintBoundary(
            key: scr,
            child: SizedBox(
              height: targetSize.height,
              width: targetSize.width,
              child: Stack(
                children: [
                  Image(
                      image: image,
                      fit: BoxFit.contain,
                  ),
                  CustomPaint(
                    painter: GoldenCutPainter(
                      options: GoldenCutPainterOptions(
                        paint: options.goldenCutPaint,
                        applyGoldenCut: options.applyGoldenCut
                      )
                    ),
                    willChange: true,
                    child: Container(color: const Color.fromARGB(0, 0, 0, 0)),
                  ),
                  if (options.applyFibonacci)
                  ResizableWidget(
                    dragWidgetHeight: dragWidgetSize,
                    dragWidgetWidth: dragWidgetSize,
                    controller: controller,
                    dragWidget: Container(
                      height: dragWidgetSize,
                      width: dragWidgetSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(options.isFibonacciResizeable ? 200 : 0, 33, 149, 243),
                      ),
                    ),
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(options.fibonacciRotationDegrees / 360),
                      child: CustomPaint(
                        painter: FibonacciSpiralPainter(
                          options: FibonacciSpiralOptions(
                            paint: options.fibonacciPaint,
                            spiralScale: options.fibonacciScale,
                          )
                        ),
                        willChange: true,
                      ),
                    )
                  ),
                ]
              )
            ),
          );
        }
        else
        {
          return const Text('Loading...');
        }
      },
    );
  }
  
  Future saveScreen() async {
    final RenderRepaintBoundary boundary = scr.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      Timer(const Duration(seconds: 1), () => saveScreen());
      return null;
    }
    
    final image = await boundary.toImage();
    
    final imageSaver = ImageSaver(image: image);
    imageSaver.save(image);
  }
}
