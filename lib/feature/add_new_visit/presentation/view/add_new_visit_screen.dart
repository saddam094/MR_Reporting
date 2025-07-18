import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/feature/add_new_visit/presentation/controller/add_new_visit_controller.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/common/common_app_bar.dart';
import 'package:mr_reporting/res/common/common_button.dart';
import 'package:mr_reporting/res/common/common_text_field.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class AddNewVisitScreen extends StatefulWidget {
  const AddNewVisitScreen({super.key});

  @override
  State<AddNewVisitScreen> createState() => _AddNewVisitScreenState();
}

class _AddNewVisitScreenState extends State<AddNewVisitScreen> {

  final addVisitVM = Get.put(AddNewVisitController());

  List<String> categoryList = ['Cardiology', 'Neurology', 'Dermatology', 'Radiology', 'Orthopedics', 'Pathology', 'Anesthesiology', 'Ophthalmology', 'Pediatrics', 'Oncology', 'Psychiatry', 'GeneralSurgery', 'Endocrinology'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: 'Add New Visit', backButton: true, onBackTap: () => Navigator.pop(context)),
      body: Container(
        height: Constant.height * .87,
        width: Constant.width * 1,
        padding: EdgeInsets.only(
          left: Constant.width * .03,
          right: Constant.width * .03,
          top: Constant.height * .01
        ),
        child: Column(
          children: [
            /// Dr. Name
            CommonTextField(
              obSecure: false,
              controller: addVisitVM.drName.value,
              hintText: 'Dr. Name',
              hintStyle: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor),
              icon: Icon(Icons.person, color: AppColors.greyTextDarkColor),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if(value!.isEmpty){
                  Utils.toastMessageTop('Enter Email');
                }
                return null;
              },
            ),

            SizedBox(height: Constant.height * .01),

            /// Clinic or Hospital
            Obx(() {
              return Container(
                height: Constant.height * .06,
                width: Constant.width * 1,
                padding: EdgeInsets.only(
                    left: Constant.width * .03,
                    right: Constant.width * .03
                ),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(Constant.width * .02),
                    border: Border.all(
                        color: AppColors.primaryColor
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Clinic / Hospital : ' ),

                    DropdownButton<String>(
                      value: addVisitVM.type.value,
                      hint: Text('Select Category'),
                      items: ['Clinic', 'Hospital'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        addVisitVM.type.value = value!;
                      },
                    ),
                  ],
                ),
              );
            },),

            SizedBox(height: Constant.height * .01),

            /// Doctor Category
            Obx(() {
              return Container(
                height: Constant.height * .06,
                width: Constant.width * 1,
                padding: EdgeInsets.only(
                  left: Constant.width * .03,
                  right: Constant.width * .03
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Constant.width * .02),
                  border: Border.all(
                    color: AppColors.primaryColor
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Specialist : ' ),

                    DropdownButton<String>(
                      value: addVisitVM.specialist.value,
                      hint: Text('Select Category'),
                      items: categoryList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        addVisitVM.specialist.value = value!;
                      },
                    ),
                  ],
                ),
              );
            },),

            SizedBox(height: Constant.height * .01),

            /// Date Picker
            Obx(() {
              return GestureDetector(
                onTap: () {
                  addVisitVM.pickDate(context);
                },
                child: Container(
                  height: Constant.height * .06,
                  width: Constant.width * 1,
                  padding: EdgeInsets.only(
                    left: Constant.width * .03,
                    right: Constant.width * .03,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(Constant.width * .02),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date : '),

                      Text(
                        addVisitVM.selectedDate.value == null
                            ? 'Select Date'
                            : '${addVisitVM.selectedDate.value!.day}/${addVisitVM.selectedDate.value!.month}/${addVisitVM.selectedDate.value!.year}',
                        style: TextStyle(
                          color: AppColors.greyTextDarkColor,
                          fontSize: Constant.width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: Constant.height * .45),

            CommonButton(
              onTap: () {

              },
              title: 'Create Visit',
              height: Constant.height  * .06,
              width: Constant.width * 1,
            )

          ],
        ),
      ),
    );
  }
}
