import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/services/model_paper_service.dart';
import 'package:pmdc_lms/services/pdf_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/views/screens/pdfview/pdfview_screen.dart';
import 'dart:io';

class ModelPaperScreen extends StatefulWidget {
  static const String id = 'model_paper_screen';

  final String subject;
  final String isUrdu;
  const ModelPaperScreen({
    Key? key,
    required this.subject,
    required this.isUrdu,
  }) : super(key: key);

  @override
  State<ModelPaperScreen> createState() => _ModelPaperScreenState();
}

class _ModelPaperScreenState extends State<ModelPaperScreen> {
  late bool loading;
  late List modelPaperList;

  getModelPaper() async {
    await ModelPaperService()
        .modelPaper(widget.subject)
        .then((value) => setState(() async {
              if (kDebugMode) {
                print(value);
              }
              List<dynamic> dataList = value['ModelPaper'];
              modelPaperList = dataList;
              if (kDebugMode) {
                print(modelPaperList);
              }
              // http://pmdc.edu.pk/portal/cpanelE/uploadpapers/75df636098_BIO.pdf
              const url =
                  'http://pmdc.edu.pk/portal/cpanelE/syllabus/678632Biology.pdf';
              final file = await PDFService.loadPDFFromNetwork(url);
              // ignore: use_build_context_synchronously
              openPDF(context, file);
              loading = false;
            }));
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getModelPaper();
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
            'Model Paper',
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
