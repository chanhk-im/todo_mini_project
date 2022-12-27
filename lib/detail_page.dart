import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int idx;
  final String todo;

  DetailScreen(this.idx, this.todo, {Key? key}) : super(key: key);
  TextEditingController updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    updateController.text = todo;

    return Scaffold(
        appBar: AppBar(
          title: Text(todo),
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
                      Navigator.pop(context, updateController.text);
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