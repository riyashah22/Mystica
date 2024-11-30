import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytica/data/local/db/app_db.dart';

class DetailNoteScreen extends StatefulWidget {
  const DetailNoteScreen({super.key});

  static const routeName = '/edit-note-screen';

  @override
  State<DetailNoteScreen> createState() => _DetailNoteScreenState();
}

class _DetailNoteScreenState extends State<DetailNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as List<Object>;
    final note = arguments[0] as Note;
    final color = arguments[1] as Color;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Detail Note")),
          actions: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Row(
                    children: [
                      TextButton(
                        child: const Text(
                          "Log out",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print("Log out ");
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(Icons.logout_rounded),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                )),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffcaf0f8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.84,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    // color: Color(0xffcaf0f8),
                    color: color,

                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(16),
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                            fontSize: 40,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'PatrickHand',
                            fontFamily: 'NotoSerifGeorgian',
                            color: Color(0xff001524)),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Expanded(
                        flex: 26,
                        child: SingleChildScrollView(
                          child: Text(
                            note.body,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 22,
                              letterSpacing: 1,
                              // fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        height: 2,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  note.tag,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(note.createdAt),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      DateFormat.Hms().format(note.createdAt),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
