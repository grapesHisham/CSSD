import 'dart:developer';

import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/login_widgets/cssd_transparent_title_card.dart';
import 'package:cssd/Widgets/transparent_blur_conatiner.dart';
import 'package:cssd/app/modules/login_module/controller/login_provider.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  // @override
  // void initState() {
  //   super.initState();
  //   final loginProvider = Provider.of<LoginController>(context, listen: false);
  //   loginProvider.loginPhoneNumberController.addListener(() {
  //     if (loginProvider.loginPhoneNumberController.text.length == 10) {
  //       loginProvider.submitPhoneForHospitalIds(
  //           loginProvider.loginPhoneNumberController.text);
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginController>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.height,
          width: mediaQuery.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_wallpaper.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.20),

                //title notch
                child: const TransparentTitleCardLogin(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.10),
                child: TransparentBlurConatinerWidget(
                  borderRadius: BorderRadius.circular(50),
                  bodyOfTransparentContainer: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Consumer<LoginController>(
                        builder: (context, loginController, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                            onChanged: (value) {
                              if (value.length == 10) {
                                loginProvider.submitPhoneForHospitalIds(
                                    value, context);
                              }
                            },
                            maxLendgth: 10,
                            controller:
                                loginProvider.loginPhoneNumberController,
                            prefixIcon: Icons.phone,
                            label: const Text("Phone no."),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20.h),
                          Visibility(
                            visible: loginController.isAdmin ? false : true,
                            replacement: CustomTextFormField(
                              controller:
                                  loginController.loginHospitalNameController,
                              hintText: "Please Enter hospital ID",
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .white, // Border when the field is not focused
                                      width: 1.0,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .red, // Border when the field is not focused
                                      width: 1.0,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .white, // Border when the field is not focused
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 1.0))),
                              menuMaxHeight: 400,
                              disabledHint:
                                  const Text("Enter a valid phone number"),
                              iconDisabledColor: Colors.grey,
                              value: loginController.selectedHospitalDropdown,
                              hint: const Text("Select a hospital"),
                              items:
                                  loginController.preLoginResponse.map((items) {
                                return DropdownMenuItem<String>(
                                  value: items.hospitalId.toString(),
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: mediaQuery.width / 1.8),
                                      child: Text(
                                        "${items.hospitalName}",
                                      )),
                                );
                              }).toList(),
                              onChanged: (data) {
                                if (data != null) {
                                  log("$data");
                                  loginController.updateSelectedHospital(data);
                                  loginController
                                      .loginHospitalNameController.text = data;
                                  loginProvider.submitPhoneForHospitalIds(
                                      data, context);
                                  log(data);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            controller: loginController.loginPasswordController,
                            prefixIcon: Icons.password,
                            prefixIconOnTap: () {
                              loginController.toggleObscureText(
                                  !loginController.obscureText);
                            },
                            obscureText: loginController.obscureText,
                            label: const Text("Password"),
                          ),
                          SizedBox(height: 30.h),
                          ButtonWidget(
                            borderRadius: 10,
                            buttonColor: StaticColors.defaultButton,
                            buttonLabel: "Login",
                            onPressed: () {
                              loginProvider.login(context);
                              
                            },
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
