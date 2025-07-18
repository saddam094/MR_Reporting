import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/feature/authentication/login/presentation/view/login_screen.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/common/common_app_bar.dart';
import 'package:mr_reporting/res/common/common_button.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userPreferences = UserPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          context: context,
          title: 'Profile',
          backButton: true,
          onBackTap: () => Navigator.pop(context)),
      body: Container(
          height: Constant.height * .87,
          width: Constant.width * 1,
          padding: EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
              top: Constant.height * .01),
          child: Column(
            children: [
              /// Profile Details
              Container(
                height: Constant.height * .74,
                width: Constant.width * 1,
                padding: EdgeInsets.only(
                  left: Constant.width * .02,
                  right: Constant.width * .02,
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Constant.height * .04,
                      ),

                      /// Image Container
                      Container(
                        height: Constant.height * .18,
                        width: Constant.height * .18,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.grey.shade500,
                              width: Constant.width * .005,
                            )),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: Constant.height * .15,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: Constant.height * .04,
                      ),

                      /// Name
                      singleInfoCard('Name', 'saddam hussain'),

                      /// Phone
                      singleInfoCard('Phone', '6202548771'),

                      /// Email
                      singleInfoCard('Email', 'saddam717860@gmail.com'),
                    ],
                  ),
                ),
              ),

              /// Logout Button
              CommonButton(
                height: Constant.height * .06,
                width: Constant.width * .9,
                title: 'Log Out',
                onTap: () {
                  // Log out Functions
                  userPreferences.setToken('');
                  Get.offAll(() => const LoginScreen());
                },
              )
            ],
          )),
    );
  }

  Widget singleInfoCard(String title, String value) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: Constant.width * .05,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor)),
            ],
          ),
          SizedBox(height: Constant.height * .005),
          Container(
            height: Constant.height * .06,
            width: Constant.width * 1,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(color: AppColors.greyTextDarkColor, width: 1)),
            child: Text(value,
                style: TextStyle(
                    fontSize: Constant.width * .05,
                    color: Colors.grey.shade800)),
          ),
          SizedBox(height: Constant.height * .01),
        ],
      ),
    );
  }
}
