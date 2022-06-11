import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'fibonacci_spiral/fibonacci_spiral_drawer.dart';
import 'golden_cut.dart';

class CustomImageDisplayOptions {
  CustomImageDisplayOptions({
    bool applyGoldenCut = false,
    bool applyFibonacci = false,
    double fibonacciRadius = 2,
    double fibonacciScale = 8
  })
  {
    applyGoldenCut = applyGoldenCut;
    applyFibonacci = applyFibonacci;
    fibonacciRadius = fibonacciRadius;
    fibonacciScale = fibonacciScale;
  }
  
  bool applyGoldenCut = false;
  // set applyGoldenCut(bool b) => _applyGoldenCut = b;
  // bool shouldApplyGoldenCut() {
  //   if (applyGoldenCut == null) return false;
  //   else return applyGoldenCut!;
  // }
  
  bool applyFibonacci = false;
  // set applyFibonacci(bool b) => _applyFibonacci = b;
  // bool get applyFibonacci => _applyFibonacci;
  
  double fibonacciScale = 16;
  double fibonacciRadius = 2;
}

class CustomImageDisplay extends StatefulWidget {
  const CustomImageDisplay({
    super.key,
    required this.options,
    required this.image
  });
  
  final ImageProvider image;
  final CustomImageDisplayOptions options;
  
  @override
  State<StatefulWidget> createState() {
    return CustomImageDisplayState();
  }
}

class CustomImageDisplayState extends State<CustomImageDisplay> {
  
  CustomImageDisplayOptions get options => widget.options;
  
  Future<Size> _getDimensionsOfCurrentImage() async {
    final Completer<Size> completer = Completer();
    
    widget.image.resolve(ImageConfiguration.empty).addListener(ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        final myImage = image.image;
        final size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      }
    ));
      
    return completer.future;
  }
  
  @override
  Widget build(BuildContext context) {    
    final screenSize = MediaQuery.of(context).size;
    
    const addedMarginFraction = 0.75;
    final picFrameSize = screenSize * addedMarginFraction;
    
    final imgSizeFuture = _getDimensionsOfCurrentImage();
    
    return FutureBuilder(
      future: imgSizeFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          var targetSize = snapshot.data! as Size;
          
          final heightDifference =  picFrameSize.height / targetSize.height;
          final widthDifference = picFrameSize.width / targetSize.width;
          
          targetSize *= min(heightDifference, widthDifference);
          
          return SizedBox(
              height: targetSize.height,
              width: targetSize.width,
              child: CustomPaint(
                foregroundPainter: _ForegroundPainter(
                  options: options,
                ),
                child: Image(
                  image: widget.image,
                  height: targetSize.height,
                  width: targetSize.width,
                ),
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
  
}

class _ForegroundPainter extends CustomPainter {
  _ForegroundPainter({
    required this.options
  })
  {
    _fibonacciSpiralDrawer = FibonacciSpiralDrawer(
      paint: Paint(),
      spiralScale: options.fibonacciScale,
      spiralRadius: options.fibonacciRadius,
    );
  }
  
  final CustomImageDisplayOptions options;
  
  final GoldenCutDrawer _goldenCutDrawer = GoldenCutDrawer(Paint());
  late FibonacciSpiralDrawer _fibonacciSpiralDrawer;

  @override
  void paint(Canvas canvas, Size size) {
    if (options.applyGoldenCut)
      _goldenCutDrawer.drawGoldenCut(canvas, size);
    
    if (options.applyFibonacci)
      _fibonacciSpiralDrawer.drawFibonacciSpiral(canvas, size);
    
  }

  @override
  bool shouldRepaint(covariant _ForegroundPainter oldDelegate) {
    return oldDelegate.options != options;
  }
}
