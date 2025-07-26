import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/home/presentation/controller/home_controller.dart';
import 'package:mr_reporting/feature/particular_visit/presentation/view/particular_visit_screen.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {

  final visitsVM = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visitsVM.visitList();
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
                SizedBox(height: Constant.height * .155),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     CommonTextButton(
                //       onTap: () {
                //         Get.to(() => const AddNewVisitScreen());
                //       },
                //       text: 'Add New Visit',
                //       style: TextStyle(color: AppColors.gradient2, fontSize: Constant.width * .04, decoration: TextDecoration.underline, decorationColor: AppColors.gradient2),
                //     ),
                //   ],
                // ),

                /// Visit List
                Obx(() {
                  switch(visitsVM.rxRequestStatusVisitList.value){
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
                      if (visitsVM.rxVisitListModel.value == null) {
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

                      if (visitsVM.rxVisitListModel.value!.assignments.isEmpty) {
                        return SizedBox(
                          height: Constant.height * .79,
                          width: Constant.width * 1,
                          child: Center(
                            child: Text(
                              'No Visit Available',
                              style: TextStyle(fontSize: Constant.width * .06),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: Constant.height * .79,
                        width: Constant.width * 1,
                        child: ListView.builder(
                          itemCount: visitsVM.rxVisitListModel.value!.assignments.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            var data = visitsVM.rxVisitListModel.value!.assignments[index];
                            return visitCard(data.doctorName, data.status, data.startDatetime, data.endDatetime, Icons.local_hospital, () {
                              Get.to(() => ParticularVisitScreen(assignmentId: data.assignmentId));
                            },);
                          },
                        ),
                      );
                  }

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
            child: Text('Visit', style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black)),
          )

        ],
      ),
    );
  }


  /// VisitCard
  Widget visitCard(String name, status, startDateTime, endDateTime, IconData icon, VoidCallback method){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: method,
        child: Container(
          height: Constant.height * .12,
          width: Constant.width * 1,
          margin: EdgeInsets.only(
            bottom: Constant.height * .01
          ),
          padding: EdgeInsets.only(
              left: Constant.width * .03,
              right: Constant.width * .03,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(Constant.width * .03),
            border: Border.all(
              color: AppColors.gradient2
            )
          ),
          child: Row(
            children: [
              /// Icon
              Container(
                height: Constant.height * .09,
                width: Constant.width * .2,
                decoration: BoxDecoration(
                  color: AppColors.gradient1,
                  borderRadius: BorderRadius.circular(Constant.width * .03)
                ),
                child: Center(
                  child: Icon(icon, size: Constant.width * .15, color: AppColors.gradient2),
                ),
              ),

              SizedBox(width: Constant.width * .02),

              /// Name and Date
              SizedBox(
                height: Constant.height * .1,
                width: Constant.width * .65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(name, style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
                    titleValue('Start', extractDate(startDateTime)),
                    titleValue('End', extractDate(endDateTime)),
                    // titleValue('Status', status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String extractDate(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }



  Widget titleValue(String title, value){
    return Row(
      children: [
        Text('$title : ', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextDarkColor, fontWeight: FontWeight.bold), maxLines: 1),
        Text(value, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
      ],
    );
  }
}
