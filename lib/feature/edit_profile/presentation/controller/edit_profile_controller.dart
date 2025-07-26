import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/home/data/model/profile_model.dart';
import 'package:mr_reporting/feature/home/data/repository/home_repository.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class EditProfileController extends GetxController{

  final _api = HomeRepository();
  final userPreferences = UserPreference();
  final rxProfileModel = Rxn<ProfileModel>();
  final rxRequestStatusProfile = Status.LOADING.obs;


  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;

  // RxString email = 'Loading...'.obs;
  // RxString mrId = 'Loading...'.obs;
  // RxString name = 'Loading....'.obs;

  RxBool loading = false.obs;

  void setRxProfileModel(ProfileModel value) => rxProfileModel.value = value;
  void setRxRequestStatusProfile(Status value) => rxRequestStatusProfile.value = value;


  void profile() async{

    String? mrId = await userPreferences.getUserId();

    Map<String, dynamic> data = {
      'mr_id': mrId
    };

    _api.profileApi(data).then((response) {

      loading.value = false;

      if (kDebugMode) {
        print(response);
      }

      try{

        if(response['name'] != null && response['name'].toString().isNotEmpty){
          ProfileModel profileModel = ProfileModel.fromJson(response);
          setRxProfileModel(profileModel);
          setRxRequestStatusProfile(Status.COMPLETED);

          nameController.value.text = rxProfileModel.value!.name;
          phoneController.value.text = rxProfileModel.value!.phone;

          if (kDebugMode) {
            print('Profile Data Set Successfully');
          }

        }else {
          Utils.toastMessageTop(response['message']);
        }

      }catch(e){
        setRxRequestStatusProfile(Status.ERROR);
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusProfile(Status.ERROR);
      if(kDebugMode){
        print(error.toString());
      }
      // loading.value = false;

    });

  }



}