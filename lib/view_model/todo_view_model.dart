import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_vayuz/model/todo_model.dart';
import '../hive/hive_localdb.dart';

class TodoViewModel extends ChangeNotifier {
  TextEditingController textTitleController = TextEditingController();
  TextEditingController textDesController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  HiveLocalDB hiveLocalDB = HiveLocalDB();
  List<TodoModel>? todoList = [];
  List<TodoModel>? allTodoList = [];

  updateSelectDated(DateTime picked) {
    selectedDate = picked;
    notifyListeners();
  }

  addItemOnDB() async {
    int tId = 1;
    todoList!.clear();
    List list = await hiveLocalDB.read(HiveLocalDB.todoList) ?? [];
    if (list.isNotEmpty) {
      todoList = (list).map((e) => TodoModel.fromJson(e)).toList();
      tId = (todoList!.last.tId!) + 1;
    }
    TodoModel todoModel = TodoModel(
        tId: tId,
        title: textTitleController.text.trim(),
        description: textDesController.text,
        date: DateFormat('dd-MMM-yyyy').format(selectedDate));
    todoList!.add(todoModel);
    hiveLocalDB.save(HiveLocalDB.todoList, todoList);
    textTitleController.clear();
    textDesController.clear();
    selectedDate = DateTime.now();
    notifyListeners();
  }

  getAllTodoItem(String isFrom) async {
    List list = await hiveLocalDB.read(HiveLocalDB.todoList) ?? [];
    if (list.isNotEmpty) {
      todoList = (list).map((e) => TodoModel.fromJson(e)).toList();
      if (isFrom == "Today") {
        todoList = todoList!
            .where((element) =>
                element.date ==
                DateFormat('dd-MMM-yyyy').format(DateTime.now()))
            .toList();
      } else if (isFrom == "Tomorrow") {
        todoList = todoList!
            .where((element) =>
                element.date ==
                DateFormat('dd-MMM-yyyy')
                    .format(DateTime.now().add(const Duration(days: 1))))
            .toList();
      } else {
        todoList = todoList!
            .where((element) =>
                element.date !=
                    DateFormat('dd-MMM-yyyy').format(DateTime.now()) &&
                element.date !=
                    DateFormat('dd-MMM-yyyy')
                        .format(DateTime.now().add(const Duration(days: 1))))
            .toList();
      }
    }
    notifyListeners();
  }

  deleteTodoItem(TodoModel todoModel) async {
    List list = await hiveLocalDB.read(HiveLocalDB.todoList) ?? [];
    if (list.isNotEmpty) {
      allTodoList = (list).map((e) => TodoModel.fromJson(e)).toList();
    }
    allTodoList!.removeWhere((element) => element.tId == todoModel.tId);
    todoList!.remove(todoModel);
    hiveLocalDB.save(HiveLocalDB.todoList, allTodoList);
    notifyListeners();
  }

  updateTodoItem(TodoModel todoModel, String isFrom) async {
    List list = await hiveLocalDB.read(HiveLocalDB.todoList) ?? [];
    todoList = (list).map((e) => TodoModel.fromJson(e)).toList();
    if (isFrom == "Today") {
      todoList = todoList!
          .where((element) =>
              element.date == DateFormat('dd-MMM-yyyy').format(DateTime.now()))
          .toList();
    }
    else if (isFrom == "Tomorrow") {
      todoList = todoList!
          .where((element) =>
              element.date ==
              DateFormat('dd-MMM-yyyy')
                  .format(DateTime.now().add(const Duration(days: 1))))
          .toList();
    }
    else {
      todoList = todoList!
          .where((element) =>
              element.date !=
                  DateFormat('dd-MMM-yyyy').format(DateTime.now()) &&
              element.date !=
                  DateFormat('dd-MMM-yyyy')
                      .format(DateTime.now().add(const Duration(days: 1))))
          .toList();
    }
    todoModel.title = textTitleController.text;
    todoModel.description = textDesController.text;
    todoList![todoList!.indexWhere((element) => element.tId == todoModel.tId)] =
        todoModel;
    hiveLocalDB.save(HiveLocalDB.todoList, todoList);
    textTitleController.clear();
    textDesController.clear();
    notifyListeners();
  }
}
