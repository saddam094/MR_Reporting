import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mr_reporting/feature/authentication/login/data/model/login_model.dart';
import 'package:mr_reporting/feature/authentication/login/data/repository/login_repository.dart';
import 'package:mr_reporting/feature/dashboard/presentation/view/dashboard_screen.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class LoginController extends GetxController {

  final _api = LoginRepository();
  final userPreferences = UserPreference();
  final rxLoginModel = Rxn<LoginModel>();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool isObsecure = true.obs;
  RxBool loading = false.obs;

  void setRxLoginModel(LoginModel value) => rxLoginModel.value = value;

  void login(){
    loading.value = true;

    Map<String, dynamic> data = {
      'username': emailController.value.text,
      'password': passwordController.value.text,
      'role': 'MR'
    };

    _api.loginApi(data).then((response) {

      loading.value = false;

      if (kDebugMode) {
        print(response);
      }

      try{

        if(response['token'] != null && response['token'].toString().isNotEmpty){
          LoginModel loginModel = LoginModel.fromJson(response);
          setRxLoginModel(loginModel);

          String token = response['token'];

          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

          String role = decodedToken['role'];
          String mrId = decodedToken['mr_id'];

          userPreferences.setEmail(emailController.value.text).then((value) {
            if(kDebugMode){
              print('email saved successfully');
            }
          });

          userPreferences.setUserId(mrId).then((value) {
            if(kDebugMode){
              print('Mr Id saved successfully');
            }
          });

          userPreferences.setToken(token).then((value) {
            if (kDebugMode) {
              print('token saved successfully');
            }

            Utils.toastMessageSuccessful('Login Successfully');
            Get.to(() => const DashboardScreen());

          }).onError((error, stackTrace) {
            if (kDebugMode) {
              print('error while saving token');
            }
            Utils.toastMessageTop('Some thing went wrong please try again !!');
          });


        }else {
          Utils.toastMessageTop(response['message']);
        }

      }catch(e){
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {

      if(kDebugMode){
        print(error.toString());
      }
      loading.value = false;

    });

  }

}