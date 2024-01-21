import 'package:flutter/material.dart';
import 'package:trend/widgets/bottomNavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromARGB(255, 179, 179, 179),
            title: Text(
              'TREND',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
            ),
            centerTitle: false,
            floating: true,
          ),
        ],
      ),
    );
  }
}
