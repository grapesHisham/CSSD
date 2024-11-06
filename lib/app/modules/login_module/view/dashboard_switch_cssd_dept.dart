import 'package:cssd/Widgets/promo_card.dart';
import 'package:flutter/material.dart';

class SwitchBetweenCssdAndDepartment extends StatelessWidget {
  const SwitchBetweenCssdAndDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         
          children: [
            PromoCard(cssdNetworkImage: true,deptNetworkImage: false,),
            SizedBox(height: 20,),
            PromoCard(cssdNetworkImage: false,deptNetworkImage: true,)
          ],
        ),
      ),
    );
  }
}