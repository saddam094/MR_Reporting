import 'package:get/get.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';

class DashboardController extends GetxController{

  final userPreferences = UserPreference();
  final name = ''.obs;

  final selectedPage = 'Home'.obs;

  void getEmail()async{
    String? e = await userPreferences.getEmail();
    name.value = e!;

    // String? token = await userPreferences.getToken();
    //
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // name.value = decodedToken['name'];
    // print(decodedToken);

  }

}