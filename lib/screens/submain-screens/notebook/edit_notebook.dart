import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mytica/screens/submain-screens/notebook/notebook_screen.dart';

class EditNotebookScreen extends StatefulWidget {
  static const routeName = 'edit-notebook-screen';

  const EditNotebookScreen({super.key});
  @override
  State<EditNotebookScreen> createState() => _EditNotebookScreenState();
}

class _EditNotebookScreenState extends State<EditNotebookScreen> {
  late AppDb _db;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();

  void _updateNotebook() async {
    final notebook = ModalRoute.of(context)?.settings.arguments as Notebook;
    final name = _nameController.text;
    final description = _descriptionController.text;
    final tag = _tagController.text;

    if (name.isNotEmpty && description.isNotEmpty && tag.isNotEmpty) {
      final notebookEntity = NotebooksCompanion(
          id: drift.Value(notebook.id),
          name: drift.Value(name),
          description: drift.Value(description),
          tag: drift.Value(tag),
          createdAt: drift.Value(notebook.createdAt),
          userId: drift.Value(notebook.userId));

      bool isUpdated = await _db.updateNotebook(notebookEntity);
      if (isUpdated) {
        print("Notebook Edited $isUpdated");
        await _db.close();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(NotebookScreen.routeName);
      } else {
        showNotebookNotUpdatedDialogBox();
      }
    } else {
      showFieldCannotBeEmptyDialogBox();
    }
  }

  void showFieldCannotBeEmptyDialogBox() {
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
            child: const Text("Okay", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void showNotebookNotUpdatedDialogBox() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Failed"),
        content: const Text("Notebook Not Updated. Please try again later."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notebook = ModalRoute.of(context)?.settings.arguments as Notebook;
    print("Notebook - ${notebook}");

    _nameController.text = notebook.name;
    _descriptionController.text = notebook.description;
    _tagController.text = notebook.tag;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Edit Notebook")),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffADD8FF), Color(0xffEBF5FF)],
                stops: [0.4, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.24,
                          ),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _tagController,
                        decoration: const InputDecoration(
                          labelText: 'Tag',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      ElevatedButton(
                        onPressed: _updateNotebook,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            "Edit Notebook",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
