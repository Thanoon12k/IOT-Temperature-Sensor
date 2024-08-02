// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

const String sheetUrl =
    'https://script.google.com/macros/s/AKfycbyc1RC0KPIg2ZvgtOJLiCqJGgLgoGUlwXapYgbE-nPKKBdQrVQd_yzyniQ63Eh30oVJ0A/exec';

Future<List<Sensor>> getsensorsList(String? filtertype) async {
  List<dynamic> jsonData = await fetchData(sheetUrl);
  List<Sensor> sensorsList = jsonData.map((el) => Sensor.fromJson(el)).toList();
  List<Sensor> distinctSensors = [];

  var now = DateTime.now();

  DateTime startMonthDate =
      now.subtract(const Duration(days: 30)); // Calculate date 30 days ago
  DateTime startWeekhDate =
      now.subtract(const Duration(days: 7)); // Calculate date 30 days ago
  DateTime startDayDate =
      now.subtract(const Duration(days: 1)); // Calculate date 30 days ago

  switch (filtertype) {
    case "monthly":
      for (Sensor sensor in sensorsList) {
        if (sensor.date.isAfter(startMonthDate) &&
            !distinctSensors.any((e) => e.date.day == sensor.date.day)) {
          distinctSensors.add(sensor);
        }
      }
      
      print(
          'monthly  : ${distinctSensors.length}  outcomes >> ${distinctSensors.first.date}       ---   ${distinctSensors.last.date}');
      return distinctSensors.getRange(0, 31).toList();
    case "weekly":
      for (Sensor sensor in sensorsList) {
        if (sensor.date.isAfter(startWeekhDate) &&
            !distinctSensors.any((e) => e.date.day == sensor.date.day)) {
          distinctSensors.add(sensor);
        }
      }
      print(
          'weekly  : ${distinctSensors.length} outcomes >> ${distinctSensors.first.date}       ---   ${distinctSensors.last.date}');
      return distinctSensors.getRange(0, 7).toList();

    case "daily":
      for (Sensor sensor in sensorsList) {
        if (sensor.date.isAfter(startDayDate) &&
            !distinctSensors.any((e) => e.date.day == sensor.date.day)) {
          distinctSensors.add(sensor);
        }
      }
      print(
          'daily  : ${distinctSensors.length} outcomes >> ${distinctSensors.first.date}       ---   ${distinctSensors.last.date}');
      return distinctSensors.getRange(0, 12).toList();
    case null:
      print("iam in null");
      return [];
    default:
      print("iam in default");
      return [];
  }
  return [];
}

Future<List<dynamic>> fetchData([String url = sheetUrl]) async {
  final response = await http.get(Uri.parse(url));
  List<dynamic> jsondata = jsonDecode(response.body);

  return jsondata;
}

class Sensor {
  double temperatorValue;
  double hummidityValue;
  String dayName;
  DateTime date;
  String timeOfDay;

  Sensor(
      {required this.date,
      required this.timeOfDay,
      required this.dayName,
      required this.temperatorValue,
      required this.hummidityValue});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      date: DateTime.parse(json['Date']),
      timeOfDay: json['Time'],
      dayName: json['WeekDay'],
      temperatorValue: json['Tempreature'].toDouble(),
      hummidityValue: json['Humidity'].toDouble(),
    );
  }
}
