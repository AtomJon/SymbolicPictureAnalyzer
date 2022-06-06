import 'package:flutter/material.dart';

import 'custom_image_display.dart';

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
  // Image get image => widget.image;
  
  bool goldenCutOn = false;
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as MainPageArguments?;
    ArgumentError.checkNotNull(args, 'MainPageNavigationArguments');
    
    final image = CustomImageDisplay(
      image: args!.image,
      applyGoldenCut: goldenCutOn,
    );
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: image),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.grid_goldenratio,),
                onPressed: _goldenRatioBtnClick,
                tooltip: 'Det Gyldne Snit',
              )
            ],
          )
        ],
      ),
      appBar: AppBar(),
    );
  }

  void _goldenRatioBtnClick() {
    setState(() {
      goldenCutOn = !goldenCutOn;
    });
  }
}
