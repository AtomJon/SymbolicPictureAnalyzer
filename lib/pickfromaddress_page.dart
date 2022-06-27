import 'package:flutter/material.dart';
import 'constrained_image.dart';
import 'image_utils.dart';
import 'main_page.dart';

class PickPictureFromAddressPage extends StatefulWidget {
  const PickPictureFromAddressPage({super.key});

  @override
  State<StatefulWidget> createState() => _PickPictureFromAddressPageState();
}

class _PickPictureFromAddressPageState
    extends State<PickPictureFromAddressPage> {
  ImageProvider? currentImage;

  void testAndAssignImage(String uri) {
    validateImage(uri).then((bool isValidImageFuture) => {
      setState(() {
        if (isValidImageFuture) {
            currentImage = NetworkImage(uri);
          }
          else {
            currentImage = null;
          }
        })
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Skriv venligst adressen ind nedenunder:',
              textScaleFactor: 1.5,
            ),
            _AddressInputForm(textChanged: _onFormChanged),
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

  void _onFormChanged(String text) {
    testAndAssignImage(text);
  }
  
  void _onContinueBtnClick(BuildContext context) {
    Navigator.of(context)
      .pushNamed(MainPage.routeName, arguments: MainPageArguments(currentImage!));
  }
}

class _AddressInputForm extends StatefulWidget {
  const _AddressInputForm({required this.textChanged});

  final void Function(String) textChanged;

  @override
  State<_AddressInputForm> createState() => _AddressInputFormState();
}

class _AddressInputFormState extends State<_AddressInputForm> {
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
              hintText: 'https://smk.com/...',
            ),
          ),
        ),
      ],
    );
  }
}
