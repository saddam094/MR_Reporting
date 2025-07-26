import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mr_reporting/feature/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:mr_reporting/feature/home/presentation/view/home_screen.dart';
import 'package:mr_reporting/feature/more/presentation/view/more_screen.dart';
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
          child: Obx(
            () {
              return Stack(
                children: [
                  /// Pages
                  dashboardVM.selectedPage.value == 'Home'
                      ? HomeScreen()
                      : dashboardVM.selectedPage.value == 'Visits'
                          ? VisitsScreen()
                          : MoreScreen(),

                  /// Nav Bar
                  Positioned(
                    top: Constant.height * .87,
                    left: Constant.width * .15,
                    child: Container(
                      height: Constant.height * .08,
                      width: Constant.width * .7,
                      padding: EdgeInsets.only(
                        left: Constant.width * .03,
                        right: Constant.width * .03,
                        top: Constant.height * .01,
                        bottom: Constant.height * .005,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(Constant.width * .04),
                          border: Border.all(color: AppColors.gradient1)),
                      child: Obx(
                        () {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Home Button
                              InkWell(
                                onTap: () {
                                  dashboardVM.selectedPage.value = 'Home';
                                },
                                child: SizedBox(
                                  height: Constant.height * .075,
                                  width: Constant.width * .17,
                                  child: Column(
                                    children: [
                                      Icon(Icons.home,
                                          size: Constant.width * .08,
                                          color: dashboardVM
                                                      .selectedPage.value ==
                                                  'Home'
                                              ? AppColors.gradient2
                                              : AppColors.greyTextLightColor),
                                      Text('Home',
                                          style: TextStyle(
                                              fontSize: Constant.width * .035,
                                              color: dashboardVM
                                                          .selectedPage.value ==
                                                      'Home'
                                                  ? AppColors.gradient2
                                                  : AppColors
                                                      .greyTextLightColor)),
                                    ],
                                  ),
                                ),
                              ),

                              /// Visits Button
                              InkWell(
                                onTap: () {
                                  dashboardVM.selectedPage.value = 'Visits';
                                },
                                child: SizedBox(
                                  height: Constant.height * .075,
                                  width: Constant.width * .17,
                                  child: Column(
                                    children: [
                                      Icon(Icons.work,
                                          size: Constant.width * .08,
                                          color: dashboardVM
                                                      .selectedPage.value ==
                                                  'Visits'
                                              ? AppColors.gradient2
                                              : AppColors.greyTextLightColor),
                                      Text('Visits',
                                          style: TextStyle(
                                              fontSize: Constant.width * .035,
                                              color: dashboardVM
                                                          .selectedPage.value ==
                                                      'Visits'
                                                  ? AppColors.gradient2
                                                  : AppColors
                                                      .greyTextLightColor)),
                                    ],
                                  ),
                                ),
                              ),

                              /// More Button
                              InkWell(
                                onTap: () {
                                  dashboardVM.selectedPage.value = 'More';
                                },
                                child: SizedBox(
                                  height: Constant.height * .075,
                                  width: Constant.width * .17,
                                  child: Column(
                                    children: [
                                      Icon(Icons.person,
                                          size: Constant.width * .08,
                                          color: dashboardVM
                                                      .selectedPage.value ==
                                                  'More'
                                              ? AppColors.gradient2
                                              : AppColors.greyTextLightColor),
                                      Text('More',
                                          style: TextStyle(
                                              fontSize: Constant.width * .035,
                                              color: dashboardVM
                                                          .selectedPage.value ==
                                                      'More'
                                                  ? AppColors.gradient2
                                                  : AppColors
                                                      .greyTextLightColor)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
