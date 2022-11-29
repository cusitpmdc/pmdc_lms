import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/models/attempt_static_mcqs_model.dart';
import 'package:pmdc_lms/services/mcqs_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';

class AttemptStaticMcqs extends StatefulWidget {
  static const String id = "attemptstaticmcqs_screen";
  final String subject;
  final String isUrdu;
  final String chapter;
  const AttemptStaticMcqs(
      {Key? key,
      required this.isUrdu,
      required this.subject,
      required this.chapter})
      : super(key: key);

  @override
  State<AttemptStaticMcqs> createState() => _AttemptStaticMcqsState();
}

class _AttemptStaticMcqsState extends State<AttemptStaticMcqs> {
  McqsService mcqsService = McqsService();
  bool loading = false;
  bool check = true;
  bool value = false;
  final List<AttemptStaticMcqsModel> attemptStaticMcqs =
      List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAttemptMcqsData();
    });
  }

  Future<void> getAttemptMcqsData() async {
    try {
      setState(() {
        loading = true;
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      log('Error in Mcqs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.black,
          title: const Text(
            'Student Test Review ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
        ),
        body: loading
            ? ShimmerEffect()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Class : ${(AppConstants.myClass)} || Subject : ${(widget.subject)} || chapter : ${(widget.chapter)}",
                        style: TextStyle(
                            // fontStyle: FontStyle.italic,
                            color: AppColors.black,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 1,
                      width: MediaQuery.of(context).size.width * 1.5,
                      child: ListView.builder(
                          itemCount: 10,
                          // lectureList.length,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.48,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 2, color: Colors.red),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Table(
                                              columnWidths: {
                                                0: FixedColumnWidth(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.1),
                                              },
                                              border: TableBorder.symmetric(
                                                  outside: BorderSide(
                                                      width: 1,
                                                      color: AppColors.black)),
                                              // border: TableBorder.all(
                                              //     color: Colors.black,
                                              //     style: BorderStyle.solid,
                                              //     width: 1),
                                              children: [
                                                TableRow(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                        (index + 1).toString(),
                                                        style: TextStyle(
                                                          fontSize: AppDimensions
                                                              .large,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Breaking down of hydrogen peroxide into oxygen and water is carried by;',
                                                        style: TextStyle(
                                                          fontSize: AppDimensions
                                                              .large,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                ]),
                                              ],
                                            ),
                                            ListView.builder(
                                                itemCount: 4,
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      Table(
                                                        columnWidths: {
                                                          0: FixedColumnWidth(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12),
                                                          1: FixedColumnWidth(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.12),
                                                        },
                                                        border: TableBorder.symmetric(
                                                            outside: BorderSide(
                                                                width: 1,
                                                                color: AppColors
                                                                    .black)),
                                                        // border: TableBorder.all(
                                                        //     color: Colors.black,
                                                        //     style: BorderStyle.solid,
                                                        //     width: 1),
                                                        children: [
                                                          TableRow(children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          25.0),
                                                              child: Center(
                                                                child: Text(
                                                                    "${index + 1} )",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          AppDimensions
                                                                              .large,
                                                                      color: Colors
                                                                          .orange,
                                                                    )),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          25.0),
                                                              child: Center(
                                                                  child:
                                                                      Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                              )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      'represents',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppDimensions.large,
                                                                      )),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                    thickness:
                                                                        2,
                                                                  ),
                                                                  Text(
                                                                      'نمائندگی',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            AppDimensions.large,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Correct Answer is 1',
                                                style: TextStyle(
                                                  fontSize: AppDimensions
                                                      .large,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ),
                ],
              ));
  }
}
