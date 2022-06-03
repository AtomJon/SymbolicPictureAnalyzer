import 'package:flutter/material.dart';

import 'entry_page.dart';
import 'main_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: const EntrancePage(),
      routes: {
        MainPage.routeName:(context) => 
          const MainPage(),
      },
    ),
  );
}
