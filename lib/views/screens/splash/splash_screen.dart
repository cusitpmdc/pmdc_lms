import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pmdc_lms/utils/app_constants.dart';
import 'package:pmdc_lms/views/screens/auth/login_screen.dart';
import 'package:pmdc_lms/views/screens/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String id = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = prefs.getString('userData');

    if (currentUser != null) {
      log(json.decode(currentUser).toString());
      setState(() {
        AppConstants.regNo = json.decode(currentUser)['data'].first['regid'];
        AppConstants.campusid =
            json.decode(currentUser)['data'].first['campusid'];
      });
      log(AppConstants.regNo.toString());
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, DashboardScreen.id);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((_) {
      checkCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset(
              'assets/images/logo2.jpeg',
            ),
          ),
        ),
      ),
    );
  }
}
