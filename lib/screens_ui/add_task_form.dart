import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/Designs_Widget/AddButton.dart';
import 'package:flutter_to_do_app/Designs_Widget/input_feilds.dart';
import 'package:flutter_to_do_app/models/task_model.dart';
import 'package:flutter_to_do_app/screens_ui/home.dart';
import 'package:flutter_to_do_app/screens_ui/light_&_dark_theme.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controlles/task_controller.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int _ColorChoosed = 0;
  String _Timereapts = "None";
  List<String> _ReaptsDialyTime = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _DefaultSelector = 5;
  List<int> _Selector = [
    5,
    10,
    15,
    20,
  ];
  DateTime _dateTime = DateTime.now();
  String _EndTime = "11:30 AM";
  String _StartTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Tasks", style: SubHeaderText),
              // Task Title input_feilds
              InputFeilds(
                  title: "Title",
                  hint: "Enter your task title",
                  controller: _titleController),
              // Note Title input_feilds
              InputFeilds(
                  title: "Note",
                  hint: "Enter your note",
                  controller: _noteController),
              //Callender  input_feilds
              InputFeilds(
                title: "Date",
                hint: DateFormat.yMd().format(_dateTime),
                widget: IconButton(
                  onPressed: () {
                    setState(() {
                      _getUserData();
                    });
                  },
                  icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
                ),
              ),

              // This The   Two Types Of Time
              Row(
                children: [
                  Expanded(
                    child: InputFeilds(
                      title: "Start Time ",
                      hint: _StartTime,
                      widget: IconButton(
                        onPressed: () {
                          _userPikerTime(isStart: true);
                        },
                        icon: Icon(Icons.access_time_outlined),
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  // End Time Part
                  Expanded(
                    child: InputFeilds(
                      title: "End Time ",
                      hint: _EndTime,
                      widget: IconButton(
                        onPressed: () {
                          _userPikerTime(isStart: false);
                        },
                        icon: Icon(Icons.access_time_outlined),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              // Reminder Time InputFeilds
              InputFeilds(
                title: "Remaind",
                hint: "$_DefaultSelector  minutes early",
                widget: DropdownButton(
                  onChanged: (String? newValue) {
                    setState(() {
                      _DefaultSelector = int.parse(newValue!);
                    });
                  },
                  underline: Container(
                    height: 0,
                  ),
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  iconSize: 32,
                  elevation: 6,
                  style: SubTitleHintText,
                  items: _Selector.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Repeat Time InputFeilds
              InputFeilds(
                title: "Repeat",
                hint: "$_Timereapts",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  iconSize: 32,
                  elevation: 5,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _Timereapts = newValue!;
                    });
                  },
                  items: _ReaptsDialyTime.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _SelectedColor(),
                  //_ElevatedButtons(),
                  Addbutton(
                      ButtonName: "Create Task",
                      ButtonFunction: () => _DataValidator())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Validate the User Type InputFeilds
  _DataValidator() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // Add To the Databasename
      _AddTasksToDatabes();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required Fileds",
        "All Empty Fields Are Required ! ",
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        // forwardAnimationCurve: Curves.easeInOutExpo,
        overlayBlur: 1,
        overlayColor: Colors.black45,

        borderRadius: 12.0,
        backgroundColor:
            Get.isDarkMode ? snackdarkbarColor : snacklightkbarColor,
        icon: Icon(
          Get.isDarkMode ? Icons.warning_rounded : Icons.warning_rounded,
          size: 20,
          color: Get.isDarkMode ? AddTaskColor : snackdarkbarColor,
        ),
        colorText: Get.isDarkMode ? AddTaskColor : snackdarkbarColor,
      );
    }
  }

  // Add database
  _AddTasksToDatabes() async {
    int value = await _taskController.addTask(
      tasks: TaskModel(
        notes: _noteController.text,
        title: _titleController.text,
        dateTime: DateFormat.yMd().format(_dateTime),
        startTime: _StartTime,
        endTime: _EndTime,
        remind: _DefaultSelector,
        repeating: _Timereapts,
        setColor: _ColorChoosed,
        isComplete: 0,
      ),
    );
    print(" my id  is " + "$value");
    //print("Color Choosed: " + "$setCol");
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('images/user.png'),
        ),
        SizedBox(width: 20)
      ],
    );
  }

  _getUserData() async {
    DateTime? _DatePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1995),
        lastDate: DateTime(2030));

    if (_DatePicker != null) {
      setState(() {
        _dateTime = _DatePicker;
      });
    } else {
      print("No date picker");
    }
  }

  _userPikerTime({required bool isStart}) async {
    var PickerTime = await _ShowpickerTimer();
    String _formatedTime = PickerTime.format(context);
    // String _timeFormated = PickerTime.format(context);
    if (PickerTime == null) {
      print("No Time picker");
    } else if (isStart == true) {
      setState(() {
        _StartTime = _formatedTime;
      });
    } else if (isStart == false) {
      setState(() {
        _EndTime = _formatedTime;
      });
    }
  }

  _ShowpickerTimer() {
    return showTimePicker(
      // initialEntryMode: TimePickerEntryMode.input,
      initialEntryMode: TimePickerEntryMode.input,
      context: context,

      initialTime: TimeOfDay(
        hour: int.parse(_StartTime.split(":")[0]),
        minute: int.parse(_StartTime.split(":")[1].split("")[0]),
        // minute: int.parse(_StartTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _SelectedColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: HeaderText,
        ),
        SizedBox(height: 6),
        Wrap(
          children: List<Widget>.generate(
            4,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _ColorChoosed = index;
                    // print(_ColorChoosed);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? AddTaskColor
                        : index == 1
                            ? PINKColor
                            : index == 2
                                ? grenClrColor
                                : yellowColor,
                    child: _ColorChoosed == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 20,
                          )
                        : SizedBox(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _ElevatedButtons() {
    return Container(
      //margin: EdgeInsets.only(right: 20),
      // width: 100,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => _DataValidator);
        },
        child: Text("Create Task"),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: AddTaskColor,
          textStyle: TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
