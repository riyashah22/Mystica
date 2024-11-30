import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/notebook/edit_notebook.dart';

import 'package:mytica/screens/submain-screens/notebook/note/note_screen.dart';
import 'package:mytica/screens/submain-screens/notebook/notebook_screen.dart';

class NotebookItem extends StatefulWidget {
  Notebook notebook;
  NotebookItem(this.notebook);

  @override
  State<NotebookItem> createState() => _NotebookItemState();
}

class _NotebookItemState extends State<NotebookItem> {
  //To-Do: Update the note
  void _updateNotebook() {
    Navigator.of(context)
        .pushNamed(EditNotebookScreen.routeName, arguments: widget.notebook);
    print("Update the notes...");
  }

  //To-Do: delele the note
  void _deleteNotebook() async {
    final db = AppDb();
    await db.deleteNotebook(widget.notebook.id);
    await db.close().whenComplete(() =>
        {Navigator.of(context).pushReplacementNamed(NotebookScreen.routeName)});
  }

  @override
  Widget build(BuildContext context) {
    int? selectedOption;

    Color colorIndex() {
      const colors = [
        Color(0xfff4a261), //11
        Color(0xff52b788), //10
        Color(0xffe63946), //9
        Color(0xfffff475), //6
        Color(0xff70e000), //8
        Color(0xffd7affa), //5
        Color(0xff5d5d81), //7
        Color(0xfffabd04), //4
        Color(0xff457b9d), //3
        Color(0xfffe6d73), //2
        Color.fromARGB(232, 235, 236, 1), //1
      ];
      if (widget.notebook.id >= 9) {
        var n = widget.notebook.id % 10;
        return colors[n];
      }
      return colors[widget.notebook.id];
    }

    final color = colorIndex();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          NoteScreen.routeName,
          arguments: [widget.notebook.id, color],
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorIndex(),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.notebook.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PopupMenuButton<int>(
                  elevation: 7,
                  // icon: Icon(Icons.menu_rounded),
                  initialValue: selectedOption,
                  onSelected: (newSelectedOption) {
                    setState(() {
                      selectedOption = newSelectedOption;
                      switch (selectedOption) {
                        case 0:
                          _updateNotebook();
                          break;
                        case 1:
                          _deleteNotebook();
                          break;
                      }
                    });
                  },
                  itemBuilder: (context) => <PopupMenuEntry<int>>[
                    PopupMenuItem(
                      value: 0,
                      child: Text("Edit"),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text("Delete"),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              height: 4,
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 3,
              child: Text(
                widget.notebook.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.notebook.tag,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("10"), //To-Do: (Number of notes)
                      Text(
                        DateFormat.yMMMd().format(
                          widget.notebook.createdAt,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
