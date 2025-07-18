import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/feature/add_new_visit/presentation/view/add_new_visit_screen.dart';
import 'package:mr_reporting/feature/particular_visit/presentation/view/particular_visit_screen.dart';
import 'package:mr_reporting/feature/visits//presentation/controller/visits_controller.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/common/common_text_button.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {

  final visitsVM = Get.put(VisitsController());

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonTextButton(
                      onTap: () {
                        Get.to(() => const AddNewVisitScreen());
                      },
                      text: 'Add New Visit',
                      style: TextStyle(color: AppColors.gradient2, fontSize: Constant.width * .04, decoration: TextDecoration.underline, decorationColor: AppColors.gradient2),
                    ),
                  ],
                ),

                /// Today Visit List
                Obx(() {
                  return SizedBox(
                    height: Constant.height * .79,
                    width: Constant.width * 1,
                    child: ListView.builder(
                      itemCount: visitsVM.visits.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        var data = visitsVM.visits[index];
                        return visitCard(data['name'].toString(), data['date'], data['time'], Icons.local_hospital, () {
                          Get.to(() => ParticularVisitScreen(drName: data['name'].toString(), status: 'Completed',));
                        },);
                      },
                    ),
                  );
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
            child: Text('Visit', style: TextStyle(fontSize: Constant.width * .06, fontWeight: FontWeight.bold, color: AppColors.black)),
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

  /// VisitCard
  Widget visitCard(String name, date, time, IconData icon, VoidCallback method){
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
              height: Constant.height * .09,
              width: Constant.width * .38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(name, style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
                  Text(date, style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
                ],
              ),
            ),

            /// Time Container
            SizedBox(
              height: Constant.height * .09,
              width: Constant.width * .27,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(time, style: TextStyle(fontSize: Constant.width * .05, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
                  Text('Total Duration', style: TextStyle(fontSize: Constant.width * .04, color: AppColors.greyTextLightColor), maxLines: 1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
