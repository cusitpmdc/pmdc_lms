import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/services/fee_record_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';

class FeeRecordScreen extends StatefulWidget {
  static const String id = 'fee_record_screen';

  const FeeRecordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeeRecordScreen> createState() => _FeeRecordScreenState();
}

class _FeeRecordScreenState extends State<FeeRecordScreen> {
  late bool loading;
  late List feeRecordList;

  getFeeRecord() async {
    await FeeRecordService().feeRecord().then((value) => setState(() {
          if (kDebugMode) {
            print(value);
          }
          List<dynamic> dataList = value['studentfeedetail'];
          feeRecordList = dataList;
          if (kDebugMode) {
            print(feeRecordList);
          }
          loading = false;
        }));
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getFeeRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.blacklight,
        title: const Text(
          'Fee Record',
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
                                      "Student ID : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize:
                                              AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    AppConstants.regNo!,
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
                                      "Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize:
                                              AppDimensions.large),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      AppConstants.name!,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: AppDimensions
                                              .extralarge),
                                    ),
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
                    itemCount: feeRecordList.length,
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
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Head : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimensions.large,
                                        color: AppColors.blacklight),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text(
                                    feeRecordList[index]['Subhead'],
                                    style: TextStyle(
                                        fontSize: AppDimensions.large,
                                        color: AppColors.black),
                                    textAlign: TextAlign.center,
                                  ),
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
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "${"Month-Year : " +
                                          feeRecordList[index]['Month']}-" +
                                          feeRecordList[index]['Year'],
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
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Fee Amount : " +
                                          feeRecordList[index]['FeeAmount'],
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
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "IsPaid : " +
                                          feeRecordList[index]['IsPaid'],
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
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "Receive Date : " +
                                          feeRecordList[index]['ReceiveDate'],
                                      style: TextStyle(
                                          fontSize:
                                              AppDimensions.large,
                                          color: AppColors.black),
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
