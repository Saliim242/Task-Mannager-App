import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color snackdarkbarColor = Color(0xffdfe3e6);
const Color snacklightkbarColor = Color(0xff063b4c);
const Color AddTaskColor = Color(0xff003246F);
const Color blueClrColor = Color(0xFf4e5ae8);
const Color grenClrColor = Color(0xFfD600FF);
const Color yellowColor = Color(0xFFFFB800);
const Color PINKColor = Color(0xFFFF4667);
const Color whiteColor = Colors.white;
const primaryClr = blueClrColor;
const Color darkGrayColor = Color(0xff121212);
//const Color darkGrayColor = Color(0xFFFFB746);
Color darkHeader = Color(0xff424242);

class Themes {
  static final lightMode = ThemeData(
    backgroundColor: Color(0xfff5f7fa),
    //primarySwatch: primaryClr,
    primaryColor: primaryClr,

    brightness: Brightness.light,
  );
  static final darkMode = ThemeData(
    backgroundColor: darkGrayColor,
    primaryColor: darkGrayColor,
    brightness: Brightness.dark,
  );
}

// Style Of Date And Time
TextStyle get SubtitleHeaderText {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  ));
}

TextStyle get SubHeaderText {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    //fontFamily: "Pacifico",
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get HeaderText {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get SubTitleHintText {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
  ));
}
