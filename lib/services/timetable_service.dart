import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pmdc_lms/utils/app_constants.dart';

class TimetableService {
  Future timetable() async {
    final timetableUrl =
        Uri.parse('${AppConstants.baseUrl}studentTimetable.php');
    var response = await http.post(timetableUrl, body: {
      "regno": AppConstants.regNo,
      "campusid": AppConstants.campusid,
      "sessionid": AppConstants.session,
    });
    if (response.statusCode == 200) {
      // var data = response.body;
      // print("JSON DECODED DATA:" + jsonDecode(data));
      Map<String, dynamic> data = json.decode(response.body);
      // print(data);
      // print(data['status']);
      // print(data['data'][0]['regid']);
      return data;
    } else {
      if (kDebugMode) {
        print('SOME error occurred i.e. ${response.statusCode}');
      }
    }
  }
}
