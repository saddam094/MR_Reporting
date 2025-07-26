import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/home/presentation/controller/home_controller.dart';
import 'package:mr_reporting/feature/particular_visit/presentation/view/particular_visit_screen.dart';
import 'package:mr_reporting/feature/visits/presentation/controller/visits_controller.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final homeVM = Get.put(HomeController());
  final visitsVM = Get.put(VisitsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeVM.profile();
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
                SizedBox(height: Constant.height * .265),

                /// status card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Total Visits
                    statusCard('Total Visits', 10, Icons.local_hospital, AppColors.gradient2, AppColors.gradient1),

                    /// Total Stock
                    statusCard('Total Stock', 500, Icons.inventory, AppColors.blueDark, AppColors.blueLight),
                  ],
                ),

                SizedBox(height: Constant.height * .02),

                /// Total Visits ---> Text
                Text('Today Visits : ', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.greyTextDarkColor)),

                /// Today Visit List
                Obx(() {
                  switch(visitsVM.rxRequestStatusVisitList.value){
                    case Status.LOADING:
                      return SizedBox(
                        height: Constant.height * .53,
                        width: Constant.width * 1,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    case Status.ERROR:
                      return SizedBox(
                        height: Constant.height * .53,
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
                          height: Constant.height * .53,
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
                          height: Constant.height * .53,
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
                        height: Constant.height * .52,
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
            height: Constant.height * .25,
            width: Constant.width * 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradient1,
                    AppColors.gradient2
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Constant.width * .1),
                  bottomRight: Radius.circular(Constant.width * .1),
                )
            ),
            child: Obx(() {
              return Container(
                margin: EdgeInsets.only(
                  top: Constant.height * .05,
                  bottom: Constant.height * .02,
                  left: Constant.width * .035,
                  right: Constant.width * .035,
                ),
                padding: EdgeInsets.only(
                  left: Constant.width * .02,
                  right: Constant.width * .02,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(Constant.width * .1),
                ),
                child: Stack(
                  children: [
                    /// Profile and Name + Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Profile Container
                        InkWell(
                          onTap: () {
                            // Get.to(() => const ProfileScreen());
                          },
                          child: Container(
                            height: Constant.height * .14,
                            width: Constant.width * .28,
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
                        ),

                        SizedBox(width: Constant.width * .05),

                        /// Name And Date
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Name
                            Text(homeVM.name.value, style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),

                            /// Date
                            Row(
                              children: [
                                Icon(Icons.calendar_month, size: Constant.width * .045, color: AppColors.greyTextDarkColor),
                                Text(homeVM.today, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
                              ],
                            ),
                          ],
                        ),


                      ],
                    ),

                    /// Notification
                    Container(
                      height: Constant.height * .05,
                      width: Constant.width * 1,
                      margin: EdgeInsets.only(
                          top: Constant.height * .01,
                          left: Constant.width * .75
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.gradient1,
                              width: Constant.width * .004
                          )
                      ),
                      child: Icon(Icons.notifications, size: Constant.width * .06, color: AppColors.greyTextDarkColor),
                    )
                  ],
                ),
              );
            },)
          )

        ],
      ),
    );
  }

  /// Status Card
  Widget statusCard(String title, int count, IconData icon, Color color, Color lightColor){
    return Container(
      height: Constant.height * .15,
      width: Constant.width * .45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Constant.width * .04),
      ),
      child: Container(
        height: Constant.height * .15,
        width: Constant.width * .45,
        margin: EdgeInsets.only(
          left: Constant.width * .02,
        ),
        padding: EdgeInsets.only(
            left: Constant.width * .03,
            right: Constant.width * .03,
            top: Constant.height * .02,
            bottom: Constant.height * .02
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(Constant.width * .04),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(title, style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),

            /// Quantity and Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Quantity
                Text(count.toString(), style: TextStyle(fontSize: Constant.width * .06, fontWeight: FontWeight.bold, color: color)),

                /// Icon ---> Container
                Container(
                  height: Constant.height * .07,
                  width: Constant.width * .14,
                  decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(Constant.width * .03)
                  ),
                  child: Center(
                    child: Icon(icon, size: Constant.width * .08, color: color),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Visit Card
  Widget visitCard(String name, status, startDateTime, endDateTime, IconData icon, VoidCallback method){
    return InkWell(
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

  // /// VisitCard
  // Widget visitCard(String name, status, date, time, IconData icon, VoidCallback method){
  //   return InkWell(
  //     onTap: method,
  //     child: Container(
  //       height: Constant.height * .12,
  //       width: Constant.width * 1,
  //       margin: EdgeInsets.only(
  //         top: Constant.height * .01
  //       ),
  //       padding: EdgeInsets.only(
  //           left: Constant.width * .03,
  //           right: Constant.width * .03,
  //       ),
  //       decoration: BoxDecoration(
  //         color: AppColors.white,
  //         borderRadius: BorderRadius.circular(Constant.width * .03),
  //         border: Border.all(
  //           color: AppColors.gradient2
  //         )
  //       ),
  //       child: Row(
  //         children: [
  //           /// Icon
  //           Container(
  //             height: Constant.height * .09,
  //             width: Constant.width * .2,
  //             decoration: BoxDecoration(
  //               color: AppColors.gradient1,
  //               borderRadius: BorderRadius.circular(Constant.width * .03)
  //             ),
  //             child: Center(
  //               child: Icon(icon, size: Constant.width * .15, color: AppColors.gradient2),
  //             ),
  //           ),
  //
  //           SizedBox(width: Constant.width * .02),
  //
  //           /// Name and Date
  //           SizedBox(
  //             height: Constant.height * .09,
  //             width: Constant.width * .38,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Text(name, style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
  //                 Text(date, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
  //                 Text(status, style: TextStyle(fontSize: Constant.width * .04, fontWeight: FontWeight.bold, color: status == 'Completed' ? AppColors.greenTextColor : status == 'In Progress' ? AppColors.blueColor : status == 'On Hold' ? AppColors.redColor : AppColors.greyTextDarkColor), maxLines: 1),
  //               ],
  //             ),
  //           ),
  //
  //           /// Time Container
  //           SizedBox(
  //             height: Constant.height * .09,
  //             width: Constant.width * .27,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Text(time, style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
  //                 Text('Total Duration', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
