import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/resources/assets_manager.dart';
import '../../../../core/utils/feed_player/feed_player.dart';
import '../../../../core/widgets/custom_cached_image.dart';

class SingleVlogWidget extends StatefulWidget {
  const SingleVlogWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleVlogWidget> createState() => _SingleVlogWidgetState();
}

class _SingleVlogWidgetState extends State<SingleVlogWidget> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 12.sp,
    );
    return Stack(
      children: [
        const FeedPlayer(
          videoUrl:
              "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
          thumbnailUrl:
              "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.sp, horizontal: 15.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp).copyWith(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomCachedImageWidget(
                                size: 35.sp,
                                addBorder: true,
                                imageUrl:
                                    "https://www.thefashionisto.com/wp-content/uploads/2021/03/Attractive-Man-Selfie-Sunglasses-Smiling.jpg"),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * .6.sp,
                                child: Text(
                                  "rabeeomran",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // if (widget.post.description.trim().isEmpty)
                        //    SizedBox(height: 4),
                        // if (widget.post.description.trim().isNotEmpty)
                        SizedBox(height: 8.sp),
                        // if (widget.post.description.trim().isNotEmpty)
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .6.sp,
                          child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: ExpandableText(
                                "this is my vlog description, this is my vlog description, this is my vlog description, this is my vlog description",
                                style: TextStyle(
                                    fontSize: 12.5.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                expandText: 'more',
                                collapseText: 'less',
                                expandOnTextTap: true,
                                collapseOnTextTap: true,
                                maxLines: 3,
                                linkColor: Colors.grey,
                              )),
                        ),
                        SizedBox(height: 8.sp),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        //like btn
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.sp),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                ImgAssets.heartIconSVG,
                                width: 27.sp,
                                height: 27.sp,
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                              SizedBox(height: 4.sp),
                              Text(
                                "15",
                                style: textStyle1,
                              ),
                            ],
                          ),
                        ),

                        //comment btn
                        Padding(
                          padding: EdgeInsets.only(bottom: 25.sp),
                          child: InkWell(
                            onTap: () async {},
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  ImgAssets.commentsIconSVG,
                                  width: 25.sp,
                                  height: 25.sp,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                ),
                                SizedBox(height: 4.sp),
                                Text(
                                  "7",
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),

                        //save btn
                        Padding(
                          padding: EdgeInsets.only(bottom: 32.sp),
                          child: InkWell(
                            onTap: () async {},
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  ImgAssets.shareIconSVG,
                                  width: 21.sp,
                                  height: 21.sp,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                ),
                                SizedBox(height: 4.sp),
                                Text(
                                  "Share".hardcoded,
                                  style: textStyle1.copyWith(fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
