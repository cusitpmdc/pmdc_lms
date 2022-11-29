import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/services/examination_service.dart';
import 'package:pmdc_lms/services/pdf_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/views/screens/pdfview/pdfview_screen.dart';
import 'dart:io';

class ExaminationScreen extends StatefulWidget {
  static const String id = 'examination_screen';

  const ExaminationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  late bool loading;
  late List examinationList;

  getExamination() async {
    await ExaminationService().examination().then((value) async {
      String url;
      if (kDebugMode) {
        print(value);
      }
      setState(() {
        List<dynamic> dataList = value['StudentExamination'];
        examinationList = dataList;
        if (kDebugMode) {
          print(examinationList);
        }
      });
      // url = 'http://${examinationList[0]['Link']}';
      url =
          'http://pmdc.edu.pk/portal/cpanelE/students-result-cards/${AppConstants.campusid}/${AppConstants.regNo}.pdf';
      final file = await PDFService.loadPDFFromNetwork(url);
      // ignore: use_build_context_synchronously
      openPDF(context, file);
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getExamination();
  }

  void openPDF(BuildContext context, File file) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PdfViewScreen(file: file)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.blacklight,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Examination Record',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: loading
            ? const Center(
                child: CupertinoActivityIndicator(
                radius: 20,
              ))
            : Container());
  }
}
