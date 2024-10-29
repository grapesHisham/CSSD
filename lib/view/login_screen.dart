import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/login_widgets/cssd_transparent_title_card.dart';
import 'package:cssd/Widgets/transparent_blur_conatiner.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/login_provider.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         CustomTextFormField(
                        
                          validator: (phoneNumber) {
                           if (phoneNumber!.length == 10 ) {
                             //call api to  check if the number is registered
                             

                           }
                          },
                          prefixIcon: Icons.phone,
                          label: Text("Phone no."),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20.h),
                        const CustomTextFormField(
                          prefixIcon: Icons.medical_services,
                          label: Text("Hospital name"),
                        ),
                        SizedBox(height: 20.h),
                        Consumer<LoginController>(
                            builder: (context, loginController, child) {
                          return CustomTextFormField(
                            controller: loginController.loginPasswordController,
                            prefixIcon: Icons.password,
                            prefixIconOnTap: () {
                              loginController.toggleObscureText(
                                  !loginController.obscureText);
                            },
                            obscureText: loginController.obscureText,
                            label: const Text("Password"),
                          );
                        }),
                        SizedBox(height: 30.h),
                        ButtonWidget(
                          borderRadius: 10,
                          buttonColor: StaticColors.defaultButton,
                          buttonLabel: "Login",
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
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
