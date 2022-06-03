import 'package:flutter/material.dart';
import 'image_utils.dart';
import 'main_page.dart';

class PickPictureFromAddressPage extends StatefulWidget {
  const PickPictureFromAddressPage({super.key});

  @override
  State<StatefulWidget> createState() => _PickPictureFromAddressPageState();
}

class _PickPictureFromAddressPageState
    extends State<PickPictureFromAddressPage> {
  String? currentUri;

  void testAndAssignImage(String uri) {
    validateImage(uri).then((bool isValidImageFuture) => {
      setState(() {
        if (isValidImageFuture) {
            currentUri = uri;
          }
          else {
            currentUri = null;
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
              'Skriv venligst addressen ind nedenunder:',
              textScaleFactor: 1.5,
            ),
            MyCustomForm(textChanged: _onFormChanged),
            if (currentUri != null) Image.network(currentUri!),
            if (currentUri != null) Padding(
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
      .pushNamed(MainPage.routeName, arguments: MainPageArguments(NetworkImage(currentUri!)));
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
