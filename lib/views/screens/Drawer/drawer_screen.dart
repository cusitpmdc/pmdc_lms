// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/utils/app_dimensions.dart';
import 'package:pmdc_lms/views/screens/attendance/attendance_screen.dart';
import 'package:pmdc_lms/views/screens/auth/login_screen.dart';
import 'package:pmdc_lms/views/screens/dashboard/dashboard_screen.dart';
import 'package:pmdc_lms/views/screens/datesheet/datesheet_screen.dart';
import 'package:pmdc_lms/views/screens/examination/examination_screen.dart';
import 'package:pmdc_lms/views/screens/fee_record/fee_record_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/subject_screen.dart';
import 'package:pmdc_lms/views/screens/timetable/timetable_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary.shade50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Card(
                      elevation: 0,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.only(
                      //     bottomRight: Radius.circular(20),
                      //   ),
                      // ),
                      child: SizedBox(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          width: double.infinity,
                          height: 150,
                          child: Image.asset('assets/images/logo2.jpeg')),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(DashboardScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Dashboard',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SubjectScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(
                'My Subjects',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, TimeTableScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(
                'Time Table',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AttendanceScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.table_view_outlined),
              title: Text(
                'Attendance',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, DateSheetScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(
                'Date Sheet',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ExaminationScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.explicit_outlined),
              title: Text(
                'Examination',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FeeRecordScreen.id);
            },
            child: ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: Text(
                'Fee Record',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Divider(
            thickness: 1,
          ),
          // InkWell(
          //   onTap: () {
          //     // Navigator.pushReplacement(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => StudentChangePassword(),
          //     //   ),
          //     // );
          //   },
          //   child: ListTile(
          //     leading: Icon(Icons.lock),
          //     title: Text(
          //       'Change Password',
          //       style: TextStyle(
          //           color: AppColors.black,
          //           fontSize: AppDimensions.large),
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: () async {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  'Successfully Sign Out',
                  textAlign: TextAlign.center,
                ),
                duration: Duration(seconds: 1),
              ));
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('userData');
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.id, (Route<dynamic> route) => false);
              if (kDebugMode) {
                print('Before signout:${AppConstants.campusid}');
              }
              setState(() {
                AppConstants.campusid = null;
              });

              if (kDebugMode) {
                print('After signout:${AppConstants.campusid}');
              }
            },
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppDimensions.large),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
