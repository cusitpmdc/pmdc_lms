import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pmdc_lms/utils/app_constants.dart';

class QueryToTeacherService {
  Future queryToTeacher(
    String teacherID,
    String studentQuery,
  ) async {
    final queryToTeacherUrl =
        Uri.parse('${AppConstants.baseUrl}SubmitQueryToTeacher.php');
    var response = await http.post(queryToTeacherUrl, body: {
      "TeacherID": teacherID,
      "StudentQuery": studentQuery,
      "CampusID": AppConstants.campusid,
      "RegNo": AppConstants.regNo,
      "StudentName": AppConstants.name,
    });
    // print(response.body + " myyyyyy ressssponseeeee");
    // print(response.statusCode.toString() + " myyyyyy ressssponseeeee");
    var result = json.decode(response.body);
    if (kDebugMode) {
      print(result);
    }
    if (result == "Success") {
      if (kDebugMode) {
        print('Success');
      }
    }
    if (response.statusCode == 200) {
      // var data = response.body;
      // print("JSON DECODED DATA:" + jsonDecode(data));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(data);
      }
      // print(data['status']);
      // print(data['data'][0]['regid']);
      return data;
    } else {
      // print('SOME error occurred i.e. ' + response.statusCode.toString());
    }
  }
}
