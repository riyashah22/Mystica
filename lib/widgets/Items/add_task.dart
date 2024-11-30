import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  Function addTask;

  AddTask(this.addTask);
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _taskController = TextEditingController();

  void _submitData() {
    final enteredTask = _taskController.text;

    if (enteredTask.isEmpty) {
      return;
    }

    widget.addTask(enteredTask);

    Navigator.of(context).pop();
    print(_taskController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFFf1faee),
      padding: EdgeInsets.all(32),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 950,
            child: TextField(
              onSubmitted: (_) => _submitData(),
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Task",
              ),
            ),
          ),
          SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 16),
                ),
              ))
        ],
      ),
    );
  }
}
