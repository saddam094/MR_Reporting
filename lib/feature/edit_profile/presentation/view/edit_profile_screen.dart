import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/edit_profile/presentation/controller/edit_profile_controller.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/common/common_app_bar.dart';
import 'package:mr_reporting/res/common/common_button.dart';
import 'package:mr_reporting/res/common/common_text_field.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';
import 'package:mr_reporting/res/preferences/user_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final userPreferences = UserPreference();

  final editProfileVM = Get.put(EditProfileController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileVM.profile();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          context: context,
          title: 'Edit Profile',
          backButton: true,
          onBackTap: () => Navigator.pop(context)),
      body: Container(
          height: Constant.height * .87,
          width: Constant.width * 1,
          padding: EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
              top: Constant.height * .01),
          child: SingleChildScrollView(
            child: Obx(() {
              switch(editProfileVM.rxRequestStatusProfile.value){
                case Status.LOADING:
                  return SizedBox(
                    height: Constant.height * .79,
                    width: Constant.width * 1,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
            
                case Status.ERROR:
                  return SizedBox(
                    height: Constant.height * .79,
                    width: Constant.width * 1,
                    child: Center(
                      child: Text(
                        'Something Went Wrong',
                        style: TextStyle(fontSize: Constant.width * .06),
                      ),
                    ),
                  );
            
                case Status.COMPLETED:
                  if (editProfileVM.rxProfileModel.value == null) {
                    return SizedBox(
                      height: Constant.height * .79,
                      width: Constant.width * 1,
                      child: Center(
                        child: Text(
                          'No Data Available',
                          style: TextStyle(fontSize: Constant.width * .06),
                        ),
                      ),
                    );
                  }
            
                  var data = editProfileVM.rxProfileModel.value;
                  return Container(
                    height: Constant.height * .82,
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
            
                          Row(
                            children: [
                              Text(' Email', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),
                            ],
                          ),
            
                          /// email
                          Container(
                            height: Constant.height * .06,
                            width: Constant.width * 1,
                            padding: EdgeInsets.only(
                              left: Constant.width * .04,
                              right: Constant.width * .04,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.cardBg1,
                                borderRadius: BorderRadius.circular(Constant.width * .02),
                                border: Border.all(
                                    color: AppColors.gradient1
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data!.email, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
                              ],
                            ),
                          ),
            
                          SizedBox(height: Constant.height * .01),
            
                          Row(
                            children: [
                              Text(' MrId', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),
                            ],
                          ),
            
                          /// mrId
                          Container(
                            height: Constant.height * .06,
                            width: Constant.width * 1,
                            padding: EdgeInsets.only(
                              left: Constant.width * .04,
                              right: Constant.width * .04,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.cardBg1,
                                borderRadius: BorderRadius.circular(Constant.width * .02),
                                border: Border.all(
                                    color: AppColors.gradient1
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.mrId, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
                              ],
                            ),
                          ),
            
                          SizedBox(height: Constant.height * .01),
            
                          Row(
                            children: [
                              Text(' Name', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),
                            ],
                          ),
            
                          /// Name ---> It will be TextField
                          CommonTextField(
                            obSecure: false,
                            controller: editProfileVM.nameController.value,
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontSize: Constant.width * .04,
                                color: AppColors.greyTextDarkColor),
                            icon: Icon(Icons.person_2_outlined,
                                color: AppColors.greyTextDarkColor),
                            keyboardType: TextInputType.name,
                          ),
            
                          SizedBox(height: Constant.height * .01),
            
                          Row(
                            children: [
                              Text(' Phone', style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),
                            ],
                          ),
            
                          /// Phone Number ---> It will be TextField
                          CommonTextField(
                            obSecure: false,
                            controller: editProfileVM.phoneController.value,
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                                fontSize: Constant.width * .04,
                                color: AppColors.greyTextDarkColor),
                            icon: Icon(Icons.call_outlined,
                                color: AppColors.greyTextDarkColor),
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(height: Constant.height * .08),

                          /// Edit Button
                          CommonButton(
                            height: Constant.height * .06,
                            width: Constant.width * 1,
                            onTap: () {

                            },
                            title: 'Edit',
                          )
            
            
                        ],
                      ),
                    ),
                  );
              }
            
            },),
          ),
      ),
    );
  }
}
