import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/album/album_screen.dart';
import 'package:drift/drift.dart' as drift;
import 'package:mytica/screens/submain-screens/album/image/image_screen.dart';

class EditAlbumScreen extends StatefulWidget {
  static const routeName = "/edit-album-screen";

  @override
  State<EditAlbumScreen> createState() => _EditAlbumScreenState();
}

class _EditAlbumScreenState extends State<EditAlbumScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late AppDb _db;
  @override
  Widget build(BuildContext context) {
    //Retriving albumId from Album Item (edit button)
    _db = AppDb();
    final album = ModalRoute.of(context)?.settings.arguments as Album;
    _titleController.text = album.name;
    _descriptionController.text = album.description;
    //TO-DO: update the album
    void _updateAlbum() async {
      final enteredAlbumName = _titleController.text;
      final enteredDescription = _descriptionController.text;
      // final notebook = ModalRoute.of(context)?.settings.arguments as Notebook;
      // final notebook = args as Notebook;

      if (enteredAlbumName.isNotEmpty && enteredDescription.isNotEmpty) {
        final albumEntity = AlbumsCompanion(
            id: drift.Value(album.id),
            name: drift.Value(enteredAlbumName),
            description: drift.Value(enteredDescription),
            imageurl: drift.Value(album.imageurl),
            createdAt: drift.Value(album.createdAt),
            userId: drift.Value(album.userId));

        bool isUpdated = await _db.updateAlbum(albumEntity);
        if (isUpdated) {
          print("Album Updated $isUpdated");
          final updatedAlbum = await _db.getAlbum(album.id);
          await _db.close();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
          Navigator.of(context)
              .pushNamed(ImageScreen.routeName, arguments: updatedAlbum);
        } else {
          showAlbumNotUpdatedDialogBox();
        }
      } else {
        showFieldCannotBeEmptyDialogBox();
      }
    }

    void _deleteAlbum() async {
      final _db = AppDb();
      await _db.deleteAlbum(album.id);
      await _db.close().whenComplete(() {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(AlbumScreen.routeName);
      });
    }

    print("Alubm - $album");
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Edit Album"),
        ),
        actions: [
          IconButton(
              onPressed: _deleteAlbum,
              icon: Icon(
                Icons.delete_forever_rounded,
              ))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
                stops: [0.4, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                height: 500,
                width: 500,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    image: FileImage(File(album.imageurl)),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    colorBlendMode: BlendMode.clear,
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                // color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        // height: MediaQuery.of(context).size.height * 0.4,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                  labelText: 'Album name'),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                            ElevatedButton(
                                onPressed: _updateAlbum,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    "Update Album",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void showAlbumNotUpdatedDialogBox() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Failed"),
        content: const Text("Album Not Updated. Please try again later."),
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

  void showFieldCannotBeEmptyDialogBox() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Empty Fields"),
        content: const Text("Fields cannot be empty. Please try again later."),
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
