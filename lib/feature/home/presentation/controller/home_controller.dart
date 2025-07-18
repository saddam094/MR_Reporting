import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController{

  String today = DateFormat('d MMMM y').format(DateTime.now()).toString();

  final todayVisits = [
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min',
      'status': 'Not Started'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min',
      'status': 'Completed'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min',
      'status': 'In Progress'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min',
      'status': 'On Hold'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Sharma',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '5 Min',
      'status': 'Not Started'
    },
    {
      'icon': Icons.local_hospital,
      'name': 'Dr Gupta',
      'date': DateFormat('d MMMM y').format(DateTime.now()).toString(),
      'time': '10 Min',
      'status': 'Not Started'
    },
  ].obs;
}