import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/journal/detail_journal_screen.dart';
import 'package:mytica/screens/submain-screens/journal/edit_journal_screen.dart';

class JournalItem extends StatefulWidget {
  Journal journal;
  JournalItem(this.journal);

  @override
  State<JournalItem> createState() => _JournalItemState();
}

class _JournalItemState extends State<JournalItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.journal);
    //To-do (Vansh): Change the colors
    Color colorIndex() {
      const colors = [
        Color.fromARGB(232, 235, 236, 1),
        Color(0xfffe6d73),
        Color(0xff457b9d),
        Color(0xfffabd04),
        Color(0xffd7affa),
        Color(0xfffff475),
        Color(0xff5d5d81),
        Color(0xff70e000),
        Color(0xffe63946),
        Color(0xff52b788),
        Color(0xfff4a261),
      ];
      if (widget.journal.id >= 9) {
        var n = widget.journal.id % 10;
        return colors[n];
      }
      return colors[widget.journal.id];
    }

    final color = colorIndex();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailJournalScreen.routeName, arguments: [widget.journal, color]);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          margin: const EdgeInsets.all(6.0),
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
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    widget.journal.title,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: 48,
                decoration: const BoxDecoration(
                  // color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.journal.tag,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(widget.journal.createdAt),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          EditJournalScreen.routeName,
                          arguments: [widget.journal, color],
                        );
                      },
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
