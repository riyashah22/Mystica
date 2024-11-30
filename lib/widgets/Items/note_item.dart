import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/notebook/note/edit_note_screen.dart';
import 'package:mytica/screens/submain-screens/notebook/note/detail_note_screen.dart';
import 'package:mytica/screens/submain-screens/notebook/note/note_screen.dart';

class NoteItem extends StatefulWidget {
  Note note;
  Color color;
  NoteItem(this.note, this.color);

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  //To-Do: delele the note
  void _deleteNote() async {
    final db = AppDb();
    await db.deleteNote(widget.note.id);
    await db.close().whenComplete(() => {
          Navigator.of(context).pushReplacementNamed(
            NoteScreen.routeName,
            arguments: [widget.note.notebookId, widget.color],
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.note);
    int? selectedOption;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailNoteScreen.routeName,
            arguments: [widget.note, widget.color]);
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.color,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.note.title,
                      style: const TextStyle(
                          fontSize: 24,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'PatrickHand',
                          fontFamily: 'NotoSerifGeorgian',
                          color: Color(0xff001524)),
                    ),
                  ),
                ),
                PopupMenuButton<int>(
                  elevation: 7,
                  icon: Icon(Icons.menu_rounded),
                  initialValue: selectedOption,
                  onSelected: (newSelectedOption) {
                    setState(() {
                      selectedOption = newSelectedOption;
                      switch (selectedOption) {
                        case 0:
                          Navigator.of(context).pushNamed(
                              Edit_NoteScreen.routeName,
                              arguments: widget.note);
                          break;
                        case 1:
                          _deleteNote();
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
                widget.note.body,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  // fontFamily: 'NotoSerifGeorgian',
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
                        widget.note.tag,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(
                          widget.note.createdAt,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
