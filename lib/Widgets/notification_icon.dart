import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.notifications,
          size: 23,
          color: Colors.white,
        ),
        Positioned(
            left: 18,
            top: -8,
            child: Container(
              padding:
                  const EdgeInsets.all( 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: StaticColors.notificationAlertsNumber,
              ),
              child: const Text(
                "3", //number of notifications -- change it later
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ],
    );
  }
}