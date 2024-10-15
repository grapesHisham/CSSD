import 'package:flutter/material.dart';

class doctorProfile extends StatelessWidget {
  const doctorProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      height: 170,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
        Container(
          width: 125.0,
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Positioned(
          bottom: -5.0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/alosious edited1.png',
            fit: BoxFit.contain,
          ),
        ),
      ]),
    );
  }
}
