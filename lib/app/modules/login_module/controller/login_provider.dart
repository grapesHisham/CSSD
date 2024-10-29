import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/app/modules/login_module/model/pre_login_authentication_model.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // show or hide password
  bool _obscureText = false;
  bool get obscureText => _obscureText;
  bool isLoading = false;

  void toggleObscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  //text controllers
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController loginPhoneNumberController = TextEditingController();

  //function to call for receiving hospitals lists
  List<Data> preLoginResponse = [];
  Future<void> submitPhoneForHospitalIds(
      String phoneNumber, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final client = await AppUtil.createApiClient();
      PreLoginAuthenticationModel response =
          await client.submitPhoneForHospitalIds(phoneNumber);
      if (response.status == 200) {
        print("prelogin success 200");
        preLoginResponse.clear();
        preLoginResponse.addAll(response.data ?? []);

        customDialog(
            dialogContext: context,
            dialogContent: ListView.builder(
              itemCount: preLoginResponse.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(preLoginResponse[index].hospitalName! ??
                        " hospital name fetch error"));
              },
            ));
      } else if (response.status == 300) {
        print("Status 300 : ${response.message}");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
