import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'constrained_image.dart';
import 'main_page.dart';

class PickPictureFromStoragePage extends StatefulWidget {
  const PickPictureFromStoragePage({super.key});

  @override
  State<StatefulWidget> createState() => _PickPictureFromStoragePageState();
}

class _PickPictureFromStoragePageState
    extends State<PickPictureFromStoragePage> {
  MemoryImage? currentImage;
  
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _onPickFileBtnClick,
              child: const Text(
                'Vælg et billede',
                textScaleFactor: 1.5,
              )
            ),
            if (currentImage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedImage(image: currentImage!)
              ),
            if (currentImage != null) Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                    onPressed: () => _onContinueBtnClick(context),
                    child: const Text(
                      'Næste',
                      textScaleFactor: 1.5,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPickFileBtnClick() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true
    );
    
    if (result != null) {
      final Uint8List? data = result.files[0].bytes;
      
      if (data != null) {
        setState(() {
        currentImage = MemoryImage(data);
        });
      }
    } else {
      
    }
  }
  
  void _onContinueBtnClick(BuildContext context) {
    Navigator.of(context)
      .pushNamed(MainPage.routeName, arguments: MainPageArguments(currentImage!));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key, required this.textChanged});

  final void Function(String) textChanged;

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  String? lastInputValue;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            onChanged: (inputValue) {
              if (lastInputValue != inputValue) {
                lastInputValue = inputValue;                
                widget.textChanged(inputValue);
              }              
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
      ],
    );
  }
}
