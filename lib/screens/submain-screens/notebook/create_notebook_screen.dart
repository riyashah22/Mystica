import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;

class CreateNotebookScreen extends StatefulWidget {
  static const routeName = '/create-notebook-screen';
  const CreateNotebookScreen({super.key});

  @override
  State<CreateNotebookScreen> createState() => _CreateNotebookScreenState();
}

class _CreateNotebookScreenState extends State<CreateNotebookScreen> {
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
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _tagController = TextEditingController();

    void _addNotebook() async {
      final name = _nameController.text;
      final description = _descriptionController.text;
      final tag = _tagController.text;

      if (name.isNotEmpty && description.isNotEmpty && tag.startsWith("#", 0)) {
        final notebookEntity = NotebooksCompanion(
            name: drift.Value(name),
            description: drift.Value(description),
            tag: drift.Value(tag),
            createdAt: drift.Value(DateTime.now()),
            userId: drift.Value(userId));

        int res = await _db.insertNotebook(notebookEntity);
        if (res != 0) {
          print("Notebook Added $res");
          await _db.close();
          Navigator.of(context).pop();
        } else {
          showNotebookNotAddedDialogBox(context);
        }
      } else {
        if (name.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Enter Notebook Name",
            ),
            duration: Duration(seconds: 4),
          ));
          return;
          // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
        }

        if (description.length < 10) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Minimum 10 characters of description",
            ),
            duration: Duration(seconds: 4),
          ));
          return;
          // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
        }
        print("vansh =" + tag.startsWith("#", 0).toString());
        if (!tag.startsWith("#", 0)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Tag must start with #",
            ),
            duration: Duration(seconds: 4),
          ));
          return;
          // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Create Notebook")),
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
                ], //final - 1
                    stops: [
                      0.4,
                      0.7
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                // color: Colors.black45,
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
                children: [
                  SizedBox(
                    width: 550,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.24,
                        ),
                      ),
                      controller: _nameController,
                      onSubmitted: (_) => _addNotebook(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 550,
                    child: TextField(
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
                      onSubmitted: (_) => _addNotebook(),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 550,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Tag',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.24,
                        ),
                      ),
                      controller: _tagController,
                      onSubmitted: (_) => _addNotebook(),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: _addNotebook,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Add Notebook",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Okay"),
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Okay"),
          ),
        ],
      ),
    );
  }
}
