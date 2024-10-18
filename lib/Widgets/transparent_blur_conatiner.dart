import 'dart:ui';

import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransparentBlurConatinerWidget extends StatelessWidget {
  final Widget bodyOfTransparentContainer;
  final Color colorOfTransparentContainer;
  final String? hexColor;
  final double? opacity;
  final BorderRadius borderRadius;
  final double? heightOfContainer;
  final EdgeInsets? containerPadding;
  final EdgeInsets? containerMargin;

  const TransparentBlurConatinerWidget({
    super.key,
    required this.bodyOfTransparentContainer,
    this.hexColor,
    this.opacity,
    required this.borderRadius,
    this.heightOfContainer = 310,
    this.colorOfTransparentContainer = const Color(0x265fadba),
    this.containerPadding,
    this.containerMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //backgrond container
        Container(
          padding: containerPadding,
          margin: containerMargin,
          height: heightOfContainer, // pass height
          decoration: BoxDecoration(
              color: colorOfTransparentContainer, //pass color
              borderRadius: borderRadius),
        ),
        //blur
        ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),

              height: heightOfContainer, // Set the height of the blur area
              width: double.infinity,
            ),
          ),
        ),
        // Content on top of the blur / body of the container
        bodyOfTransparentContainer
      ],
    );
  }
}
