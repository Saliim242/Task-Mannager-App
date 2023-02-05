import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/Database/db_hellper.dart';

import 'package:flutter_to_do_app/screens_ui/home.dart';
import 'package:flutter_to_do_app/screens_ui/light_&_dark_theme.dart';
import 'package:flutter_to_do_app/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHellper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset(
            "images/95434-history.json",
            animate: true,
            height: 300,
            repeat: true,
          ),

          Center(
            child: Text(
              " DREAMS DON’T WORK UNLESS YOU DO. ",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Pacifico",
                fontWeight: FontWeight.w400,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          //Image.asset("images/appicon.png"),
        ],
      ),
      backgroundColor: context.theme.backgroundColor,
      nextScreen: HomeDetails(),
      splashIconSize: 450,
      duration: 5000,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      animationDuration: Duration(seconds: 1),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //Themes.lightMode
      theme: Themes.lightMode,
      // Themes.darkMode,
      darkTheme: Themes.darkMode,
      themeMode: ServiceThemes().theme,
      home: Splash(),
      //Getdetails()
    );
  }
}
