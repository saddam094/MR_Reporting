import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/core/response/status.dart';
import 'package:mr_reporting/feature/particular_visit/presentation/controller/particular_visit_controller.dart';
import 'package:mr_reporting/res/color/app_color.dart';
import 'package:mr_reporting/res/common/common_app_bar.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';
import 'package:mr_reporting/res/utils/utils.dart';

class ParticularVisitScreen extends StatefulWidget {
  final String assignmentId;
  const ParticularVisitScreen({super.key, required this.assignmentId});

  @override
  State<ParticularVisitScreen> createState() => _ParticularVisitScreenState();
}

class _ParticularVisitScreenState extends State<ParticularVisitScreen> {

  final particularVisitVM = Get.put(ParticularVisitController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    particularVisitVM.particularVisit(widget.assignmentId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: 'Visit', backButton: true, onBackTap: () => Navigator.pop(context)),
      body: Container(
        height: Constant.height * .87,
        width: Constant.width * 1,
        padding: EdgeInsets.only(
            left: Constant.width * .03,
            right: Constant.width * .03,
            top: Constant.height * .01
        ),
        child: Obx(() {
          switch(particularVisitVM.rxRequestStatusParticularVisit.value){
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
              if (particularVisitVM.rxParticularVisitModel.value == null) {
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

              var data = particularVisitVM.rxParticularVisitModel.value;
              return SizedBox(
                height: Constant.height * .79,
                width: Constant.width * 1,
                child: Column(
                  children: [
                    /// Visit Details Container
                    Container(
                      height: Constant.height * .17,
                      width: Constant.width * 1,
                      padding: EdgeInsets.only(
                        top: Constant.height * .01,
                        left: Constant.width * .03,
                        right: Constant.width * .03,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(Constant.width * .04),
                        border: Border.all(
                          color: AppColors.primaryColor
                        )
                      ),

                      child: Column(
                        children: [
                          Text('Visit Details', style: TextStyle(fontSize: Constant.width * .045, fontWeight: FontWeight.bold, color: AppColors.black), maxLines: 1),
                          titleValue('Dr. Name', data!.doctor),
                          titleValue('Start', extractDate(data.startTime.toString())),
                          titleValue('End', extractDate(data.endTime.toString())),
                          titleValue('Status', data.status),
                        ],
                      ),
                    ),

                    SizedBox(height: Constant.height * .02),

                    particularVisitVM.rxParticularVisitModel.value!.status == "Assigned" 
                    ? InkWell(
                      onTap: () {
                        particularVisitVM.startVisit(widget.assignmentId);
                      },
                      child: Container(
                        height: Constant.height * .06,
                        width: Constant.width * 1,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Constant.width * .03),
                        ),
                        child: Center(
                          child: particularVisitVM.loading.value ? CircularProgressIndicator() :  Text('Start Visit', style: TextStyle(fontSize: Constant.width * .045, color: AppColors.white)),
                        ),
                      ),
                    )
                        : particularVisitVM.rxParticularVisitModel.value!.status == "Started"
                    ? InkWell(
                      onTap: () {
                        particularVisitVM.reachedVisit(widget.assignmentId);
                      },
                      child: Container(
                        height: Constant.height * .06,
                        width: Constant.width * 1,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(Constant.width * .03),
                        ),
                        child: Center(
                          child: particularVisitVM.loading.value ? CircularProgressIndicator() :  Text('Reached Location', style: TextStyle(fontSize: Constant.width * .045, color: AppColors.white)),
                        ),
                      ),
                    ) : particularVisitVM.rxParticularVisitModel.value!.status == "Reached"
                    ? SizedBox(
                      width: Constant.width * 1,
                      child: Column(
                        children: [
                          /// Text Field
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: particularVisitVM.noteController.value,
                              maxLines: null, // Expands as user types
                              minLines: 3,    // Minimum height like a textarea
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Enter your note',
                                hintText: 'Write your message here...',
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  Utils.toastMessageTop('Write Notes');
                                }

                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: Constant.height * .01),

                          /// Button
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                particularVisitVM.completeVisit(widget.assignmentId);
                              }
                            },
                            child: Container(
                              height: Constant.height * .06,
                              width: Constant.width * 1,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(Constant.width * .03),
                              ),
                              child: Center(
                                child: particularVisitVM.loading.value ? CircularProgressIndicator() : Text('Complete', style: TextStyle(fontSize: Constant.width * .045, color: AppColors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ) : SizedBox(),
                  ],
                ),
              );
          }

        },),
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
        Text('$title : ', style: TextStyle(fontSize: Constant.width * .045, color: AppColors.greyTextDarkColor, fontWeight: FontWeight.bold), maxLines: 1),
        Text(value, style: TextStyle(fontSize: Constant.width * .045, color: title == 'Status' ? AppColors.primaryColor : AppColors.greyTextLightColor), maxLines: 1),
      ],
    );
  }

}
