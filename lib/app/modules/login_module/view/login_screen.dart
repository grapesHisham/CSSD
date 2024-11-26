import 'dart:developer';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/login_widgets/cssd_transparent_title_card.dart';
import 'package:cssd/Widgets/transparent_blur_conatiner.dart';
import 'package:cssd/app/modules/login_module/controller/login_controller.dart';
import 'package:cssd/app/modules/login_module/view/widgets/bottom_sheet_widget.dart';
import 'package:cssd/app/modules/login_module/view/widgets/clickable_button_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      resizeToAvoidBottomInset: true,
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
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        60 * 4),
                            focusNode: loginController.focusNodePhone,
                            onChanged: (value) {
                              if (value.length == 10) {
                                loginProvider.submitPhoneForHospitalIds(
                                    value, context);
                                FocusScope.of(context).requestFocus(
                                    loginController.focusNodeHospitalName);
                              }
                            },
                            controller:
                                loginProvider.loginPhoneNumberController,
                            decoration: InputDecoration(
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Colors.white.withAlpha(40))),
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              label: const Text("Phone no."),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20.h),
                          //drop down for hospital lists
                          Visibility(
                            visible: loginController.isAdmin ? false : true,
                            replacement: TextFormField(
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(
                                    loginController.focusNodePassword);
                              },
                              controller:
                                  loginController.loginHospitalNameController,
                              focusNode: loginController.focusNodeHospitalName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withAlpha(40)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                border: InputBorder.none,
                                label: loginController
                                            .loginPhoneNumberController
                                            .text
                                            .length ==
                                        10
                                    ? const Text("Please Enter hospital ID")
                                    : Center(
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                                color: Colors.white, size: 35),
                                      ),
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade50,
                                ),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              icon: const SizedBox.shrink(),
                              dropdownColor: Colors.black,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                suffixIconColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withAlpha(40)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                filled: false,
                              ),
                              menuMaxHeight: 400,
                              disabledHint: loginController
                                      .loginPhoneNumberController.text.isEmpty
                                  ? const Text(
                                      "Select hospital",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : LoadingAnimationWidget
                                      .staggeredDotsWave(
                                          color: Colors.white, size: 35),
                              iconDisabledColor: Colors.grey,
                              value: loginController.selectedHospitalDropdown,
                              hint: const Text(
                                "Select a hospital",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              items:
                                  loginController.preLoginResponse.map((items) {
                                return DropdownMenuItem<String>(
                                  value: items.hospitalId.toString(),
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: mediaQuery.width / 1.8),
                                      child: Text(
                                        "${items.hospitalName}",
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                      loginController
                                          .focusNodePassword); //check
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          //password field
                          TextFormField(
                            obscureText: loginController.obscureText,
                            maxLines: 1,
                            controller: loginController.loginPasswordController,
                            focusNode: loginController.focusNodePassword,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            decoration: InputDecoration(
                              isDense: false,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              label: const Text(
                                "Password",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Colors.white,
                              ),
                              suffix: IconButton(
                                  onPressed: () {
                                    loginController.toggleObscureText(
                                        !loginController.obscureText);
                                  },
                                  icon: loginController.obscureText
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                        )),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withAlpha(40)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
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

  
}
