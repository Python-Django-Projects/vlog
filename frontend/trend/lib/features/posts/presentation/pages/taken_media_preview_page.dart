import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/resources/assets_manager.dart';
import 'package:trend/features/posts/data/models/post_media_type_enum.dart';

class TakenMediaPreviewPage extends StatefulWidget {
  final List<File> files;
  final PostMediaType mediaType;
  const TakenMediaPreviewPage({
    Key? key,
    required this.files,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<TakenMediaPreviewPage> createState() => _TakenMediaPreviewPageState();
}

class _TakenMediaPreviewPageState extends State<TakenMediaPreviewPage> {
  bool _isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  void peformAddPost() async {
    setState(() {
      _isLoading = true;
    });
    // await addPost(
    //     File(widget.file.path),
    //     _descriptionController.text.isEmpty ? "" : _descriptionController.text,
    //     context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "New post".hardcoded,
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => peformAddPost(),
            child: Text(
              "Post",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          )
        ],
      ),
      // POST FORM
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_isLoading) const LinearProgressIndicator(),
            const Divider(),
            Row(
              mainAxisAlignment: widget.files.length > 1
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.files.length > 1
                    ? const SizedBox()
                    : SizedBox(
                        height: 50.sp,
                        width: 50.sp,
                        child: widget.mediaType == PostMediaType.video
                            ? Transform.scale(
                                scale: .5.sp,
                                child: SvgPicture.asset(
                                  ImgAssets.videoPlayIconSVG,
                                  width: 17.sp,
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color!,
                                      BlendMode.srcIn),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.sp),
                                child: Image.file(
                                  widget.files.first,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: widget.files.length > 1 ? 8.sp : 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        (widget.files.length > 1 ? .6.w : 0.75.w),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Write a caption...".hardcoded,
                          border: InputBorder.none),
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.files.length > 1)
              CarouselSlider(
                items: widget.files.map((file) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 10.sp),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 7.sp,
                      height: MediaQuery.of(context).size.width * 7.sp,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.sp),
                          child: Image.file(
                            File(file.path),
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.width,
                    viewportFraction: widget.files.length > 1 ? .9 : 1,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    onPageChanged: (i, r) {}),
              ),
          ],
        ),
      ),
    );
  }
}
