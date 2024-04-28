import 'package:flutter/material.dart';
import 'package:my_todo/db/sqldb.dart';

import '../models/todo_model.dart';

class EditTodo extends StatefulWidget {
  final title;
  final description;
  final id;
  final isChecked;
  final Function updateData;

  EditTodo({
    Key? key,
    this.title,
    this.description,
    this.id,
    this.isChecked,
    required this.updateData,
  }) : super(key: key);

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  SqlDb db = SqlDb();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 7, 32, 0),
      appBar: AppBar(
        title: Text('Edit Todo'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Todo',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              controller: titleController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                ),
                focusColor: Colors.pink,
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                floatingLabelStyle: TextStyle(color: Colors.pink, fontSize: 15),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              style: TextStyle(color: Colors.white),
              maxLines: 3,
              controller: descriptionController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pink,
                  ),
                ),
                focusColor: Colors.pink,
                labelText: 'description',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                floatingLabelStyle: TextStyle(color: Colors.pink, fontSize: 20),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  var myTodo = Todo(
                    id: widget.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    createdTime: DateTime.now(),
                    isChecked: widget.isChecked,
                  );

                  widget.updateData(myTodo);
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
                color: Colors.pink,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
