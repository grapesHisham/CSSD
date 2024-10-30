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
                            visible: loginController.loginPhoneNumberController
                                        .text.length ==
                                    10
                                ? true
                                : false,
                            child: CustomTextFormField(
                              //data received and received data is empty = not readonly
                              //data received and received data is not empty = readonly
                              //data not received = readonly 
                              
                              isReadOnly: (loginController
                                              .preLoginResponseDataReceived ==
                                          true &&
                                      loginController.preLoginResponse.isEmpty)
                                  ? false
                                  : true,
                              controller:
                                  loginProvider.loginHospitalNameController,
                              prefixIcon: Icons.medical_services,
                              label: const Text("Hospital name"),
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
                              loginProvider.submitPhoneForHospitalIds(
                                  loginProvider.loginPhoneNumberController.text,
                                  context);
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
