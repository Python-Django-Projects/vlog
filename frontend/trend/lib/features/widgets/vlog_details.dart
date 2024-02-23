import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class VlogDetails extends StatelessWidget {
  const VlogDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          title: Text(
            'hello - follow',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(
                "https://media.istockphoto.com/id/852138778/photo/father-and-son.jpg?s=612x612&w=0&k=20&c=ACPVDoEzNTP1Mf34KvdPCXzTCzDM_CwKFNPVtgrK53w="),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: ExpandableText(
            "demo text demo text demo text demo text demo text demo text demo text demo text demo text demo text demo text ",
            style: TextStyle(
                fontSize: 12.5,
                color: Colors.white,
                fontWeight: FontWeight.w400),
            expandText: 'more',
            collapseText: 'less',
            expandOnTextTap: true,
            collapseOnTextTap: true,
            maxLines: 1,
            linkColor: Colors.grey,
          ),
        ),
        ListTile(
          dense: true,
          minLeadingWidth: 0,
          horizontalTitleGap: 5,
          title: Text(
            'music title - original music',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          leading: Icon(
            Icons.graphic_eq_outlined,
            size: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
