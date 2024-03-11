import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/core/resources/assets_manager.dart';

class FullLogo extends StatelessWidget {
  const FullLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImgAssets.logoDarkSvg,
    );
  }
}
