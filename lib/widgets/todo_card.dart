// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/db/sqldb.dart';
import 'package:my_todo/models/todo_model.dart';
import 'package:my_todo/pages/todo_edit_page.dart';

class TodoCard extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final DateTime createdTime;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;
  final Function updatedata;

  TodoCard({
    Key? key,
    required this.id,
    required this.description,
    required this.title,
    required this.createdTime,
    required this.isChecked,
    required this.insertFunction, // it will handle the changes in checkbox
    required this.deleteFunction,
    required this.updatedata, // it will handle the delete button function
  }) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  SqlDb db = SqlDb();

  @override
  Widget build(BuildContext context) {
    var anotherTodo = Todo(
      id: widget.id,
      description: widget.description,
      title: widget.title,
      createdTime: widget.createdTime,
      isChecked: widget.isChecked,
    );
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(widget.id.toString()),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditTodo(
                    id: widget.id,
                    title: widget.title,
                    description: widget.description,
                    isChecked: widget.isChecked,
                    updateData: widget.updatedata,
                  ),
                ),
              ),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              onTap: () {
                widget.deleteFunction(anotherTodo);
              },
              caption: 'delete',
              icon: Icons.delete,
            ),
          ],
          child: Card(
            color: Color.fromARGB(255, 26, 26, 26),
            child: Row(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: widget.isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.isChecked = value!;
                      });
                      anotherTodo.isChecked = value!;

                      widget.insertFunction(anotherTodo);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        if (widget.description != null)
                          Container(
                            margin: EdgeInsets.only(top: 4, left: 20),
                            child: Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        SizedBox(height: 5),
                        Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            DateFormat('dd MM yyyy - hh:mm aaaa')
                                .format(widget.createdTime),
                            style: TextStyle(
                              color: Color.fromARGB(255, 121, 123, 122),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
