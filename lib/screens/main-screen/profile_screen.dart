import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mytica/widgets/navigation.dart';
import 'package:file_picker/file_picker.dart';

String? pathImage;
List<String> profile = [];

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile-screen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int userId = 0;
  String username = "";
  String userProfileUrl = "assets/profile.png";
  String fullName = "";

  void getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('userId');
    final uname = prefs.getString('username');
    final fName = prefs.getString('fullName');
    final url = prefs.getString('userProfileUrl');
    if (id != null && uname != null && url != null && fName != null) {
      setState(() {
        userId = id;
        username = uname;
        userProfileUrl = url;
        fullName = fName;
      });
    }
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _profileImage() {
      print(pathImage);
    }

    Map<String, double> dataMap = {
      "Jan-Mar": 5,
      "Apr-Jun": 3,
      "July-Sept": 2,
      "Oct-Dec": 6,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
      ),
      body: Container(
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
        child: Row(
          children: [
            Container(
              color: const Color(0xff001427),
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: const [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Quote of the Day",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xffCAF0F8)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "\" Life is either a daring adventure or nothing at all \"",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Color(0xffedf6f9)),
                    textAlign: TextAlign.center,
                  ),
                  NavigationRow()
                ],
              ),
            ),
            const VerticalDivider(
              width: 4,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              width: MediaQuery.of(context).size.width * 0.8770,
              height: MediaQuery.of(context).size.height,
              // color: Colors.red,
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    child: pathImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(
                              File("$pathImage"),
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage("assets/profile.png"),
                          ),

                    // child: Image.file(
                    //   File("C:/Users/hpCND/Downloads/StudentPhoto.jpg"),
                    //   fit: BoxFit.cover,
                    //   height: 200,
                    // ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  TextButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.image);

                      if (result != null) {
                        PlatformFile file = result.files.first;
                        String editedPath = file.path.toString();
                        editedPath = editedPath.replaceAll('\\', '/').trim();
                        // print(file.path);
                        profile.add(editedPath);
                        print(editedPath);
                        setState(() {
                          pathImage = editedPath;
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Text(
                      "Change Profile Picture",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: _profileImage,
                  //   child: const Text("Save Profile"),
                  // )
                  SizedBox(
                    height: 64,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: 500,
                    height: 250,
                    // color: Colors.red,
                    decoration: const BoxDecoration(
                      // color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffEBF5FF),
                          Color(0xffADD8FF)
                        ], //final - 1
                        stops: [0.4, 0.7],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Full name: ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                fullName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Username: ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                username,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Password: ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "******",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
