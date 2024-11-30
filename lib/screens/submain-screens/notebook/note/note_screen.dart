import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/notebook/note/create_note.dart';
import 'package:mytica/widgets/Items/note_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteScreen extends StatefulWidget {
  static const routeName = '/note-screen';
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late AppDb _db;

  @override
  Widget build(BuildContext context) {
    _db = AppDb();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as List<Object>;
    final notebookId = arguments[0] as int;
    final color = arguments[1] as Color;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Notes")),
      ),
      body: FutureBuilder<List<Note>>(
        future: _db.getNoteByNotebookId(notebookId),
        builder: ((context, snapshot) {
          final List<Note>? notes = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (notes != null && notes.isEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
                  stops: [0.4, 0.7],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  "\"The only difference between success and failure is the ability to take action.\"",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (notes != null) {
            _db.close();
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
                    stops: [0.4, 0.7],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      itemCount: notes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 6 / 6,
                              crossAxisSpacing: 45,
                              mainAxisSpacing: 35),
                      itemBuilder: (context, index) =>
                          NoteItem(notes[index], color),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text("0 entires found"),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _db.close();
          Navigator.of(context)
              .pushNamed(CreateNoteScreen.routeName, arguments: notebookId)
              .then((value) => setState(() {}));
          ;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
