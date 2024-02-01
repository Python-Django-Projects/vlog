import 'package:flutter/material.dart';

class InfoSheet extends StatefulWidget {
  const InfoSheet({super.key});

  @override
  State<InfoSheet> createState() => _InfoSheetState();
}

class _InfoSheetState extends State<InfoSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: 260,
      // width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Color.fromARGB(255, 234, 234, 234),
              width: double.infinity,
              // height: 100,
              child: const Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10),
                        child: Text(
                          'Hide',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromARGB(255, 182, 182, 182),
                    thickness: 0.2,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10),
                        child: Text(
                          'Follow / Unfollow',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromARGB(255, 182, 182, 182),
                    thickness: 0.2,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10),
                        child: Text(
                          'Block',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromARGB(255, 182, 182, 182),
                    thickness: 0.2,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10),
                        child: Text(
                          'Report',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color.fromARGB(255, 182, 182, 182),
                    thickness: 0.2,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
