// ignore_for_file: prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/services/notes_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';
import 'dart:io' show Platform;

import 'package:webview_flutter/webview_flutter.dart';

class SubjectNotesScreen extends StatefulWidget {
  static const String id = 'notes_screen';

  final String subject;
  final String isUrdu;

  const SubjectNotesScreen({
    Key? key,
    required this.subject,
    required this.isUrdu,
  }) : super(key: key);

  @override
  State<SubjectNotesScreen> createState() => _SubjectNotesScreenState();
}

class _SubjectNotesScreenState extends State<SubjectNotesScreen> {
  late bool loading;
  late List notesList;

  getNotes() async {
    await NotesService().notes(widget.subject).then((value) => setState(() {
          if (kDebugMode) {
            print(value);
          }
          List<dynamic> dataList = value['Notes'];
          notesList = dataList;
          if (kDebugMode) {
            print(notesList);
          }
          loading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getNotes();
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
          'Notes',
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
                                          fontSize:
                                              AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    widget.subject,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions
                                            .extralarge),
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
                                          fontSize:
                                              AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    AppConstants.session!,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions
                                            .extralarge),
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
                                          fontSize:
                                              AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    AppConstants.program!,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions
                                            .extralarge),
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
                    itemCount: notesList.length,
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
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      fontSize: AppDimensions.large,
                                      color: AppColors.blacklight),
                                ),
                              ],
                            ),
                            title: Column(
                              children: [
                                Text(
                                  "Chapter Name",
                                  style: TextStyle(
                                      fontSize: AppDimensions.large,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blacklight),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  notesList[index]['ChapterName'],
                                  style: TextStyle(
                                      fontSize: AppDimensions.large,
                                      color: AppColors.blacklight),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                                      "Chapter No : " + notesList[index]['ChapterNo'],
                                      style: TextStyle(
                                          fontSize:
                                              AppDimensions.large,
                                          color: AppColors.black),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.orange1,
                                    ),
                                    Text(
                                      "Description : " +
                                          notesList[index]['Description'],
                                      style: TextStyle(
                                          fontSize:
                                              AppDimensions.large,
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
                                                    NotesWebView(
                                                      notesLink:
                                                          notesList[index]
                                                              ['Link'],
                                                    )));
                                      },
                                      child: Text(
                                        'Download',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: AppDimensions
                                                .extralarge),
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

class NotesWebView extends StatefulWidget {
  String notesLink;
  NotesWebView({Key? key, required this.notesLink}) : super(key: key);

  @override
  State<NotesWebView> createState() => _NotesWebViewState();
}

class _NotesWebViewState extends State<NotesWebView> {
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
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.notesLink,
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
