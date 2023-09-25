import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/view/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:instagramclone/widgets/custom_bottom_bav_bar/custom_vab_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = FirebaseAuth.instance.currentUser != null ||
      prefs.getBool('auth') == true;

  runApp(MyApp(isLoggedIn: isLoggedIn, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final SharedPreferences prefs;
  const MyApp({super.key, required this.isLoggedIn, required this.prefs});

  @override
  Widget build(BuildContext context) {
    final Widget initialPage =
        isLoggedIn ? CustomBottomNavBar() : LoginScreen();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          title: 'InstgramApp',
          home: initialPage,
        );
      },
    );
  }
}
