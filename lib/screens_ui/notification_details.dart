import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/task_model.dart';
import 'package:get/get.dart';

import 'light_&_dark_theme.dart';

class NotificationDetailsPage extends StatelessWidget {
  final String? label;

  const NotificationDetailsPage({Key? key, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme
            .backgroundColor, //Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          //task.title.toString(),
          this.label.toString().split("|")[0],
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Container(
            child: Text(
              "    DREAMS COME TRUE ",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 18,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "         IF YOU CAN DREAM IT, YOU CAN DO IT ",
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 400,
            width: 280,
            margin: EdgeInsets.only(left: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Get.isDarkMode ? Colors.white : AddTaskColor,
            ),
            child: Container(
              //
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // title Ka Waye
                  Container(
                    margin: EdgeInsets.only(top: 35, left: 20),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.title,
                          size: 30,
                          color:
                              Get.isDarkMode ? AddTaskColor : Colors.grey[300],
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Title",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        // Text(gettask.title.toString())
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Qoralka title
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      //task!.title.toString(),
                      this.label.toString().split("|")[0],
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // Noteka Waaayer
                  Container(
                    margin: EdgeInsets.only(top: 35, left: 20),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.description_rounded,
                          size: 30,
                          color:
                              Get.isDarkMode ? AddTaskColor : Colors.grey[300],
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Description",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Note-ka Qoralka Ah
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      // task.notes.toString(),
                      this.label.toString().split("|")[1],
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // Timer ka
                  Container(
                    margin: EdgeInsets.only(top: 35, left: 20),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.timer,
                          size: 30,
                          color:
                              Get.isDarkMode ? AddTaskColor : Colors.grey[300],
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Time ",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      // task.startTime.toString(),
                      this.label.toString().split("|")[2],
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
