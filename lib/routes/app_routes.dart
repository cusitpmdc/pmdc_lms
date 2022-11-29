import 'package:flutter/material.dart';
import 'package:pmdc_lms/views/screens/attendance/attendance_screen.dart';
import 'package:pmdc_lms/views/screens/auth/login_screen.dart';
import 'package:pmdc_lms/views/screens/dashboard/dashboard_screen.dart';
import 'package:pmdc_lms/views/screens/datesheet/datesheet_screen.dart';
import 'package:pmdc_lms/views/screens/examination/examination_screen.dart';
import 'package:pmdc_lms/views/screens/fee_record/fee_record_screen.dart';
import 'package:pmdc_lms/views/screens/noticeboard_screen/noticeboard_screen.dart';
import 'package:pmdc_lms/views/screens/profile/profile_screen.dart';
import 'package:pmdc_lms/views/screens/splash/splash_screen.dart';
import 'package:pmdc_lms/views/screens/subjects/subject_screen.dart';
import 'package:pmdc_lms/views/screens/test/test_screen.dart';
import 'package:pmdc_lms/views/screens/timetable/timetable_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.id: (ctx) => const LoginScreen(),
    DashboardScreen.id: (context) => const DashboardScreen(),
    ProfileScreen.id: (context) => const ProfileScreen(),
    SubjectScreen.id: (context) => const SubjectScreen(),
    TimeTableScreen.id: (context) => const TimeTableScreen(),
    FeeRecordScreen.id: (context) => const FeeRecordScreen(),
    AttendanceScreen.id: (context) => const AttendanceScreen(),
    DateSheetScreen.id: (context) => const DateSheetScreen(),
    ExaminationScreen.id: (context) => const ExaminationScreen(),
    NoticeboardScreen.id: (context) => const NoticeboardScreen(),
    TestScreen.id: (context) => const TestScreen(),
    SplashScreen.id: (context) => const SplashScreen()
  };
}
