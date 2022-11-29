import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/models/mcqs_chapter_model.dart';
import 'package:pmdc_lms/models/test_records_model.dart';
import 'package:pmdc_lms/services/mcqs_service.dart';
import 'package:pmdc_lms/services/test_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';
import 'package:pmdc_lms/views/screens/splash/splash_screen.dart';

class GenerateMcqsScreen extends StatefulWidget {
  static const String id = 'generate_mcqs_screen';
  final String subject;
  final String isUrdu;

  const GenerateMcqsScreen({
    Key? key,
    required this.subject,
    required this.isUrdu,
  }) : super(key: key);

  @override
  State<GenerateMcqsScreen> createState() => _GenerateMcqsScreenState();
}

class _GenerateMcqsScreenState extends State<GenerateMcqsScreen> {
  List<McqsChapterModel> mcqsChapters = List.empty(growable: true);
  McqsService mcqsService = McqsService();
  late bool loading;
  late List testList;
  String? selectedChapter;
  final List<TestRecordModel> testRecords = List.empty(growable: true);

  final testService = TestServices();

  Future<void> getTestRecords() async {
    try {
      final response = await testService.getTestRecords();
      for (final record in response['testRecords']) {
        testRecords.add(TestRecordModel.fromJson(record));
      }
      log(testRecords.length.toString());
      setState(() {
        loading = false;
      });
    } catch (e) {
      log('Error: $e');
      setState(() {
        loading = false;
      });
    }
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
  void initState() {
    super.initState();
    loading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTestRecords();
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
            'Test ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: loading
            ? ShimmerEffect()
            : Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 1.2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width * 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 1.5,
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                "A quiz for ${widget.subject} has been Generated for ${testRecords.first.testDate}",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: AppDimensions.large),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, GenerateMcqsScreen.id);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.orange2),
                                child: Center(
                                    child: Text(
                                  "No quiz for Today",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: AppDimensions.large),
                                )),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'S.No.',
                                    style: TextStyle(
                                        fontSize:
                                            AppDimensions.large),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                  ),
                                  Text(
                                    'Subject',
                                    style: TextStyle(
                                        fontSize:
                                            AppDimensions.large),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                  Text(
                                    "Test Date",
                                    style: TextStyle(
                                        fontSize:
                                            AppDimensions.large),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
                                  ),
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize:
                                            AppDimensions.large),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
                                  ),
                                  Text(
                                    'View',
                                    style: TextStyle(
                                        fontSize:
                                            AppDimensions.large),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // flex: 3,
                            child: Container(
                              color: Colors.white,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 3,
                                width: MediaQuery.of(context).size.width * 1.5,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: testRecords.length,
                                    itemBuilder: (context, index) {
                                      final indexItem = testRecords[index];
                                      // if (index == 0) {
                                      //   return Column(
                                      //     children: [
                                      //       // Row(
                                      //       //   children: [
                                      //       //     OutlinedButton(
                                      //       //       style: OutlinedButton.styleFrom(
                                      //       //         shape: RoundedRectangleBorder(
                                      //       //           borderRadius: BorderRadius.circular(10),
                                      //       //         ),
                                      //       //         fixedSize: const Size(180, 35),
                                      //       //         elevation: 5,
                                      //       //         backgroundColor: AppColors.orange2,
                                      //       //       ),
                                      //       //       onPressed: () {
                                      //       //         setState(() {
                                      //       //           loading = true;
                                      //       //           Navigator.pushNamed(
                                      //       //               context, TestScreen.id);
                                      //       //         });
                                      //       //       },
                                      //       //       child: Row(
                                      //       //         mainAxisAlignment:
                                      //       //             MainAxisAlignment.center,
                                      //       //         crossAxisAlignment:
                                      //       //             CrossAxisAlignment.center,
                                      //       //         children: [
                                      //       //           Text(
                                      //       //             'No Quiz For You',
                                      //       //             style: TextStyle(
                                      //       //                 color: AppColors.white,
                                      //       //                 fontSize: AppDimensions
                                      //       //                     .large),
                                      //       //           ),
                                      //       //           loading
                                      //       //               ? const Padding(
                                      //       //                   padding:
                                      //       //                       EdgeInsets.only(left: 8.0),
                                      //       //                   child:
                                      //       //                       CupertinoActivityIndicator(
                                      //       //                     color: AppColors.white,
                                      //       //                     radius: 15,
                                      //       //                   ),
                                      //       //                 )
                                      //       //               : const SizedBox(
                                      //       //                   height: 0,
                                      //       //                   width: 0,
                                      //       //                 )
                                      //       //         ],
                                      //       //       ),
                                      //       //     ),
                                      //       //   ],
                                      //       // ),

                                      // ],
                                      // );
                                      // }
                                      return DataTable(columns: [
                                       
                                        DataColumn(
                                          label: Text("",
                                         //   "S.No.",
                                            style: TextStyle(
                                                fontSize: AppDimensions
                                                    .large),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: AppDimensions
                                                    .large),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                           "",
                                            style: TextStyle(
                                                fontSize: AppDimensions
                                                    .large),
                                          ),
                                        ),
                                         const DataColumn(
                                          label: Text(
                                            '',
                                          ),
                                        ),
                                        const DataColumn(
                                          label: Text(""),
                                         
                                        )
                                      ], rows: [
                                        DataRow(cells: [
                                          DataCell(
                                            Text(
                                              '   ${(index + 1).toString()}',
                                              style: TextStyle(
                                                  fontSize: AppDimensions
                                                      .large),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              "   ${indexItem.subjectName}",
                                              style: TextStyle(
                                                  fontSize: AppDimensions
                                                      .large),
                                            ),
                                          ),
                                          DataCell( Text("    ${indexItem.testDate}",
                                            style: TextStyle(
                                                fontSize: AppDimensions
                                                    .large),
                                          ),),
                                          DataCell(Text(
                                            indexItem.status == '1'
                                                ? "    Attempted"
                                                : "   NotAttempted",
                                            style: TextStyle(
                                                fontSize: AppDimensions
                                                    .large),
                                          ),),
                                     
                                          DataCell(Column(mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              
                                              InkWell(
                                                onTap: indexItem.status == "0"
                                                    ? null
                                                    : () {
                                                        if (kDebugMode) {
                                                          print("error");
                                                        }
                                                        Navigator.pushNamed(
                                                            context, SplashScreen.id);
                                                      },
                                                child: Container(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.04,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.2,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: indexItem.status == "0"
                                                          ? Colors.red
                                                          : Colors.green,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "View",
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),),
                                        ]),
                                      ]);
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}


 