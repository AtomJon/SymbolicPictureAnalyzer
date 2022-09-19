import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'color_picker_popup_btn.dart';
import 'custom_image_display/custom_image_display.dart';

class MainPageArguments {
  const MainPageArguments(this.image);
  
  final ImageProvider image;
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });
  
  static const routeName = '/mainPage';

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

const AvailableColors = [Colors.red, Colors.deepOrange, Colors.orange, Colors.green, Colors.indigo, Colors.blue, Color.fromARGB(255, 199, 199, 199), Colors.black];

class _MainPageState extends State<MainPage> {  
  final CustomImageDisplayOptions options = CustomImageDisplayOptions();
  
  bool showFibonacciColorPicker = false;
  
  CustomImageDisplay? imageDisplay;
  
  final screenshotStream = StreamController<String>(); 
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as MainPageArguments?;
    
    if (args == null) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    
      ArgumentError.checkNotNull(args, 'MainPageNavigationArguments');
    }
    
    options.image = args!.image;
    
    imageDisplay = CustomImageDisplay(
      screenshotStream: screenshotStream,
      options: options
    );
    
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Det Gyldne Snit', textScaleFactor: 1.8,),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 8.0),
                child: ColorPickerPopupButton(
                  text: 'Vælg Farve',
                  colorPicker: BlockPicker(
                    pickerColor: options.goldenCutColor,
                    onColorChanged: _goldenCutColorBtn,
                    availableColors: AvailableColors,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              const Text('Fibonacci Spiral', textScaleFactor: 1.8,),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Text('Rotation'),
              Slider(
                label: options.fibonacciRotationDegrees.toString(),
                value: options.fibonacciRotationDegrees,
                onChanged: (double v) => setState(() {
                  options.fibonacciRotationDegrees = v;
                }),
                max: 360,
              ),
              const Text('Størrelse'),
              Slider(
                label: options.fibonacciScale.toString(),
                value: options.fibonacciScale,
                onChanged: (double v) => setState(() {
                  options.fibonacciScale = v;
                }),
                min: 0.1,
                max: 2,
              ),              
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: OutlinedButton(
                  onPressed: () => setState(() => options.applyFibonacciDragWidget ^= true),
                  child: const Text('Skjul/Vis Håndtag')
                ),
              ),
              ColorPickerPopupButton(
                text: 'Vælg Farve',
                colorPicker: BlockPicker(
                  pickerColor: options.fibonacciColor,
                  onColorChanged: _fibonacciColorBtn,
                  availableColors: AvailableColors,
                ),
              ),
            ],
          ),
          Center(child: imageDisplay),
        ],
      ),
      appBar: AppBar(),
      persistentFooterButtons: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.grid_goldenratio),
                onPressed: _goldenRatioBtnClick,
                tooltip: 'Det Gyldne Snit',
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.storm),
                onPressed: _fibonacciBtnClick,
                tooltip: 'Fibonacci Spiral',
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: _screenshotBtnClick,
                tooltip: 'Screenshot',
              ),
            ],
          )
      ],
    );
  }

  void _goldenRatioBtnClick() {
    setState(() {
      options.applyGoldenCut ^= true;
    });
  }

  void _fibonacciBtnClick() {
    setState(() {
      options.applyFibonacci ^= true;
    });
  }
  
  void _screenshotBtnClick() {
    screenshotStream.add('take_screenshot');
  }

  void _fibonacciColorBtn(Color c) {
    setState(() {
      options.fibonacciColor = c;
    });
  }

  void _goldenCutColorBtn(Color c) {
    setState(() {
      options.goldenCutColor = c;
    });
  }
}
