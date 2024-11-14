import 'dart:developer';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/login_widgets/cssd_transparent_title_card.dart';
import 'package:cssd/Widgets/transparent_blur_conatiner.dart';
import 'package:cssd/app/modules/login_module/controller/login_provider.dart';
import 'package:cssd/app/modules/login_module/view/widgets/clickable_button_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                          // Phone number
                          CustomTextFormField(
                            scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+60*4),
                            focusNode: loginController.focusNodePhone,
                            onChanged: (value) {
                              if (value.length == 10) {
                                loginProvider.submitPhoneForHospitalIds(
                                    value, context);
                                FocusScope.of(context).requestFocus(
                                    loginController.focusNodeHospitalName);
                                /* FocusManager.instance.primaryFocus?.unfocus(); */
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
                          //drop down for hospital lists
                          Visibility(
                            visible: loginController.isAdmin ? false : true,
                            replacement: CustomTextFormField(
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(
                                    loginController.focusNodePassword);
                              },
                              focusNode: loginController.focusNodeHospitalName,
                              controller:
                                  loginController.loginHospitalNameController,
                              hintText: loginController
                                          .loginPhoneNumberController
                                          .text
                                          .length ==
                                      10
                                  ? "Please Enter hospital ID"
                                  : "Enter 10 digits",
                            ),
                            child: DropdownButtonFormField<String>(
                              // focusNode:loginController.focusNodeHospitalName, //check
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
                              disabledHint: loginController
                                      .loginPhoneNumberController.text.isEmpty
                                  ? const Text("Enter phone to list hospitals")
                                  : Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                              color: Colors.black, size: 35),
                                    ),
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
                                  log(data);
                                  loginController.updateSelectedHospital(data);
                                  loginController
                                      .loginHospitalNameController.text = data;
                                  log(data);
                                  FocusScope.of(context).requestFocus(
                                      loginController.focusNodePassword); //check
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          //password field
                          CustomTextFormField(
                            maxLines: 1,
                            focusNode: loginController.focusNodePassword,
                            suffix: IconButton(
                                onPressed: () {
                                  loginController.toggleObscureText(
                                      !loginController.obscureText);
                                },
                                icon: loginController.obscureText
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey.shade300,
                                      )
                                    : const Icon(Icons.visibility)),
                            controller: loginController.loginPasswordController,
                            prefixIcon: Icons.password,
                            obscureText: loginController.obscureText,
                            label: const Text("Password"),
                          ),
                          SizedBox(height: 30.h),
                          // login button
                          ButtonWidget(
                            borderRadius: 10,
                            buttonColor: StaticColors.defaultButton,
                            buttonLabel: "Login",
                            onPressed: () async {
                              if (loginController.loginPhoneNumberController
                                      .text.isEmpty ||
                                  loginController.loginHospitalNameController
                                      .text.isEmpty ||
                                  loginController
                                      .loginPasswordController.text.isEmpty) {
                                showSnackBarNoContext(
                                    isError: true,
                                    msg: "Enter details to login");
                              }

                              bool hasBothPrivileges =
                                  await loginProvider.login(context);
                              log("showing bottom sheet : $hasBothPrivileges");
                              if (hasBothPrivileges) {
                                showOptionsBottomSheet(context, mediaQuery);
                              }
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

  Future<dynamic> showOptionsBottomSheet(
      BuildContext context, Size mediaQuery) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          width: mediaQuery.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Choose Your Department",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedHoverButton(
                      ontap: () {
                        /*  Navigator.pushNamedAndRemoveUntil(context,Routes.bottomNavBarDashboardCssdUser,(Route route) => false); */
                        Navigator.pushNamed(
                          context,
                          Routes.bottomNavBarDashboardCssdUser,
                        );
                      },
                      backgroundColor:
                          hexToColorWithOpacity(hexColor: "356745"),
                      hoverColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      buttonContent: Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: Text(
                            "CSSD User",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      containerHeight: 60,
                      containerWidth: 130,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    AnimatedHoverButton(
                      ontap: () {
                        /* Navigator.pushNamedAndRemoveUntil(
                                                    context,
                                                    Routes.dashboardViewCssdCussDeptUser,
                                                    (Route route) => false); */

                        Navigator.pushNamed(
                          context,
                          Routes.dashboardViewCssdCussDeptUser,
                        );
                      },
                      backgroundColor:
                          hexToColorWithOpacity(hexColor: "356745"),
                      hoverColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      buttonContent: Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: Text(
                            "Department User",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      containerHeight: 60,
                      containerWidth: 140,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
