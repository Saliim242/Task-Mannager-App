import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_to_do_app/controlles/task_controller.dart';
import 'package:flutter_to_do_app/models/task_model.dart';
import 'package:flutter_to_do_app/screens_ui/add_task_form.dart';

import 'package:flutter_to_do_app/screens_ui/light_&_dark_theme.dart';
import 'package:flutter_to_do_app/services/notification_services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Designs_Widget/AddButton.dart';
import '../Designs_Widget/task_form.dart';
import '../services/theme_services.dart';
import 'notification_details.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  DateTime _selectedDateTime = DateTime.now();
  //final _taskController = Get.put(TaskController());
  final TaskController _taskController = Get.put(TaskController());
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotificationHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    setState(() {
      print("You Succesed In HomePage");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building Succesed in HomePage");
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _AddTasks(),
          _DisplayDateTimePicker(),
          SizedBox(height: 14),
          _ShowTask(),
        ],
      ),
    );
  }

// cIWANKA Iyo Buttonka
  _AddTasks() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: SubtitleHeaderText,
                ),
                Text(
                  "Today",
                  style: SubHeaderText,
                ),
              ],
            ),
          ),
          // Addbutton(
          //     ButtonName: "+Add Task", ButtonFunction: () => AddTaskForm())
          // ElevatedButton
          // _ElevatedButtons(),
          Addbutton(
              ButtonName: "+ Add Task",
              ButtonFunction: () async {
                await Get.to(() => AddTaskForm());
                _taskController.getTaskList();
              })
        ],
      ),
    );
  }

//Elevated ButtonFunction: ()
  // _ElevatedButtons() {
  //   return Container(
  //     //margin: EdgeInsets.only(right: 20),
  //     // width: 100,
  //     height: 55,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const Getdetails()),
  //         );
  //       },
  //       child: Text("+ Get"),
  //       style: ElevatedButton.styleFrom(
  //         elevation: 0,
  //         primary: AddTaskColor,
  //         textStyle: TextStyle(fontSize: 16),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Displaying Date Time Picker Function
  // End _ElevatedButtons
  _DisplayDateTimePicker() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: AddTaskColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            // color: Color(0xffD4D4CE),
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            //color: Color(0xffD4D4CE),
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            // color: Color(0xffD4D4CE),
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDateTime = date;
          });
          // print(_selectedDateTime);
        },
      ),
    );
  }

  // Show Tasks to do
  _ShowTask() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(
                  " TaskController Value: ${_taskController.taskList.length}");

              TaskModel task = _taskController.taskList[index];
              print(task.toJson());
              if (task.repeating == 'Daily') {
                // DateTime date =
                //     DateFormat.jm().parse(task.startTime.toString());
                // DateTime time =
                //     DateFormat.jm().parse(task.startTime.toString());
                DateTime dt = DateFormat.jm().parse(task.startTime.toString());

                var myDate = DateFormat("HH:mm").format(dt);
                print(myDate);

                notifyHelper.scheduledNotification(
                  int.parse(myDate.toString().split(":")[0]),
                  int.parse(myDate.toString().split(":")[1]),
                  task,
                );

                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _ShowButtonSheet(context, task);

                              //_taskController.taskList[index] );
                            },
                            child: TaskTile(
                                task), // _taskController.taskList[index]
                          ),
                        ],
                      ),
                    )));
              }
              //---------------------------------
              if (task.repeating == 'None') {
                DateTime time =
                    DateFormat.jm().parse(task.startTime.toString());

                var myDate = DateFormat("HH:mm").format(time);

                notifyHelper.scheduledNotification(
                  int.parse(myDate.toString().split(":")[0]),
                  int.parse(myDate.toString().split(":")[1]),
                  task,
                );
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _ShowButtonSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    )));
              }
              //++++++++++++++++++++++++
              if (task.dateTime == DateFormat.yMd().format(_selectedDateTime)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _ShowButtonSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    )));
              } else {
                return Container();
              }
              // print(task.toJson());
            });
      }),
    );
  }

  // When The Task Taps The  Button Sheet Displaying
  _ShowButtonSheet(BuildContext, TaskModel task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isComplete == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGrayColor : snackdarkbarColor,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
              ),
            ),
            Spacer(),
            task.isComplete == 1
                ? Container()
                : _buttonmSheetButtons(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.TaskCompleted(task.id!);
                      _taskController.getTaskList();
                      Get.back();
                    },
                    clr: AddTaskColor,
                    context: context,
                  ),
            _buttonmSheetButtons(
              label: "Delete Task",
              onTap: () {
                _taskController.Delete(task);
                _taskController.getTaskList();
                Get.back();
              },
              clr: Color(0xffF39393),
              context: context,
            ),
            SizedBox(height: 8),
            _buttonmSheetButtons(
              label: "Close",
              onTap: () => Get.back(),
              clr: Colors.redAccent,
              isClosed: true,
              context: context,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Buttons In ButtonmSheet  We Will Succesed
  _buttonmSheetButtons(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClosed = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClosed == true
                ? Get.isDarkMode
                    ? Colors.grey[300]!
                    : Colors.grey[600]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(24),
          color: isClosed == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style:
              isClosed ? HeaderText : HeaderText.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  // Creating Our custom AppBar Theme
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: InkWell(
        onTap: () {
          ServiceThemes().changeTheme();
          // notifyHelper.displayNotification(
          //     title: "Changes Theme",
          //     body: Get.isDarkMode
          //         ? "activated light mode"
          //         : "Activated Dark  Mode");

          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round_sharp,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('images/sal.png'),
        ),
        SizedBox(width: 20)
      ],
    );
  }
}
