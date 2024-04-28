// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:my_todo/db/sqldb.dart';
import 'package:my_todo/models/todo_model.dart';
import 'package:my_todo/widgets/todo_list.dart';
import 'package:my_todo/widgets/user_input.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb db = SqlDb();

  int selectedIndex = 0;

  // Function to add todo
  void additem(Todo todo) async {
    await db.insertData(todo);
    setState(() {});
  }

  // Function to delete todo
  void deleteitem(Todo todo) async {
    await db.deleteData(todo);
    setState(() {});
  }

  void updateItem(Todo todo) async {
    await db.updateData(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 7, 32, 0),
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          TodoList(
              insertFunction: additem,
              deleteFunction: deleteitem,
              updateData: updateItem),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => UserInput(insertFunction: additem),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
