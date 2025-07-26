import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/visits/data/model/visit_list_model.dart';
import 'package:mr_reporting/feature/visits/data/repository/visit_repository.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class VisitsController extends GetxController{

  final _api = VisitRepository();
  final userPreferences = UserPreference();

  final rxVisitListModel = Rxn<VisitListModel>();
  final rxRequestStatusVisitList = Status.LOADING.obs;

  void setRxVisitListModel(VisitListModel value) => rxVisitListModel.value = value;
  void setRxRequestStatusVisitList(Status value) => rxRequestStatusVisitList.value = value;


  String today = DateFormat('d MMMM y').format(DateTime.now()).toString();

  // final visits = [
  //   {
  //     'icon': Icons.local_hospital,
  //     'name': 'Dr Sharma',
  //     'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
  //     'time': '5 Min'
  //   },
  //   {
  //     'icon': Icons.local_hospital,
  //     'name': 'Dr Gupta',
  //     'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
  //     'time': '10 Min'
  //   },
  //   {
  //     'icon': Icons.local_hospital,
  //     'name': 'Dr Sharma',
  //     'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
  //     'time': '5 Min'
  //   },
  //   {
  //     'icon': Icons.local_hospital,
  //     'name': 'Dr Gupta',
  //     'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
  //     'time': '10 Min'
  //   },
  //   {
  //     'icon': Icons.local_hospital,
  //     'name': 'Dr Sharma',
  //     'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
  //     'time': '5 Min'
  //   },
  //   {
  //     'icon': Icons.local_hospital,
  //     'name': 'Dr Gupta',
  //     'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
  //     'time': '10 Min'
  //   },
  // ].obs;

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