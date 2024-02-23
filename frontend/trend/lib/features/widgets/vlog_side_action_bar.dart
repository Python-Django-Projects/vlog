import 'package:flutter/material.dart';

class VlogSideAction extends StatelessWidget {
  const VlogSideAction({super.key});
  final double _iconSize = 28;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            iconSize: _iconSize,
          ),
          const Text(
            "1.44k",
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
            iconSize: _iconSize,
          ),
          const Text(
            "83",
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            iconSize: _iconSize,
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            iconSize: _iconSize,
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                  image: NetworkImage(
                      "https://media.istockphoto.com/id/852138778/photo/father-and-son.jpg?s=612x612&w=0&k=20&c=ACPVDoEzNTP1Mf34KvdPCXzTCzDM_CwKFNPVtgrK53w=")),
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
