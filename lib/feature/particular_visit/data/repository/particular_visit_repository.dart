import 'package:mr_reporting/core/network/network_api_services.dart';
import 'package:mr_reporting/res/url/consturl.dart';

class ParticularVisitRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> particularVisitApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.particularVisit);
    return response;
  }

  Future<dynamic> startVisitApi(Map<String, dynamic> data){
    // final response = _apiServices.postApi(data, ConstUrl.startVisit);
    final response = _apiServices.putApi(data, ConstUrl.startVisit);
    return response;
  }

  Future<dynamic> reachedVisitApi(Map<String, dynamic> data){
    // final response = _apiServices.postApi(data, ConstUrl.reachedVisit);
    final response = _apiServices.putApi(data, ConstUrl.reachedVisit);
    return response;
  }

  Future<dynamic> completeVisitApi(Map<String, dynamic> data){
    // final response = _apiServices.postApi(data, ConstUrl.completeVisit);
    final response = _apiServices.putApi(data, ConstUrl.completeVisit);
    return response;
  }
}