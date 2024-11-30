import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mytica/screens/submain-screens/journal/journal_screen.dart';

class EditJournalScreen extends StatefulWidget {
  static const routeName = "/edit-journal-screen";
  const EditJournalScreen({super.key});

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  final _journalTitleController = TextEditingController();
  final _journalDescriptionController = TextEditingController();
  final _journalTagController = TextEditingController();

  late AppDb _db;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<Object>;
    final journal = args[0] as Journal;
    final colorValue = args[1] as Color;
    print("Journal value");
    print(journal);
    _journalTitleController.text = journal.title;
    _journalDescriptionController.text = journal.body;
    _journalTagController.text = journal.tag;

    //To-Do: Retrieve journal data
    print("Journal id (edit screen)- ${journal.id}");

    //To-Do: Update journal data
    void _updateData() async {
      final journalEntity = JournalsCompanion(
          id: drift.Value(journal.id),
          title: drift.Value(_journalTitleController.text),
          body: drift.Value(_journalDescriptionController.text),
          tag: drift.Value(_journalTagController.text),
          userId: drift.Value(journal.userId),
          createdAt: drift.Value(journal.createdAt));

      bool isUpdated = await _db.updateJournal(journalEntity);
      if (isUpdated) {
        print("Journal Added $isUpdated");
        _db.close();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(JournalScreen.routeName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Failed"),
            content: const Text("Journal Not Added. Please try again later."),
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

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Edit Journal")),
        actions: [
          GestureDetector(
            onTap: () {
              _db.deleteJournal(journal.id);
              _db.close();
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(JournalScreen.routeName);
            },
            child: const Icon(
              Icons.delete,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: colorValue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              height: 500,
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
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
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _journalTitleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _journalDescriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 8,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _journalTagController,
                      decoration: const InputDecoration(
                        labelText: "Tag",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    /* IconButton(
                      onPressed: _updateData,
                      icon: const Icon(Icons.save),
                    ) */

                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                          onPressed: _updateData,
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
