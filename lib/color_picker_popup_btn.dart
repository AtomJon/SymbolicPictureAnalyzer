import 'package:flutter/material.dart';

class ColorPickerPopupButton extends StatelessWidget {
  const ColorPickerPopupButton({super.key, required this.text, required this.colorPicker});
  
  final String text;
  final Widget colorPicker;
  
  @override
  Widget build(BuildContext context) {
    return
     OutlinedButton(
      child: Text(text),
      onPressed: () => 
        showDialog(context: context, builder: (w) =>
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) => 
              SizedBox(
                width: constraints.maxWidth / 3,
                height: constraints.maxWidth / 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: const Border.fromBorderSide(BorderSide(width: 6, color: Colors.blue)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: const Border.fromBorderSide(BorderSide(width: 4, color: Colors.blue))
                        ),
                        child: colorPicker
                      ),
                      OutlinedButton(
                        child: const Text('Luk'),
                        onPressed: () => Navigator.of(w, rootNavigator: true).pop(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ),
    );
  }
}
