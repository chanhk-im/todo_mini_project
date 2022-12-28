import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:todo_mini_project/pages/detail_page.dart';
import 'package:todo_mini_project/controller/todo_controller.dart';

class TodoListState extends State<TodoList> {
  late TodoController todoController = Get.put(TodoController());

  bool deleteMode = false;

  Widget todoListTile(BuildContext context) {
    return GetBuilder<TodoController>(
      builder: (_) {
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: todoController.todoList.length * 2,
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            final idx = i ~/ 2;
            if (deleteMode) {
              return ListTile(
                title: Text(todoController.todoList[idx].todo),
                onTap: () {
                  showDialog(       // show alert to delete
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("삭제하시겠습니까?"),
                          actions: [
                            TextButton(
                              child: Text("예"),
                              onPressed: () {
                                todoController.removePost2(todoController.todoList[idx].id);
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text("아니오"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      }
                  );
                },
                trailing: const Icon(Icons.cancel_outlined),
              );
            }
            else {
              return ListTile(
                  title: Text(todoController.todoList[idx].todo),
                  onTap: () => Navigator.push(        // navigate to detail screen
                      context, MaterialPageRoute(builder: (context) => DetailScreen(todoController.todoList[idx]))
                  )
              );
            }
          },
        );
      },
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                deleteMode = !deleteMode;
              });
            },
            icon: deleteMode ? const Icon(Icons.backspace) : const Icon(Icons.delete),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: todoController.fetchTodo,
        child: Center(
          child: todoListTile(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New TODO',
        child: const Icon(Icons.add),
        onPressed: () => todoController.addPost2('새 항목'),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}