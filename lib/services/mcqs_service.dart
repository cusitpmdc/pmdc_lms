import 'dart:convert';
import 'dart:developer';
import 'package:pmdc_lms/models/mcqs_chapter_model.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class McqsService {
  Future<List<McqsChapterModel>> mcqs(String subject) async {
    List<McqsChapterModel> mcqsChapters = List.empty(growable: true);
    final mcqsUrl = Uri.parse('${AppConstants.baseUrl}chapters.php');
    var response = await http.post(mcqsUrl, body: {
      "subject": subject,
      "regno": AppConstants.regNo,
      "campusid": AppConstants.campusid,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Chapters'];
      for (final chapter in data) {
        mcqsChapters.add(McqsChapterModel.fromJson(chapter));
      }

      log(data.toString());

      return mcqsChapters;
    } else {
      throw 'error';
      // print('SOME error occurred i.e. ' + response.statusCode.toString());
    }
  }

  Future<void> getMcqsData(String subject, String chapter) async {
    final gmcqsUrl = Uri.parse('${AppConstants.baseUrl}viewMCQS.php');
    var response = await http.post(gmcqsUrl, body: {
      "subject": subject,
      "regno": AppConstants.regNo,
      "campusid": AppConstants.campusid,
      "chapter": chapter,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // for (final chapter in data){
      //   gmcqsChapters.add(McqsChapterModel.fromJson(chapter));
      // }

      log(data.toString());

      //return gmcqsChapters;
    } else {
      throw 'error';
      // print('SOME error occurred i.e. ' + response.statusCode.toString());
    }
  }
  Future<void> getAttemptMcqsData(String subject, String chapter) async {
    final gmcqsUrl = Uri.parse('${AppConstants.baseUrl}loadreviewmcqs.php');
    var response = await http.post(gmcqsUrl, body: {
      "subject": subject,
      "class":AppConstants.myClass,
      "chapter": chapter,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // for (final chapter in data){
      //   gmcqsChapters.add(McqsChapterModel.fromJson(chapter));
      // }

      log(data.toString());

      //return gmcqsChapters;
    } else {
      throw 'error';
      // print('SOME error occurred i.e. ' + response.statusCode.toString());
    }
  }
}
