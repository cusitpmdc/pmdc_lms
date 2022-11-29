import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/models/mcqs_chapter_model.dart';
import 'package:pmdc_lms/routes/argument_routes.dart';
import 'package:pmdc_lms/services/mcqs_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';
import 'package:pmdc_lms/views/screens/subjects/static_mcqs_screen.dart';

class McqsScreen extends StatefulWidget {
  static const String id = 'mcqs_screen';
  final String subject;
  final String isUrdu;

  const McqsScreen({
    Key? key,
    required this.subject,
    required this.isUrdu,
  }) : super(key: key);

  @override
  State<McqsScreen> createState() => _McqsScreenState();
}

class _McqsScreenState extends State<McqsScreen> {
  List<McqsChapterModel> mcqsChapters = List.empty(growable: true);
  McqsService mcqsService = McqsService();
  bool loading = false;
  String? selectedChapter;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        setState(() {
          loading = true;
        });
        final mcqsList = await mcqsService.mcqs(widget.subject);

        setState(() {
          mcqsChapters = mcqsList;
          loading = false;
        });
      } catch (e) {
        log("Error:$e");
        setState(() {
          loading = true;
        });
      }
    });
  }

  Future<void> getMcqsData() async {
    setState(() {
      loading = true;
    });
    await mcqsService.getMcqsData(selectedChapter!, widget.subject);
    setState(() {
      loading = true;
    });
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
          'MCQs ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: loading == true || mcqsChapters.isEmpty
          ? ShimmerEffect()
          : SafeArea(
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.shade500,
                            AppColors.orange2.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(05),
                        // color: Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Check Mcqs For Class-${(AppConstants.myClass)} & Subject ${widget.subject}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                  fontSize: AppDimensions.large),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Select chapter ",
                        style: TextStyle(
                            fontSize: AppDimensions.extralarge),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      DropdownButton<dynamic>(
                        items: mcqsChapters.map(
                          (list) {
                            return DropdownMenuItem(
                              value: list.chapterName,
                              child: Text(list.chapterName),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedChapter = value.toString();
                            //   print(value);
                            // AppConstants.campusid = value.toString();
                          });
                        },
                        value: selectedChapter,
                        hint: Row(
                          children: const [
                            Icon(
                              Icons.folder_outlined,
                              color: Colors.black45,
                            ),
                            Text('Select chapter'),
                          ],
                        ),
                        isExpanded: false,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  InkWell(
                      onTap: () async {
                        if (selectedChapter != null) {
                          Navigator.pushNamed(context, AttemptStaticMcqs.id,
                              arguments: AttemptstaticArgs(
                                widget.subject,
                                widget.isUrdu,
                                selectedChapter!,
                              ));
                        } else {
                          return;
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.primary.shade500,
                              AppColors.orange2.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Load ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                fontSize: AppDimensions.large),
                          ),
                        ),
                      ))

                ],
              ),
            )),
    );
  }
}
