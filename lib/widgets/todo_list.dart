// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:my_todo/db/sqldb.dart';
import 'package:my_todo/widgets/todo_card.dart';

class TodoList extends StatelessWidget {
  SqlDb db = SqlDb();

  final Function insertFunction;
  final Function deleteFunction;
  final Function updateData;

  TodoList(
      {Key? key,
      required this.insertFunction,
      required this.deleteFunction,
      required this.updateData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getData(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var datalenght = data!.length;

          return datalenght == 0
              ? const Center(
                  child: Text(
                    'You don\'t have any Todos yet',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: datalenght,
                  itemBuilder: (context, i) => TodoCard(
                    id: data[i].id,
                    description: data[i].description,
                    title: data[i].title,
                    createdTime: data[i].createdTime,
                    isChecked: data[i].isChecked,
                    insertFunction: insertFunction,
                    deleteFunction: deleteFunction,
                    updatedata: updateData,
                  ),
                );
        },
      ),
    );
  }
}
