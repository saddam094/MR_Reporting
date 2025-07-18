import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VisitsController extends GetxController{

  String today = DateFormat('d MMMM y').format(DateTime.now()).toString();

  final visits = [
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min'
    },
  ].obs;
}