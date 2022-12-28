import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_mini_project/controller/todo_controller.dart';

class DetailScreen extends StatelessWidget {
  late TodoController todoController = Get.find();

  final Todo todo;

  DetailScreen(this.todo, {Key? key}) : super(key: key);
  TextEditingController updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var updateTodo;
    for (var e in todoController.todoList) {
      if (e.id == todo.id) {
        updateTodo = e;
        break;
      }
    }
    updateController.text = updateTodo.todo;

    return Scaffold(
        appBar: AppBar(
          title: Text(updateTodo.todo),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: updateController,
                decoration: const InputDecoration(
                  hintText: 'update',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      todoController.updatePost2(todo.id, updateController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('수정'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}