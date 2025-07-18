import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_reporting/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:mr_reporting/feature/home/presentation/view/home_screen.dart';
import 'package:mr_reporting/feature/visits/presentation/view/visits_screen.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardVM = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dashboardVM.getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Constant.height * 1,
        width: Constant.width * 1,
        color: AppColors.white,
        child: Obx(() {
          return Stack(
            children: [
              /// Pages
              dashboardVM.selectedPage.value == 'Home'
                  ? HomeScreen()
                  : VisitsScreen(),

              /// Nav Bar
              Positioned(
                top: Constant.height * .83,
                left: Constant.width * .285,
                child: Container(
                  height: Constant.height * .1,
                  width: Constant.width * .43,
                  padding: EdgeInsets.only(
                    left: Constant.width * .03,
                    right: Constant.width * .03,
                    top: Constant.height * .01,
                    bottom: Constant.height * .01,
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
                      borderRadius: BorderRadius.circular(Constant.width * .1)
                  ),

                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Home Button
                        InkWell(
                          onTap: () {
                            dashboardVM.selectedPage.value = 'Home';
                          },
                          child: Container(
                            height: Constant.height * .085,
                            width: Constant.width * .17,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.home, size: Constant.width * .08, color: dashboardVM.selectedPage.value == 'Home' ? AppColors.gradient2 : AppColors.greyTextLightColor),

                          ),
                        ),

                        /// Visits Button
                        InkWell(
                          onTap: () {
                            dashboardVM.selectedPage.value = 'Visits';
                          },
                          child: Container(
                            height: Constant.height * .085,
                            width: Constant.width * .17,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.work, size: Constant.width * .08, color: dashboardVM.selectedPage.value == 'Home' ? AppColors.greyTextLightColor : AppColors.gradient2),
                          ),
                        )
                      ],
                    );
                  },),
                ),
              )
            ],
          );
        },)
      ),
    );
  }
}
