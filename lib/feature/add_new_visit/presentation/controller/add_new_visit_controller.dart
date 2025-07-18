import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddNewVisitController extends GetxController{

  final drName = TextEditingController().obs;
  final type = 'Clinic'.obs;
  RxString specialist = 'Cardiology'.obs;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  RxBool loading = false.obs;

  void pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

}