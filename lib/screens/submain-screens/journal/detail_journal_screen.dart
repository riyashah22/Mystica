import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:intl/intl.dart';

class DetailJournalScreen extends StatefulWidget {
  static const routeName = "/detail-journal-screen";
  const DetailJournalScreen({super.key});

  @override
  State<DetailJournalScreen> createState() => _DetailJournalScreenState();
}

class _DetailJournalScreenState extends State<DetailJournalScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<Object>;
    final journal = args[0] as Journal;
    final journalColor = args[1] as Color;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Detail Journal")),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: journalColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    //color: Color(0xffdee2e6),
                    color: Color(0xffcaf0f8),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 0.5,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(16),
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.84,
                  child: Column(
                    children: [
                      Text(
                        journal.title,
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
                            journal.body,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 24,
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
                        color: Colors.transparent,
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
                                  journal.tag,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(journal.createdAt),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      DateFormat.Hms()
                                          .format(journal.createdAt),
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
