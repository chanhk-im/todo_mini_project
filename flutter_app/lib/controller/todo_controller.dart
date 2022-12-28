import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:todo_mini_project/configuration/settings.dart';

class Todo {
  int id;
  String todo;

  Todo(this.id, this.todo);
}

class TodoController extends GetxController {
  List<Todo> todoList = [];
  var result;

  Future<void> fetchTodo() async {
    final url = Uri.parse("$PROTOCOL://$DOMAIN/todos");
    try {
      result = await http.get(url);
      print(result.body);
    } catch (e) {
      print(e);
    }

    final data = jsonDecode(result.body);

    todoList.clear();
    final _todos = data as List<dynamic>;

    _todos.forEach((e) {
      todoList.add(Todo(
        e['id'],
        e['todo']
      ));
    });
    update();
  }

  Future<void> addPost2(todo) async {
    final url = Uri.parse("$PROTOCOL://$DOMAIN/create-todo");
    final dataStr = jsonEncode({"todo": todo});
    try {
      result = await http.post(url, body: dataStr, headers: {"Content-Type": "application/json"});
    } catch (e) {
      print(e);
    }
    fetchTodo();
    update();
  }

  Future<void> updatePost2(id, todo) async {
    final url = Uri.parse("$PROTOCOL://$DOMAIN/update-todo");
    final dataStr = jsonEncode({
      "id": id,
      "todo": todo
    });

    try {
      result = await http.put(url, body: dataStr, headers: {"Content-Type": "application/json"});
    } catch (e) {
      print(e);
    }
    fetchTodo();
    update();
  }

  Future<void> removePost2(id) async {
    final url = Uri.parse("$PROTOCOL://$DOMAIN/delete-todo/$id");

    try {
      result = await http.delete(url);
    } catch (e) {
      print(e);
    }
    fetchTodo();
    update();
  }

  void addPost(todo) {
    todoList.add(todo);
    print(todo);
    update();
  }

  void removePost(idx) {
    todoList.removeAt(idx);
    update();
  }

  void updatePost(idx, todo) {
    todoList[idx] = todo;
    update();
  }
}