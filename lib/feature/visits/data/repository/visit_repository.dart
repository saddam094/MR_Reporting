import 'package:mr_reporting/core/network/network_api_services.dart';
import 'package:mr_reporting/res/url/consturl.dart';

class VisitRepository {

  final _apiServices = NetworkApiServices();

  Future<dynamic> visitListApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.visitList);
    return response;
  }

}