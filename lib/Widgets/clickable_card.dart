import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  const ClickableCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adds a shadow to the card
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
              shape: BoxShape.circle,
                 color: StaticColors.requestContainerNumberBackground),
            child: Center(
              child: Text("239"),
            ),
          ), // Icon on the left
          title: Text('Title'), // Main title
          subtitle: Text('Subtitle'), // Subtitle under the title
          trailing: Text('Department name Text'), // Text on the right
        ),
      ),
    );
  }
}
