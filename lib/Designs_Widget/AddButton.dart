import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/screens_ui/light_&_dark_theme.dart';
import 'package:get/get.dart';

class Addbutton extends StatelessWidget {
  final String ButtonName;
  final Function()? ButtonFunction;

  const Addbutton(
      {Key? key, required this.ButtonName, required this.ButtonFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ButtonFunction,
      child: Container(
        padding: EdgeInsets.all(12),
        width: 120,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AddTaskColor,
        ),
        child: Center(
          child: Text(
            ButtonName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
