// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:my_todo/db/sqldb.dart';
import 'package:my_todo/models/todo_model.dart';

class UserInput extends StatelessWidget {
  SqlDb db = SqlDb();

  final Function insertFunction; // the function that receive additem function

  UserInput({required this.insertFunction, Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              maxLines: 1,
              controller: titleController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                ),
                focusColor: Colors.pink,
                labelText: 'Title',
                floatingLabelStyle: TextStyle(color: Colors.pink),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              maxLines: 3,
              controller: descriptionController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                ),
                focusColor: Colors.pink,
                labelText: 'description',
                floatingLabelStyle: TextStyle(color: Colors.pink),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () async {
                  var myTodo = Todo(
                    title: titleController.text,
                    description: descriptionController.text,
                    createdTime: DateTime.now(),
                    isChecked: false,
                  );

                  insertFunction(myTodo);
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
                color: Colors.black,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
