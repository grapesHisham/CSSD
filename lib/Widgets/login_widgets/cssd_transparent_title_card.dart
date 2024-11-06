import 'dart:ui';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransparentTitleCardLogin extends StatelessWidget {
  const TransparentTitleCardLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //backgrond container
        Container(
          height: 310.h,
          decoration: BoxDecoration(
            color: hexToColorWithOpacity(hexColor: "5FADBA", opacity: 0.15),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(27),
              bottomRight: Radius.circular(27),
            ),
          ),
        ),
        //blur
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(27),
            bottomRight: Radius.circular(27),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),

              height: 310.h, // Set the height of the blur area
              width: double.infinity,
            ),
          ),
        ),
        // Content on top of the blur
        Container(
          height: 300.h,
          alignment: Alignment.bottomCenter,
          // color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Spacer(),
              const Text(
                "CSSD",
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: const Text(
                  "Where quality control meets life-saving care",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
