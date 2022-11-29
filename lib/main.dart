import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmdc_lms/routes/argument_routes.dart';
import 'package:pmdc_lms/routes/app_routes.dart';
import 'package:pmdc_lms/services/all_campus_service.dart';
import 'package:pmdc_lms/utils/app_colors.dart';
import 'package:pmdc_lms/views/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await OneSignal.shared.setAppId('fe8159da-d7d5-493b-a029-f6161777c27f');
  await AllCampusService().getAllCampus();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PMDC LMS',
        theme: ThemeData(
            primarySwatch: AppColors.primary,
            fontFamily: GoogleFonts.lato().fontFamily),
        initialRoute: SplashScreen.id,
        routes: AppRoutes.routes,
        onGenerateRoute: ArgumentRoutes.onGenerateRoutes,
      );
    });
  }
}
