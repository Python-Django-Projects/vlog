import 'package:flutter/material.dart';

class VlogPage extends StatefulWidget {
  const VlogPage({Key? key}) : super(key: key);

  @override
  State<VlogPage> createState() => _VlogPageState();
}

class _VlogPageState extends State<VlogPage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          child: Center(
            child: PageView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              children: [
                Center(child: Text('page 1')),
                Center(child: Text('page 2')),
                Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1621155346337-1d19476ba7d6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGltYWdlfGVufDB8fDB8fHww",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
