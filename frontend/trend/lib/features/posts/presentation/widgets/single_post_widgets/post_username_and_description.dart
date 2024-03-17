import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostUsernameAndDescription extends StatefulWidget {
  const PostUsernameAndDescription({
    Key? key,
  }) : super(key: key);

  @override
  State<PostUsernameAndDescription> createState() =>
      _PostUsernameAndDescriptionState();
}

class _PostUsernameAndDescriptionState
    extends State<PostUsernameAndDescription> {
  List<TextSpan> buildDescriptionText() {
    const description = " this is post description";
    final RegExp exp = RegExp(r'\B#\w\w+');
    final Iterable<Match> matches = exp.allMatches(description);

    final List<TextSpan> textSpans = [];
    int previousEnd = 0;

    for (Match match in matches) {
      final String hashtag = match.group(0)!;
      final int start = match.start;
      final int end = match.end;

      if (start > previousEnd) {
        textSpans.add(TextSpan(
            text: description.substring(previousEnd, start),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.3.sp,
            )));
      }

      textSpans.add(TextSpan(
        text: hashtag,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 1.3.sp,
          color: Theme.of(context).primaryColor,
        ),
        recognizer: TapGestureRecognizer()..onTap = () {},
      ));

      previousEnd = end;
    }

    if (previousEnd < description.length) {
      textSpans.add(TextSpan(
          text: description.substring(previousEnd),
          style: TextStyle(
            fontSize: 14.sp,
            height: 1.3.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.displayLarge!.color!,
          )));
    }

    return textSpans;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "rabeeomran ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).textTheme.displayLarge!.color!),
                  ),
                  ...buildDescriptionText(),
                ],
              ),
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}
