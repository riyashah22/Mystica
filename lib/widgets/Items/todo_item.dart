import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/todo/todo_screen.dart';

class todo_item extends StatefulWidget {
  Todo todoListItem;
  int index;
  todo_item(this.todoListItem, this.index);

  @override
  State<todo_item> createState() => _todo_itemState();
}

class _todo_itemState extends State<todo_item> {
  // late AppDb _db;

  @override
  void initState() {
    super.initState();

    // _db = AppDb();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      height: 116,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 32,
                  child: Text(
                    "${widget.index + 1}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.todoListItem.title,
                        style: widget.todoListItem.isCompleted == 1
                            ? TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough)
                            : TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                      // Text(
                      //   DateFormat.yMMMd()
                      //       .format(widget.todoListItem.createdAt),
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Checkbox(
                      shape: const CircleBorder(),
                      activeColor: const Color(0xff001427),
                      checkColor: Colors.white,
                      splashRadius: 2,
                      value:
                          widget.todoListItem.isCompleted == 0 ? false : true,
                      onChanged: (value) async {
                        // setState(() async {
                        int isCompleted;
                        if (value == true) {
                          isCompleted = 1;
                        } else {
                          isCompleted = 0;
                        }
                        final todoCompanion = TodosCompanion(
                            id: drift.Value(widget.todoListItem.id),
                            title: drift.Value(widget.todoListItem.title),
                            isCompleted: drift.Value(isCompleted),
                            userId: drift.Value(widget.todoListItem.userId));
                        final db = AppDb();
                        bool isUpdated = await db.updateTodo(todoCompanion);
                        print("isUpdated: $isUpdated");
                        await db.close();
                        // Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed(TodoScreen.routeName);
                        // });
                      },
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    IconButton(
                        onPressed: () async {
                          final db = AppDb();
                          await db.deleteTodo(widget.todoListItem.id);
                          await db.close();
                          // Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(TodoScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color(0xffd90429),
                        ))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            height: 2,
          )
        ],
      ),
    );
  }
}
