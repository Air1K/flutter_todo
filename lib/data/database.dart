import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List todoList = [];
  final _myBox = Hive.box('MyBox');

  void createInitialData() {
    todoList = [
      ["Жестко накодить", false],
      ["Покушать", false],
      ["Сделать дз соловьеву", true]
    ];
  }
  void loadData(){
    todoList = _myBox.get("TODOLIST");
  }
  void updateDataBase(){
    _myBox.put("TODOLIST", todoList);
  }
}
