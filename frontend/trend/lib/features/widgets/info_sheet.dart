import 'package:flutter/material.dart';

class InfoSheet extends StatefulWidget {
  const InfoSheet({Key? key}) : super(key: key);

  @override
  State<InfoSheet> createState() => _InfoSheetState();
}

class _InfoSheetState extends State<InfoSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 30.0), // Adjust vertical padding as needed
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 234, 234, 234),
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the radius as needed
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 5, // Adjust the number of items as needed
            separatorBuilder: (BuildContext context, int index) {
              // Check if it's the last item
              if (index == 4) {
                // Return a custom container with a special height
                return Container(
                  height: 20.0, // Set your desired height
                );
              } else {
                // Return a regular Divider
                return Divider(
                  color: Color.fromARGB(255, 182, 182, 182),
                  thickness: 0.2,
                );
              }
            },
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 15,
                    top: (index == 0) ? 20 : 10,
                    bottom: (index == 4) ? 20 : 10),
                child: Text(
                  getStaticText(index), // Use static strings directly
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: (index == 4) ? Colors.red : null,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Use static strings directly based on index
  String getStaticText(int index) {
    switch (index) {
      case 0:
        return 'Hide';
      case 1:
        return 'Follow / Unfollow';
      case 2:
        return 'Block';
      case 3:
        return 'Report';
      case 4:
        return 'Delete';
      default:
        return '';
    }
  }
}
