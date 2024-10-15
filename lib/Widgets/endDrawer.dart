import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/doctorProfileImage.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';

Drawer endDrawer() {
  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
            padding: EdgeInsets.all(10.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                doctorProfile(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1),
                    Text(
                      "Dr. Dev",
                      style: FontStyles.bodyPieTitleStyle,
                    ), // change to logedin user name
                    Text("SPD Technician"), // change their designation

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // const SizedBox(width: 40,),

                        ButtonWidget(
                          buttonLabel: 'Logout',
                          onPressed: () {},
                          buttonColor: StaticColors.cancelButton,
                          borderRadius: 10,
                          buttonTextSize: 16,
                          buttonPadding: EdgeInsets.all(2), // set padding
                          buttonSize: Size(120, 20), // set width and heigth
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
        draweritems(
            drawerIcon: Icon(Icons.home),
            drawerTitle: Text("Home"),
            onTap: () {}),
        draweritems(
          drawerIcon: Icon(Icons.my_library_books_rounded),
          drawerTitle: Text("Reports"),
          onTap: () {},
        ),
        draweritems(
          drawerIcon: Icon(Icons.storage),
          drawerTitle: Text("Stock management / Entry"),
          onTap: () {},
        ),
        draweritems(
          drawerIcon: Icon(Icons.shopping_bag_rounded),
          drawerTitle: Text("Add package"),
          onTap: () {},
        ),
        draweritems(
          drawerIcon: Icon(Icons.electrical_services_outlined),
          drawerTitle: Text("Add machine information"),
          onTap: () {},
        ),
      ],
    ),
  );
}


Widget draweritems(
    {required Icon drawerIcon, required Text drawerTitle, Function? onTap}) {
  return ListTile(
    leading: drawerIcon,
    title: drawerTitle,
    onTap: () {
      onTap;
    },
  );
}
