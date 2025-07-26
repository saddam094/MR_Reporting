import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/feature/authentication/login/presentation/view/login_screen.dart';
import 'package:mr_reporting/feature/edit_profile/presentation/view/edit_profile_screen.dart';
import 'package:mr_reporting/feature/home/presentation/controller/home_controller.dart';
import 'package:mr_reporting/feature/profile/presentation/view/profile_screen.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  final userPreferences = UserPreference();

  final moreVM = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moreVM.profile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBG,
      body: Stack(
        children: [
          /// Main Container
          Container(
            height: Constant.height * 1,
            width: Constant.width * 1,
            padding: EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Constant.height * .17),

                /// Profile
                Obx(() {
                  return Container(
                    height: Constant.height * .1,
                    width: Constant.width * 1,
                    padding: EdgeInsets.only(
                      left: Constant.width * .02,
                      right: Constant.width * .02,
                      top: Constant.height * .005,
                      bottom: Constant.height * .005
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Constant.width * .04),
                      border: Border.all(
                        color: AppColors.greyTextLightColor
                      )
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Profile Container
                          Container(
                            height: Constant.height * .09,
                            width: Constant.width * .18,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/mr_image/person male.png'),
                                    fit: BoxFit.cover
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.gradient1,
                                    width: Constant.width * .004
                                )
                            ),
                          ),

                          SizedBox(width: Constant.width * .05),

                          /// Name And Email
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Name
                              Text(moreVM.name.value, style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),

                              /// Date
                              Row(
                                children: [
                                  Icon(Icons.email, size: Constant.width * .045, color: AppColors.greyTextDarkColor),
                                  Text('  ${moreVM.email.value}', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
                                ],
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  );
                },),

                SizedBox(height: Constant.height * .01),

                /// Edit Profile
                moreCard('Edit Profile', Icons.edit_outlined, true, () {
                    Get.to(() => EditProfileScreen());
                },),

                SizedBox(height: Constant.height * .01),

                /// Notification
                moreCard('Notification', Icons.notifications_outlined, true, () {

                },),

                SizedBox(height: Constant.height * .01),

                /// FAQ
                moreCard('FAQ', Icons.question_answer_outlined, true, () {

                },),

                SizedBox(height: Constant.height * .01),

                /// Help Center
                moreCard('Help Center', Icons.help_center_outlined, true, () {

                },),

                SizedBox(height: Constant.height * .01),

                /// LogOut
                moreCard('Logout', Icons.logout_outlined, false, () {
                  userPreferences.setToken('');
                  Get.offAll(() => const LoginScreen());
                },),


              ],
            ),
          ),

          /// Heading Container
          Container(
            height: Constant.height * .15,
            width: Constant.width * 1,
            padding: EdgeInsets.only(
                top: Constant.height * .075,
                left: Constant.width * .43
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradient2,
                    AppColors.gradient1
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Constant.width * .1),
                  bottomRight: Radius.circular(Constant.width * .1),
                )
            ),
            child: Text('Profile', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),
          )

        ],
      ),
    );
  }

  Widget moreCard(String title, IconData iconData, bool isNavigate, VoidCallback method){
    return InkWell(
      onTap: method,
      child: Container(
        height: Constant.height * .08,
        width: Constant.width * 1,
        padding: EdgeInsets.only(
          left: Constant.width * .03,
          right: Constant.width * .03,
          top: Constant.height * .005,
          bottom: Constant.height * .005,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBg1,
          borderRadius: BorderRadius.circular(Constant.width * .03),
          border: Border.all(
            color: AppColors.cardBg
          )
        ),
        child: Row(
          children: [
            /// Icon
            Container(
              height: Constant.height * .07,
              width: Constant.width * .14,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, size: Constant.width * .065, color: title == 'Logout' ? AppColors.redColor : AppColors.black)
            ),

            SizedBox(width:  Constant.width * .03),

            /// Title
            SizedBox(
              height: Constant.height * .025,
              width: Constant.width * .62,
              child: Text(title, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.black, fontWeight: FontWeight.bold), maxLines: 1),
            ),

            /// Right Arrow
            isNavigate ? Icon(Icons.keyboard_arrow_right, size: Constant.width * .08, color: AppColors.greyTextDarkColor) : SizedBox()
          ],
        ),
      ),
    );
  }
}
