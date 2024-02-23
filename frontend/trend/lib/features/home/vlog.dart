import 'package:flutter/material.dart';
import 'package:trend/features/widgets/vlog_details.dart';
import 'package:trend/features/widgets/vlog_side_action_bar.dart';

class VlogPage extends StatefulWidget {
  const VlogPage({Key? key}) : super(key: key);

  @override
  State<VlogPage> createState() => _VlogPageState();
}

class _VlogPageState extends State<VlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Vlog',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    "https://media.istockphoto.com/id/852138778/photo/father-and-son.jpg?s=612x612&w=0&k=20&c=ACPVDoEzNTP1Mf34KvdPCXzTCzDM_CwKFNPVtgrK53w=",
                  ),
                  fit: BoxFit.fill),
            ),
            child: const Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(flex: 14, child: VlogDetails()),
                          Flexible(
                            flex: 2,
                            child: VlogSideAction(),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
