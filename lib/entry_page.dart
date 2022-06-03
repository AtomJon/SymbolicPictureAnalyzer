import 'package:flutter/material.dart';

import 'pickfromaddress_page.dart';

class EntrancePage extends StatelessWidget {
  const EntrancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              'Vælg venligst en af mulighederne for at vælge billedet',
              textScaleFactor: 2,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () => _onAddressChoiceClick(context),
                  child: const Text(
                    'Vælg billede fra adresse',
                    textScaleFactor: 1.5,
                  ),
                )
              ],
            )
          ]),
        ));
  }
}

void _onAddressChoiceClick(BuildContext context) {
  Navigator.of(context)
      .push(_createRouteToPage(const PickPictureFromAddressPage()));
}

Route<void> _createRouteToPage(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
