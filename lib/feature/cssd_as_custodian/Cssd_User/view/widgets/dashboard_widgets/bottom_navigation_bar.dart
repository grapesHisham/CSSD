import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/dashboard_controller.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/dashboard_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/pickup_page.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/requests_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/sterilization_view.dart';
import 'package:cssd/util/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarDashboard extends StatelessWidget {
  const BottomNavigationBarDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dashboardProvider =
        Provider.of<DashboardController>(context, listen: false);
    void onBottomItemTap(int index) {
      dashboardProvider.updateBottomNav(index);
    }

    List<Widget> screens = [
      const DashboardViewCssdCssCssdLogin(),
      const RequestsViewCssdCussCssdLogin(),
      SterilizationViewCssdCussCssdLogin(),
      const PickupPageCssdCussCssdLogin(),
    ];

    return Scaffold(
      bottomNavigationBar: Consumer<DashboardController>(
          builder: (context, dashboardController, child) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.home_12_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.branch_request_16_filled),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
                icon: Icon(FluentIcons.paint_brush_32_regular),
                label: 'Sterilize',
                activeIcon: Icon(FluentIcons.paint_brush_12_filled)),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.tray_item_add_20_filled),
              label: 'Pickup',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.vehicle_truck_profile_16_filled),
              label: 'Issue',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.timeline_24_filled),
              label: 'Timeline',
            ),
          ],
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(255, 116, 116, 116),
          currentIndex: dashboardController.selectedIndexBotomNav,
          selectedItemColor: StaticColors.scaffoldBackgroundcolor,
          onTap: onBottomItemTap,
        );
      }),
      body: Consumer<DashboardController>(
        builder: (context, dashboardController, child) =>
            screens[dashboardController.selectedIndexBotomNav],
      ),
    );
  }
}
