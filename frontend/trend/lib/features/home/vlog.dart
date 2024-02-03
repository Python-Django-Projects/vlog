import 'package:flutter/material.dart';

class VlogPage extends StatefulWidget {
  const VlogPage({super.key});

  @override
  State<VlogPage> createState() => _VlogPageState();
}

class _VlogPageState extends State<VlogPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Vlog Page'),
      ),
    );
  }
}
