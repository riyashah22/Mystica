import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/album/album_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;

String? pathImage;

class CreateAlbum extends StatefulWidget {
  static const routeName = "/create-album";
  const CreateAlbum({super.key});

  @override
  State<CreateAlbum> createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {
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

  final _albumTitleController = TextEditingController();
  final _albumDescriptionController = TextEditingController();

  void _addAlbumData() async {
    final enteredAlbumTitle = _albumTitleController.text;
    final enteredAlbumDescription = _albumDescriptionController.text;

    //To-DO: Maximum characters for description - 24
    if (enteredAlbumTitle.isEmpty ||
        enteredAlbumDescription.length < 10 ||
        pathImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Minimum 10 characters of description",
        ),
        duration: Duration(seconds: 4),
      ));
      //Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
    } else {
      final albumEntity = AlbumsCompanion(
          name: drift.Value(enteredAlbumTitle),
          description: drift.Value(enteredAlbumDescription),
          imageurl: drift.Value(pathImage!),
          createdAt: drift.Value(DateTime.now()),
          userId: drift.Value(userId));

      int res = await _db.insertAlbum(albumEntity);
      if (res != 0) {
        print("Album Added $res");
        await _db.close();
        Navigator.of(context).pop();
      } else {
        showAlbumNotAddedDialogBox(context);
      }
    }

    // //To-do: add album
    // print(enteredAlbumTitle);
    // print(enteredAlbumDescription);
    // print(pathImage);

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _db = AppDb();
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Create an album")),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
                  stops: [0.4, 0.7],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          // color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 500,
                  height: 500,
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xffEBF5FF),
                          Color(0xffADD8FF),
                        ], //final - 1
                        stops: [
                          0.4,
                          0.7
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
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
                  child: Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Album Name',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.24,
                          ),
                        ),
                        controller: _albumTitleController,
                        onSubmitted: (_) => _addAlbumData(),
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
                        controller: _albumDescriptionController,
                        onSubmitted: (_) => _addAlbumData(),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;
                              String editedPath = file.path.toString();
                              editedPath =
                                  editedPath.replaceAll('\\', '/').trim();
                              pathImage = editedPath;
                              // print(file.path);
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Text(
                            "Pick a cover image",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      const SizedBox(
                        height: 55,
                      ),
                      ElevatedButton(
                        onPressed: _addAlbumData,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            "Create Album",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ))),
            ],
          ),
        ));
  }

  void showAlbumNotAddedDialogBox(BuildContext context) {
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
