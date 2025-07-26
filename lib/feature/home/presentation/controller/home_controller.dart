import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/home/data/model/profile_model.dart';
import 'package:mr_reporting/feature/home/data/model/visit_list_model.dart';
import 'package:mr_reporting/feature/home/data/repository/home_repository.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class HomeController extends GetxController{

  final _api = HomeRepository();
  final userPreferences = UserPreference();
  final rxProfileModel = Rxn<ProfileModel>();
  final rxRequestStatusProfile = Status.LOADING.obs;

  final rxVisitListModel = Rxn<VisitListModel>();
  final rxRequestStatusVisitList = Status.LOADING.obs;

  void setRxVisitListModel(VisitListModel value) => rxVisitListModel.value = value;
  void setRxRequestStatusVisitList(Status value) => rxRequestStatusVisitList.value = value;


  RxBool loading = false.obs;

  RxString name = 'Loading....'.obs;
  RxString email = 'Loading....'.obs;

  void setRxProfileModel(ProfileModel value) => rxProfileModel.value = value;
  void setRxRequestStatusProfile(Status value) => rxRequestStatusProfile.value = value;

  String today = DateFormat('d MMMM y').format(DateTime.now()).toString();

  final todayVisits = [
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min',
      'status': 'Not Started'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min',
      'status': 'Completed'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min',
      'status': 'In Progress'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min',
      'status': 'On Hold'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min',
      'status': 'Not Started'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min',
      'status': 'Not Started'
    },
  ].obs;

  void profile() async{

    loading.value = true;

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
          name.value = response['name'];
          email.value = response['email'];

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
      loading.value = false;

    });

  }

  void visitList() async{

    String? mrId = await userPreferences.getUserId();

    Map<String, dynamic> data = {
      'mr_id': mrId
    };

    _api.visitListApi(data).then((response) {

      if (kDebugMode) {
        print(response);
      }

      try{

        if(response['valid'] != null && response['valid'].toString().isNotEmpty){
          VisitListModel visitListModel = VisitListModel.fromJson(response);
          setRxVisitListModel(visitListModel);
          setRxRequestStatusVisitList(Status.COMPLETED);

          if (kDebugMode) {
            print('Visit List Data Set Successfully');
          }

        }else {
          Utils.toastMessageTop(response['message']);
        }

      }catch(e){
        setRxRequestStatusVisitList(Status.ERROR);
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusVisitList(Status.ERROR);
      if(kDebugMode){
        print(error.toString());
      }

    });

  }
}