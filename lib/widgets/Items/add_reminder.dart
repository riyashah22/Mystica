import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddReminder extends StatefulWidget {
  Function addReminder;

  AddReminder(this.addReminder);
  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _titleController = TextEditingController();
  DateTime deadline = DateTime.now();

  void _submitData() {
    final enteredReminder = _titleController.text;

    if (enteredReminder.isEmpty) {
      return;
    }

    widget.addReminder(enteredReminder, deadline);

    Navigator.of(context).pop();
    // print(_titleController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XFFf1faee),
      padding: EdgeInsets.all(32),
      height: 275,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 950,
              child: TextField(
                // onSubmitted: (_) => _submitData(),
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 550,
              child: TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    theme: DatePickerTheme(
                        containerHeight: 275,
                        itemHeight: 72,
                        titleHeight: 96,
                        headerColor: Colors.black,
                        doneStyle: TextStyle(color: Colors.white),
                        cancelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.white,
                        itemStyle: TextStyle(fontSize: 24)),
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    // maxTime: DateTime(2019, 6, 7),
                    onChanged: (date) {
                      // print('change $date');
                      deadline = date;
                    },
                    onConfirm: (date) {
                      // print('confirm $date');
                      deadline = date;
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: Text(
                  "Select a Date",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 24,
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
      ),
    );
  }
}
