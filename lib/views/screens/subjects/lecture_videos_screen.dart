import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/services/lecture_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';
import 'dart:io' show Platform;

import 'package:webview_flutter/webview_flutter.dart';

class LectureVideosScreen extends StatefulWidget {
  static const String id = 'lecture_screen';

  final String subject;
  final String isUrdu;

  const LectureVideosScreen({
    Key? key,
    required this.subject,
    required this.isUrdu,
  }) : super(key: key);

  @override
  State<LectureVideosScreen> createState() => _LectureVideosScreenState();
}

class _LectureVideosScreenState extends State<LectureVideosScreen> {
  late bool loading;
  late List lectureList;

  getLectures() async {
    await LectureService()
        .lectures(widget.subject)
        .then((value) => setState(() {
              if (kDebugMode) {
                print(value);
              }
              List<dynamic> dataList = value['Lectures'];
              lectureList = dataList;
              if (kDebugMode) {
                print(lectureList);
              }
              loading = false;
            }));
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getLectures();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.blacklight,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'Lectures',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: loading
          ? ShimmerEffect()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "Subject : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize: AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    widget.subject,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions.extralarge),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      "Session: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize: AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    AppConstants.session!,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions.extralarge),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: lectureList.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            backgroundColor: index % 2 == 0
                                ? AppColors.clr9
                                : AppColors.clr7,
                            collapsedBackgroundColor: AppColors.clr9,
                            leading: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: AppDimensions.large,
                                  color: AppColors.black),
                            ),
                            title: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              "Ch : " + lectureList[index]['ChapterName'],
                              style: TextStyle(
                                  fontSize: AppDimensions.large,
                                  color: AppColors.black),
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.orange1,
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Chapter No : " +
                                          lectureList[index]['ChapterNo'],
                                      style: TextStyle(
                                          fontSize: AppDimensions.large,
                                          color: AppColors.black),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.orange1,
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Topic : " + lectureList[index]['Topic'],
                                      style: TextStyle(
                                          fontSize: AppDimensions.large,
                                          color: AppColors.black),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.orange1,
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Teacher Name : " +
                                          lectureList[index]['TeacherName'],
                                      style: TextStyle(
                                          fontSize: AppDimensions.large,
                                          color: AppColors.black),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.orange1,
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Date : " + lectureList[index]['Date'],
                                      style: TextStyle(
                                          fontSize: AppDimensions.large,
                                          color: AppColors.black),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.orange1,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: Size(double.maxFinite,
                                            size.height * 0.05),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: AppColors.orange1,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LectureWebView(
                                                      lectureLink:
                                                          lectureList[index]
                                                              ['Link'],
                                                    )));
                                      },
                                      child: Text(
                                        'Video',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: AppDimensions.extralarge),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
    );
  }
}

// ignore: must_be_immutable
class LectureWebView extends StatefulWidget {
  String lectureLink;
  LectureWebView({Key? key, required this.lectureLink}) : super(key: key);

  @override
  State<LectureWebView> createState() => _LectureWebViewState();
}

class _LectureWebViewState extends State<LectureWebView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.blacklight,
        title: const Text(
          'Video Lecture',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.lectureLink,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}
