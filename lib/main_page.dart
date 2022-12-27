import 'package:flutter/material.dart';
import 'package:todo_mini_project/detail_page.dart';

class TodoListState extends State<TodoList> {
  final _todoList = <String>[];
  bool deleteMode = false;

  Widget todoListTile(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _todoList.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final idx = i ~/ 2;
        if (deleteMode) {
          return ListTile(
            title: Text(_todoList[idx]),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("삭제하시겠습니까?"),
                      actions: [
                        TextButton(
                          child: Text("예"),
                          onPressed: () {
                            setState(() {
                              _todoList.removeAt(idx);
                            });
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
        return ListTile(
          title: Text(_todoList[idx]),
          onTap: () async {

            final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen(idx, _todoList[idx]) )
            );
            if (result != null) {
              setState(() {
                _todoList[idx] = result;
              });
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
      body: Center(
        child: todoListTile(context),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New TODO',
        child: const Icon(Icons.add),
        onPressed: () => {
          setState(() {
            _todoList.add("새 항목");
          })
        },
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}