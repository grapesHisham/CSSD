import 'package:cssd/util/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_marquee/text_marquee.dart';

class ClickableCard extends StatelessWidget {
  final Color? cardColor;
  final Color? cardLeadingContainerColor;
  final Color? cardLeadingContainerTextColor;
  final String requestID;
  final String requestTitle;
  final String requestSubTitle;
  final String requestDate;
  final String reqiestTime;
  final String requestDepartment;

  const ClickableCard({
    super.key,
    this.cardColor,
    this.cardLeadingContainerColor =
        StaticColors.requestContainerNumberBackground,
    this.cardLeadingContainerTextColor = Colors.white,
    required this.requestID,
    required this.requestTitle,
    required this.requestDate,
    required this.reqiestTime,
    required this.requestDepartment,
    required this.requestSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("build called");
    }
    return Card(
      elevation: 1.0, // Adds a shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: InkWell(
        onTap: () {
          // Action when the card is tapped
        },
        child: ListTile(
          leading: Container(
            width: 57,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: cardLeadingContainerColor),
            child: Center(
              child: Text(
                requestID,
                style: TextStyle(color: cardLeadingContainerTextColor),
              ),
            ),
          ),
          title: SizedBox(
              height: 20,
              child: Text(
                requestTitle,
                overflow: TextOverflow.ellipsis,
              )),
          subtitle: SizedBox(
            width: 20,
            child: TextMarquee(
              requestSubTitle,
              spaceSize: 20,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(requestDepartment),
              Text(requestDate),
              Text(reqiestTime)
            ],
          ),
        ),
      ),
    );
  }
}
