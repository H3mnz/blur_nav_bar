import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/blur_nav_bar.dart';
import 'component/blur_nav_bar_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  int currentIndex = 0;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Text(
          '$currentIndex',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: BlurNavBar(
        currentIndex: currentIndex,
        onChanged: (index) => setState(() => currentIndex = index),
        items: [
          BlurNavBarItem(icon: CupertinoIcons.home, label: 'Home'),
          BlurNavBarItem(icon: CupertinoIcons.waveform, label: 'Waveform'),
          BlurNavBarItem(icon: CupertinoIcons.shopping_cart, label: 'Cart'),
          BlurNavBarItem(icon: CupertinoIcons.person, label: 'Profile'),
        ],
      ),
    );
  }
}
