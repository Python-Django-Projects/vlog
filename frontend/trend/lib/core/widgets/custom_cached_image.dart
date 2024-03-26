import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedImageWidget extends StatelessWidget {
  final double size;
  final double? height;
  final String? fileUrl;
  final String imageUrl;
  final double? radius;
  final bool addBorder;
  final Color? borderColor;
  final double? borderWidth;
  const CustomCachedImageWidget({
    super.key,
    required this.size,
    required this.imageUrl,
    this.radius,
    this.fileUrl,
    this.addBorder = false,
    this.borderColor,
    this.borderWidth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: !addBorder
          ? null
          : BoxDecoration(
              border: Border.all(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth ?? 1.5.sp),
              borderRadius: BorderRadius.circular((radius ?? 300.sp) + 1.5.sp)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 300.sp),
        child: SizedBox(
          width: size,
          height: height ?? size,
          child: SizedBox(
            width: size,
            height: height ?? size,
            child: Padding(
              padding: EdgeInsets.all(addBorder ? 1.sp : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 300.sp),
                child: fileUrl != null
                    ? Image.file(
                        File(fileUrl!),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Theme.of(context).highlightColor,
                          highlightColor: Theme.of(context).dividerColor,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
