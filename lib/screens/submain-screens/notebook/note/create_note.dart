import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  static const routeName = '/create-note-screen';

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  late AppDb _db;

  int userId = 0;

  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('userId');
    if (id != null) {
      userId = id;
    }
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _db = AppDb();
    final notebookId = ModalRoute.of(context)?.settings.arguments as int;
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _tagController = TextEditingController();

    void _addNote() async {
      final title = _nameController.text;
      final body = _descriptionController.text;
      final tag = _tagController.text;

      if (title.isNotEmpty && body.isNotEmpty && tag.isNotEmpty) {
        final noteEntity = NotesCompanion(
            title: drift.Value(title),
            body: drift.Value(body),
            tag: drift.Value(tag),
            createdAt: drift.Value(DateTime.now()),
            notebookId: drift.Value(notebookId),
            userId: drift.Value(userId));

        int res = await _db.insertNote(noteEntity);
        if (res != 0) {
          print("Note Added $res");
          await _db.close();
          Navigator.of(context).pop();
        } else {
          showNotebookNotAddedDialogBox(context);
        }
      } else {
        showFieldCannotBeEmptyDialogBox(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Create Note")),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              // colors: [Color(0xff8EC5FC), Color(0xffE0C3FC)], //final - 1
              colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
              stops: [0.4, 0.7],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              height: 500,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffEBF5FF),
                  Color(0xffADD8FF),
                ], stops: [
                  0.4,
                  0.7
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.24,
                      ),
                    ),
                    controller: _nameController,
                    onSubmitted: (_) => _addNote(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.24,
                      ),
                    ),
                    maxLines: 4,
                    controller: _descriptionController,
                    onSubmitted: (_) => _addNote(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Tag',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.24,
                      ),
                    ),
                    controller: _tagController,
                    onSubmitted: (_) => _addNote(),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: _addNote,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Add Note",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFieldCannotBeEmptyDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Fields Empty!"),
        content: const Text("Fields cannot be empty."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("Okay"),
            ),
          ),
        ],
      ),
    );
  }

  void showNotebookNotAddedDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Failed"),
        content: const Text("Notebook Not Added. Please try again later."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(14),
              child: const Text("Okay"),
            ),
          ),
        ],
      ),
    );
  }
}
