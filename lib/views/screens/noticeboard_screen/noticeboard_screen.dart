import 'package:flutter/material.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';

class NoticeboardScreen extends StatefulWidget {
  static const String id = "noticeboard_screen";
  const NoticeboardScreen({Key? key}) : super(key: key);

  @override
  State<NoticeboardScreen> createState() => _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.blacklight,
          title: const Text(
            'All Notice',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body:
            //  loading
            //     ? ShimmerEffect()
            //     :
            SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1.5,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text('S .No : ',
                            style: TextStyle(
                                fontSize: AppDimensions.extralarge,
                                color: Colors.black)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.045,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.withOpacity(0.9),
                            AppColors.primary.withOpacity(0.7),
                            AppColors.orange2.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(
                              MediaQuery.of(context).size.width * 0.15),
                        },
                        children: [
                          TableRow(children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                child: Text('S .No',
                                    style: TextStyle(
                                        fontSize: AppDimensions.extralarge,
                                        color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                child: Text('Campus',
                                    style: TextStyle(
                                        fontSize: AppDimensions.extralarge,
                                        color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                child: Text('Publish Date',
                                    style: TextStyle(
                                        fontSize: AppDimensions.extralarge,
                                        color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                child: Text('Deadline Date',
                                    style: TextStyle(
                                        fontSize: AppDimensions.extralarge,
                                        color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Center(
                                child: Text('Actions',
                                    style: TextStyle(
                                        fontSize: AppDimensions.extralarge,
                                        color: Colors.white)),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   // flex: 3,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: 100,
                  //       //  testRecords.length ,
                  //       itemBuilder: (context, index) {
                  //         // final indexItem = testRecords[index];
                  //         // ignore: prefer_const_literals_to_create_immutables
                  //         return Padding(
                  //           padding: const EdgeInsets.all(5.0),
                  //           child: Table(
                  //             columnWidths: {
                  //               0: FixedColumnWidth(size.width * 0.15),
                  //             },
                  //             border: TableBorder.symmetric(
                  //                 outside: BorderSide(
                  //                     width: 1, color: AppColors.black)),
                  //             // TableBorder.all(
                  //             //     color: Colors.black,
                  //             //     style: BorderStyle.solid,
                  //             //     width: 1),
                  //             children: [
                  //               TableRow(children: [
                  //                 SizedBox(
                  //                   height: size.height * 0.05,
                  //                   child: Center(
                  //                     child: Text((index + 1).toString(),
                  //                         style: TextStyle(
                  //                             fontSize: AppDimensions
                  //                                 .FONT_SIZE_LARGE)),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: size.height * 0.05,
                  //                   child: Center(
                  //                     child: Text('PMDC Dalazak Road',
                  //                         style: TextStyle(
                  //                             fontSize: AppDimensions
                  //                                 .FONT_SIZE_LARGE)),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: size.height * 0.05,
                  //                   child: Center(
                  //                     child: Text('Fine',
                  //                         style: TextStyle(
                  //                             fontSize: AppDimensions
                  //                                 .FONT_SIZE_LARGE)),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: size.height * 0.05,
                  //                   child: Center(
                  //                     child: Text('2014-02-02',
                  //                         style: TextStyle(
                  //                             fontSize: AppDimensions
                  //                                 .FONT_SIZE_LARGE)),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: size.height * 0.05,
                  //                   child: Center(
                  //                     child: Text('2014-02-02',
                  //                         style: TextStyle(
                  //                             fontSize: AppDimensions
                  //                                 .FONT_SIZE_LARGE)),
                  //                   ),
                  //                 ),
                  //               ]),
                  //             ],
                  //           ),
                  //         );
                  //       }),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
