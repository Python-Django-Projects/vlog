import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/core/resources/assets_manager.dart';

class FullLogo extends StatelessWidget {
  final double? size;
  const FullLogo({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: SvgPicture.asset(
        ImgAssets.logoDarkSvg,
        height: size,
      ),
    );
  }
}
