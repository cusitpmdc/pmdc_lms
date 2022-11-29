import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pmdc_lms/utils/app_constants.dart';

class ProfileService {
  Future profile() async {
    final profileUrl = Uri.parse('${AppConstants.baseUrl}profile.php');
    log('PROFILE SERVICE::::::::: ${AppConstants.regNo}');
    var response = await http.post(profileUrl, body: {
      "regno": AppConstants.regNo,
      "campusid": AppConstants.campusid,
    });
    if (response.statusCode == 200) {
      // var data = response.body;
      // print("JSON DECODED DATA:" + jsonDecode(data));
      Map<String, dynamic> data = json.decode(response.body);
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
