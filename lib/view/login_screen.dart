import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/face_mask_luggage.jpg",
                  ),
                  fit: BoxFit.fitHeight)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 130),
              const Padding(
                padding: EdgeInsets.only(left: 26.0),
                child: Text(
                  textAlign: TextAlign.left,
                  "Login",
                  style: TextStyle(fontSize: 70, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                // height: 240,
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 70, bottom: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: StaticColors.transparentGlassContainer),

                child: Column(children: [
                  const CustomTextFormField(
                    label: Text("Phone no."),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextFormField(
                    label: Text("Hospital name"),
                  ),
                  const SizedBox(height: 20),
                  const CustomTextFormField(
                    label: Text("Password"),
                  ),
                  const SizedBox(height: 30),
                  ButtonWidget(
                    buttonLabel: "Login",
                    onPressed: () {},
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
