import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class NewImage extends StatefulWidget {
  const NewImage({super.key});

  @override
  State<NewImage> createState() => _NewImageState();
}

class _NewImageState extends State<NewImage> {
  final _tagController = TextEditingController();
  String pathImage = '';
  void _addImage() {
    final enteredTag = _tagController.text;

    print(enteredTag);
    print(pathImage);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 7,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,  
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Tag'),
                    controller: _tagController,
                    onSubmitted: (_) => _addImage(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          PlatformFile file = result.files.first;
                          String editedPath = file.path.toString();
                          editedPath = editedPath.replaceAll('\\', '/').trim();
                          pathImage = editedPath;
                          // print(file.path);
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Text("Pick an image")),
                  const SizedBox(
                    height: 55,
                  ),
                  ElevatedButton(
                      onPressed: _addImage, child: const Text("Add Image"))
                ],
              ))),
    );
  }
}
