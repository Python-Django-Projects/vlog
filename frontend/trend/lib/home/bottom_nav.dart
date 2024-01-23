import 'package:flutter/material.dart';
import 'package:trend/home/home_page.dart';

class BottomNavMenu extends StatefulWidget {
  const BottomNavMenu({super.key});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  int index = 0;
  final screens = [
    const HomePage(),
    const Center(child: Text('lable')),
    const Center(child: Text('pro')),
    const Center(child: Text('ooo')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 0,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'label'),
          NavigationDestination(icon: Icon(Icons.shop_rounded), label: 'label'),
          NavigationDestination(
              icon: Icon(Icons.mail_lock_outlined), label: 'profile'),
          NavigationDestination(icon: Icon(Icons.home), label: 'profile'),
        ],
      ),
      body: screens[index],
    );
  }
}
