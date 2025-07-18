import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_reporting/feature/particular_visit/presentation/controller/particular_visit_controller.dart';
import 'package:mr_reporting/res/common/common_app_bar.dart';
import 'package:mr_reporting/res/constant/constant_data.dart';

class ParticularVisitScreen extends StatefulWidget {
  final String drName;
  final String status;
  const ParticularVisitScreen({super.key, required this.drName, required this.status});

  @override
  State<ParticularVisitScreen> createState() => _ParticularVisitScreenState();
}

class _ParticularVisitScreenState extends State<ParticularVisitScreen> {

  final particularVisitVM = Get.put(ParticularVisitController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context: context, title: widget.drName, backButton: true, onBackTap: () => Navigator.pop(context)),
      body: Container(
        height: Constant.height * .87,
        width: Constant.width * 1,
        padding: EdgeInsets.only(
            left: Constant.width * .03,
            right: Constant.width * .03,
            top: Constant.height * .01
        ),
        child: Center(
          child: Text(widget.status),
        ),
      ),
    );
  }
}
