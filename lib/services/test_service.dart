import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:pmdc_lms/utils/app_constants.dart';

class TestServices {
  Future<Map<String, dynamic>> getTestRecords() async {
    try {
      final respone = await http.get(Uri.parse(
          '${AppConstants.baseUrl}/testRecords.php?campusid=${AppConstants.campusid}&regno=${AppConstants.regNo}'));
      log(respone.body);
      return json.decode(respone.body);
    } catch (e) {
      rethrow;
    }
  }
}
