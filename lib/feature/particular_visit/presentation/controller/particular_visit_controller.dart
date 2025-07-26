import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/particular_visit/data/model/particular_visit_model.dart';
import 'package:mr_reporting/feature/particular_visit/data/repository/particular_visit_repository.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class ParticularVisitController extends GetxController{

  final _api = ParticularVisitRepository();
  final userPreferences = UserPreference();

  final noteController = TextEditingController().obs;

  final rxParticularVisitModel = Rxn<ParticularVisitModel>();
  final rxRequestStatusParticularVisit = Status.LOADING.obs;

  double latitude = 0.0;
  double longitude = 0.0;

  RxBool loading = false.obs;

  void setRxVisitModel(ParticularVisitModel value) => rxParticularVisitModel.value = value;
  void setRxRequestStatusVisit(Status value) => rxRequestStatusParticularVisit.value = value;


  void particularVisit(String assignmentId) async{

    Map<String, dynamic> data = {
      'assignment_id': assignmentId
    };

    _api.particularVisitApi(data).then((response) {

      if (kDebugMode) {
        print(response);
      }

      try{

        if(response['doctor'] != null && response['doctor'].toString().isNotEmpty){
          ParticularVisitModel particularVisitModel = ParticularVisitModel.fromJson(response);
          setRxVisitModel(particularVisitModel);
          setRxRequestStatusVisit(Status.COMPLETED);

          if (kDebugMode) {
            print('Visit List Data Set Successfully');
          }

        }else {
          Utils.toastMessageTop(response['message']);
        }

      }catch(e){
        setRxRequestStatusVisit(Status.ERROR);
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {
      setRxRequestStatusVisit(Status.ERROR);
      if(kDebugMode){
        print(error.toString());
      }

    });

  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission permanently denied.');
    }

    try {
      Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      }
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print('Error: $e');
      }
    }

    // Get current location
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// Start Visit
  void startVisit(String assignmentId) async{

    loading.value = true;

    final position = await getCurrentLocation();
    if (position == null) {
      Utils.toastMessageTop('Unable To Fetch Location');
      return;
    }

    Map<String, dynamic> data = {
      'assignmentId': assignmentId,
      'startLatitude': latitude,
      'startLongitude': longitude,
      'startTime': DateTime.now().toUtc().toIso8601String()
    };

    _api.startVisitApi(data).then((response) {

      if (kDebugMode) {
        print(response);
      }

      loading.value = false;

      try{

        if(response['message'] != null && response['message'].toString().isNotEmpty){

          Utils.toastMessageTop(response['message']);

          setRxRequestStatusVisit(Status.LOADING);
          particularVisit(assignmentId);

        }else {
          Utils.toastMessageTop(response['error']);
        }


      }catch(e){
        loading.value = false;
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {
      loading.value = false;
      if(kDebugMode){
        print(error.toString());
      }

    });

  }

  /// Reached Visit
  void reachedVisit(String assignmentId) async{

    loading.value = true;

    final position = await getCurrentLocation();

    if (position == null) {
      Utils.toastMessageTop('Unable To Fetch Location');
      return;
    }

    Map<String, dynamic> data = {
      'assignmentId': assignmentId,
      'reachedLatitude': latitude,
      'reachedLongitude': longitude,
      'startTime': DateTime.now().toUtc().toIso8601String()
    };

    _api.reachedVisitApi(data).then((response) {

      loading.value = false;

      if (kDebugMode) {
        print(response);
      }

      try{

        if(response['message'] != null && response['message'].toString().isNotEmpty){

          Utils.toastMessageTop(response['message']);

          setRxRequestStatusVisit(Status.LOADING);
          particularVisit(assignmentId);

        }else {
          Utils.toastMessageTop(response['error']);
        }

      }catch(e){
        loading.value = false;
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {
      loading.value = false;
      if(kDebugMode){
        print(error.toString());
      }

    });

  }

  /// Complete Visit
  void completeVisit(String assignmentId) async{

    loading.value = true;

    Map<String, dynamic> data = {
      'assignmentId': assignmentId,
      'notes': noteController.value.text
    };

    _api.reachedVisitApi(data).then((response) {

      loading.value = false;

      if (kDebugMode) {
        print(response);
      }

      try{

        if(response['message'] != null && response['message'].toString().isNotEmpty){

          Utils.toastMessageTop(response['message']);

          setRxRequestStatusVisit(Status.LOADING);
          particularVisit(assignmentId);

        }else {
          Utils.toastMessageTop(response['error']);
        }

      }catch(e){
        loading.value = false;
        if(kDebugMode){
          print('=============>>>>>>>>>>>>>>>>>>==================');
          print(e.toString());
        }
      }

    }).onError((error, stackTrace) {
      loading.value = false;
      if(kDebugMode){
        print(error.toString());
      }

    });

  }
}