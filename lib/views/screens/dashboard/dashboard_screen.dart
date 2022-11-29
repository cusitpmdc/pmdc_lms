// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pmdc_lms/services/profile_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/basewidgets/dashboard_card_2.dart';
import 'package:pmdc_lms/views/basewidgets/dashboard_card_3.dart';
import 'package:pmdc_lms/views/basewidgets/shimmer_effect.dart';
import 'package:pmdc_lms/views/screens/Drawer/drawer_screen.dart';
import 'package:pmdc_lms/views/screens/profile/profile_screen.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var profile;
  late bool loading;
  getProfile() async {
    await ProfileService().profile().then((value) => setState(() {
          if (kDebugMode) {
            print(value);
          }
          profile = value;
          if (kDebugMode) {
            print(profile);
          }
          AppConstants.name = profile['profile'][0]['name'];
          AppConstants.fname = profile['profile'][0]['fname'];
          AppConstants.dob = profile['profile'][0]['dob'];
          AppConstants.myClass = profile['profile'][0]['class'];
          AppConstants.program = profile['profile'][0]['program'];
          AppConstants.section = profile['profile'][0]['section'];
          AppConstants.picture = profile['profile'][0]['picture'];
          AppConstants.session = profile['profile'][0]['session'];

          loading = false;
        }));
  }

  Future<void> showMsg() async {
    try {
      setState(() {
        loading = true;
      });
      final response = await http.get(Uri.parse(
          "https://cu.edu.pk/pmdc_portal_api/sms.php?regno=${AppConstants.regNo}&campusid=${AppConstants.campusid}"));
      if (kDebugMode) {
        print(response.body);
      }
      if (json.decode(response.body)['SMS'] == "No Messages Found") {
        return;
      }
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.45,
                child: ListView.builder(
                  itemCount: json.decode(response.body)['SMS'].length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 05,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: AppColors.orange1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: AppDimensions.large),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          json.decode(response.body)['SMS'][index]['ÍsRead'] ==
                                  '1'
                              ? ""
                              : json.decode(response.body)['SMS'][index]
                                  ['Message'],
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: AppDimensions.large),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ],
                    );
                  },
                ),
              ),
              title: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.orange2),
                    child: const Center(
                      child: Text(
                        'Messages',
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    )),
              ),
              actions: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.orange2),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 14),
                        )),
                  ),
                )
              ],
            );
          });
      setState(() {
        loading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log(AppConstants.regNo!);
      await getProfile();
      await showMsg();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey.shade100,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.blacklight,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: loading
          ? ShimmerEffect(
              isDashboard: true,
            )
          : ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Card(
                        elevation: 3.r,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 130.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primary.withOpacity(0.9),
                                AppColors.primary.withOpacity(0.8),
                                AppColors.orange2.withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  Text(
                                    'Welcome Back,',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions.large),
                                  ),
                                  Flexible(
                                    child: Text(
                                      AppConstants.name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize: AppDimensions.large),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'ID: ${AppConstants.regNo}',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: AppDimensions.large),
                                    ),
                                  ),
                                  Text(
                                    'Class: ${AppConstants.myClass}',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: AppDimensions.large),
                                  ),
                                  const SizedBox(
                                    height: 0,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ProfileScreen.id);
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  radius: 56.r,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 54.r,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      radius: 52.r,
                                      child: ClipOval(
                                        child: Image.network(
                                            '${AppConstants.picture}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          const DashboardCardTwo(
                            labelText: 'Time Table',
                            iconData: Icons.calendar_month,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const DashboardCardTwo(
                            labelText: 'Attendance',
                            iconData: Icons.co_present_outlined,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const DashboardCardTwo(
                            labelText: 'Date Sheet',
                            iconData: Icons.date_range,
                          ),
                        ],
                      ),
                    ),
                    const DashboardCardThree(
                      labelText1: 'My Subjects',
                      labelText2: 'Test',
                    ),
                    const DashboardCardThree(
                      labelText1: 'Examination',
                      labelText2: 'Notice Board',
                    ),
                    const DashboardCardThree(
                      labelText1: 'Fee Record',
                      labelText2: 'Sign Out',
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
