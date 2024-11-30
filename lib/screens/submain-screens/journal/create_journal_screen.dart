import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:shared_preferences/shared_preferences.dart';

class CreateJournalScreen extends StatefulWidget {
  static const routeName = "/create-journal-screen";
  const CreateJournalScreen({super.key});

  @override
  State<CreateJournalScreen> createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
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
    final _journalTitleController = TextEditingController();
    final _journalDescriptionController = TextEditingController();
    final _journalTagController = TextEditingController();

    void _addJournal() async {
      final enteredJournalTitle = _journalTitleController.text;
      final enteredJournalDescription = _journalDescriptionController.text;
      final enteredJournalTag = _journalTagController.text;

      if (enteredJournalTitle.isEmpty &&
          enteredJournalDescription.isEmpty &&
          enteredJournalTag.isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Warning"),
            content: Row(
              children: [
                Icon(Icons.warning_rounded),
                SizedBox(
                  width: 8,
                ),
                Text("Enter details")
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
        return;
        // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
      }

      if (enteredJournalTitle.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Enter Title",
          ),
          duration: Duration(seconds: 4),
        ));
        return;
        // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
      }

      if (enteredJournalDescription.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Minimum 10 characters of description",
          ),
          duration: Duration(seconds: 4),
        ));
        return;
        // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
      }
      print("tag (vansh) - " + enteredJournalTag.startsWith("#", 0).toString());
      if (!enteredJournalTag.startsWith("#", 0)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Tag must start with #",
          ),
          duration: Duration(seconds: 4),
        ));
        return;
        // Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
      }

      final journalEntity = JournalsCompanion(
          title: drift.Value(enteredJournalTitle),
          body: drift.Value(enteredJournalDescription),
          tag: drift.Value(enteredJournalTag),
          userId: drift.Value(userId),
          createdAt: drift.Value(DateTime.now()));

      int res = await _db.insertJournal(journalEntity);
      if (res != 0) {
        print("Journal Added $res");
        _db.close();
        Navigator.of(context).pop();
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
                child: const Text("Okay"),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Create Journal")),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 550,
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.24,
                          ),
                        ),
                        controller: _journalTitleController,
                        onSubmitted: (_) => _addJournal(),
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
                        controller: _journalDescriptionController,
                        onSubmitted: (_) => _addJournal(),
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
                        controller: _journalTagController,
                        onSubmitted: (_) => _addJournal(),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: _addJournal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "Add Journal",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
