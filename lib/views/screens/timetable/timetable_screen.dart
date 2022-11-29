// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/services/pdf_service.dart';
import 'package:pmdc_lms/services/timetable_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/screens/pdfview/pdfview_screen.dart';

class TimeTableScreen extends StatefulWidget {
  static const String id = 'timetable_screen';
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  bool loading = false;
  late List timetableList;

  getTimetable() async {
    await TimetableService().timetable().then((value) async {
      String timeTableUrl;
      if (kDebugMode) {
        print(value);
      }
      setState(() {
        List<dynamic> dataList = value['studenttimetable'];
        timetableList = dataList;
        if (kDebugMode) {
          print(timetableList);
        }
      });
      timeTableUrl = 'http://${timetableList[0]['attachment']}';
      final file = await PDFService.loadPDFFromNetwork(timeTableUrl);
      setState(() {
        loading = false;
      });
      openPDF(context, file);
    });
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PdfViewScreen(file: file)),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.blacklight,
        title: const Text(
          'Time Table',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.shade500,
                      AppColors.orange2.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Class: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  fontSize: AppDimensions.large),
                            ),
                          ),
                          Text(
                            AppConstants.myClass!,
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppDimensions.extralarge),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Program: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  fontSize: AppDimensions.large),
                            ),
                          ),
                          Text(
                            AppConstants.program!,
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppDimensions.extralarge),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              "Section: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  fontSize: AppDimensions.large),
                            ),
                          ),
                          Text(
                            AppConstants.section!,
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppDimensions.extralarge),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.1, color: AppColors.primary),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: size.height * 0.745,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.clr9,
                      AppColors.clr7,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              "Class  Time  Table",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blacklight,
                                  fontSize: AppDimensions.overlarge),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Icon(
                            Icons.calendar_month,
                            size: 200,
                            color: AppColors.orange1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              getTimetable();
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: const Size(180, 40),
                              elevation: 2,
                              backgroundColor: AppColors.orange2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'View',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize:
                                          AppDimensions.extralarge),
                                ),
                                loading
                                    ? const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: CupertinoActivityIndicator(
                                          color: AppColors.white,
                                          radius: 15,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
