import 'package:flutter/material.dart';

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

class _MainPageState extends State<MainPage> {  
  final CustomImageDisplayOptions options = CustomImageDisplayOptions();
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as MainPageArguments?;
    ArgumentError.checkNotNull(args, 'MainPageNavigationArguments');
    
    final image = CustomImageDisplay(
      image: args!.image,
      options: options
    );
    
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Længde Af Fibonacci'),
              Slider(
                label: options.fibonacciScale.toString(),
                value: options.fibonacciScale,
                onChanged: (double v) => setState(() {
                  options.fibonacciScale = v;
                }),
                max: 100,
              ),
              const Text('Størrelse Af Fibonacci'),
              Slider(
                label: options.fibonacciRadius.toString(),
                value: options.fibonacciRadius,
                onChanged: (double v) => setState(() {
                  options.fibonacciRadius = v;
                }),
                min: 1,
                max: 16,
              ),
            ],
          ),
          Center(child: image),
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
                icon: const Icon(Icons.circle),
                onPressed: _fibonacciBtnClick,
                tooltip: 'Fibonacci Spiral',
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
}
