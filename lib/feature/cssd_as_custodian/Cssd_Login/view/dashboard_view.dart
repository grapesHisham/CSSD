import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/pie_indicator.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class DashboardView_cssdlogin_cssdcustodian extends StatelessWidget {
  const DashboardView_cssdlogin_cssdcustodian({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text("Cssd PersonName",
            textAlign: TextAlign.left, style: FontStyles.appBarTitleStyle),
        actions: const [
          NotificationIcon()
        ], // add the number of notification function and pass it here later on
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //main column
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Text(
                      "Request Chart",
                      style: FontStyles.bodyPieTitleStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    //pie charts with labels
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: PieChart(PieChartData(sections: [
                          PieChartSectionData(
                            titleStyle: FontStyles.piePercentageValueTextStyle,
                            value: 33,
                            color: StaticColors.pieRequestCount,
                            radius: 30,
                          ),
                          PieChartSectionData(
                            titleStyle: FontStyles.piePercentageValueTextStyle,
                            value: 55,
                            color: StaticColors.pieSterilizationOnProgress,
                            radius: 30,
                          ),
                          PieChartSectionData(
                            titleStyle: FontStyles.piePercentageValueTextStyle,
                            value: 12,
                            color: StaticColors.pieSterilizationComplete,
                            radius: 30,
                          ),
                        ])),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Indicator(
                            color: StaticColors.pieRequestCount,
                            text: 'Request count',
                            isSquare: false,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Indicator(
                            color: StaticColors.pieSterilizationOnProgress,
                            text: 'Sterilization on progress',
                            isSquare: false,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Indicator(
                            color: StaticColors.pieSterilizationComplete,
                            text: 'Sterilization complete',
                            isSquare: false,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    //total stock container which is clickable
                    splashColor: Colors.orange,
                    onTap: () {
                      // create function to go to total stock page
                      if (kDebugMode) {
                        print("total stock container clicked");
                      }
                    },
                    child: Container(
                      //total stock container
                      width: mediaQuery.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 10),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(0, 0, 0, 0.12)),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Column(
                            //title and progress indicator
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Stock in Cssd",
                                style: FontStyles.bodyPieTitleStyle,
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  SizedBox(
                                    width: mediaQuery.width / 1.5,
                                    height: 10,
                                    child: const LinearProgressIndicator(
                                      color:
                                          StaticColors.pieSterilizationComplete,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      backgroundColor:
                                          StaticColors.pieRequestCount,
                                      value: 0.35294117647,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              color: Colors.white,
                              child: Center(
                                  child: FittedBox(
                                child: Text(
                                  "34", // change this value according to total stock
                                  style:
                                      FontStyles.totalStockContainerTextStyle,
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    children: [
                      ButtonWidget(
                        buttonLabel: "Request Timerline",
                        onPressed: () {},
                        buttonTextSize: 14,
                      ),
                      ButtonWidget(
                        buttonLabel: "Add package",
                        onPressed: () {},
                        buttonTextSize: 14,
                      ),
                      ButtonWidget(
                        buttonLabel: "All Reports",
                        onPressed: () {},
                        buttonTextSize: 14,
                      ),
                      ButtonWidget(
                        buttonLabel: "Stock Entry",
                        onPressed: () {},
                        buttonTextSize: 14,
                      ),
                    ],
                  ),
                  RoundedContainer(
                      //requests container
                      containerBody: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //my requests and all container
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Requests", style: FontStyles.bodyPieTitleStyle),
                          ButtonWidget(
                            buttonLabel: "ALL",
                            onPressed: () {
                              //set on pressed to navigate to the all requests page
                            },
                            borderRadius: 12,
                            buttonTextSize: 14,
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 1.0, right: 1.0, top: 10),
                        child: const SingleChildScrollView(
                          child: Column(
                            children: [
                              RoundedContainer(
                                containerBody: Text("data"),
                                containerColor:
                                    StaticColors.requestContainerBackground,
                              ),
                              ClickableCard(),
                             
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
