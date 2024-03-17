import 'package:flutter/material.dart';
import '../widgets/single_vlog_widget.dart';

class VlogsPage extends StatefulWidget {
  const VlogsPage({Key? key}) : super(key: key);

  @override
  State<VlogsPage> createState() => _VlogsPageState();
}

class _VlogsPageState extends State<VlogsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView.builder(
        itemCount: 5,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return const SingleVlogWidget();
        },
      ),
    ));
  }
}
