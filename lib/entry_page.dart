import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pickfromaddress_page.dart';
import 'pickfromstorage_page.dart';

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
                if (!kIsWeb)
                  OutlinedButton(
                    onPressed: () => _onChoiceClick(
                        context, const PickPictureFromAddressPage()),
                    child: const Text(
                      'Vælg et billede fra adresse',
                      textScaleFactor: 1.5,
                    ),
                  ),
                OutlinedButton(
                  onPressed: () => _onChoiceClick(
                      context, const PickPictureFromStoragePage()),
                  child: const Text(
                    'Vælg et billede fra fil',
                    textScaleFactor: 1.5,
                  ),
                )
              ],
            )
          ]),
        ));
  }
}

void _onChoiceClick(BuildContext context, Widget page) {
  Navigator.of(context).push(_createRouteToPage(page));
}

Route<void> _createRouteToPage(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
