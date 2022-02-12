import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blur Nav Bar',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
