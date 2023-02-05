import 'package:flutter_to_do_app/Database/db_hellper.dart';
import 'package:flutter_to_do_app/models/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTaskList();
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? tasks}) async {
    //print(tasks);
    return await DBHellper.insert(tasks);
  }

  void getTaskList() async {
    List<Map<String, dynamic>> tasks = await DBHellper.query();
    taskList.assignAll(
      tasks.map((data) => new TaskModel.fromJson(data)).toList(),
    );
  }

  void TaskCompleted(int? id) async {
    await DBHellper.Update(id!);
    getTaskList();
  }

  void Delete(TaskModel task) {
    DBHellper.Delete(task);
    getTaskList();
  }
}
