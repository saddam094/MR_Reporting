import 'package:mr_reporting/core/network/network_api_services.dart';
import 'package:mr_reporting/res/url/consturl.dart';

class LoginRepository{

  final _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(Map<String, dynamic> data){
    final response = _apiServices.postApi(data, ConstUrl.login);
    return response;
  }
}