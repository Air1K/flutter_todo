import 'package:first_project/data/database.dart';
import 'package:first_project/util/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("myBox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  void _onSave() {
    setState(() {
      db.todoList.add([_controller.text, false]);
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: _onSave,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange[200],
      appBar: AppBar(
        title: const Text(
          'TO DO',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        // backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      body: db.todoList.isNotEmpty
          ? ListView.builder(
              itemCount: db.todoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                    taskName: db.todoList[index][0],
                    taskCompleted: db.todoList[index][1],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index));
              },
            )
          : Padding(
              // width: 1000,
              // margin: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
              padding: const EdgeInsets.only(
                  top: 25.0, left: 25, right: 25, bottom: 25,
              ),

              // decoration: BoxDecoration(
              //   color: Colors.grey[300],
              //   borderRadius: BorderRadius.circular(12),
              // ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[300], borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Список пуст"),
                  ],
                ),
              ),
            ),
    );
  }
}

//Container(
//           margin: const EdgeInsets.only(left: 13, right: 13, top: 13),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                 child: SizedBox(
//                   height: 50,
//                   child: TextField(
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.send,
//                     autofocus: true,
//                     decoration: InputDecoration(
//                       labelText: "Задача",
//                       prefixIcon: const Icon(Icons.add),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 6.5),
//                 child: SizedBox(
//                   height: 50,
//                   width: 100,
//                   child: TextButton(
//                     style: ButtonStyle(
//                       foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.black),
//                       // backgroundColor:
//                       //     MaterialStateProperty.all<Color>(Colors.black),
//                       overlayColor:
//                       MaterialStateProperty.all<Color>(Colors.black38),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16.0),
//                               side: const BorderSide(color: Colors.black38))),
//                       textStyle: MaterialStateProperty.all<TextStyle>(
//                           const TextStyle(fontSize: 16)),
//                     ),
//                     onPressed: () {},
//                     child: const Text('Добавить'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
