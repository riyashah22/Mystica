import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mytica/screens/submain-screens/album/album_screen.dart';
import 'package:mytica/screens/submain-screens/journal/journal_screen.dart';
import 'package:mytica/screens/submain-screens/notebook/notebook_screen.dart';
import 'package:mytica/screens/submain-screens/reminder/reminder_screen.dart';
import 'package:mytica/screens/submain-screens/todo/todo_screen.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int userId = 0;
  late AppDb _db;

  void buildChart() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = await prefs.getInt('userId');
    if (id != null) {
      // setState(() {
      //   userId = id;
      // });
      // userId = id;
      print("****** userId: $id");
      List<Journal> journals = await _db.getJournalsByUserId(id);
      List<MyImage> myImages = await _db.getImageByUserId(id);
      List<Notebook> notebooks = await _db.getNotebookByUserId(id);
      List<Remainder> remainders = await _db.getRemaindersByUserId(id);

      journals.forEach((element) {
        if (element.createdAt.month == 1) {
          journalsCount[0]++;
        } else if (element.createdAt.month == 2) {
          journalsCount[1]++;
        } else if (element.createdAt.month == 3) {
          journalsCount[2]++;
        } else if (element.createdAt.month == 4) {
          journalsCount[3]++;
        } else if (element.createdAt.month == 5) {
          journalsCount[4]++;
        } else if (element.createdAt.month == 6) {
          journalsCount[5]++;
        } else if (element.createdAt.month == 7) {
          journalsCount[6]++;
        } else if (element.createdAt.month == 8) {
          journalsCount[7]++;
        } else if (element.createdAt.month == 9) {
          journalsCount[8]++;
        } else if (element.createdAt.month == 10) {
          journalsCount[9]++;
        } else if (element.createdAt.month == 11) {
          journalsCount[10]++;
        } else if (element.createdAt.month == 12) {
          journalsCount[11]++;
        }
      });

      remainders.forEach((element) {
        if (element.deadline.month == 1) {
          remaindersCount[0]++;
        } else if (element.deadline.month == 2) {
          remaindersCount[1]++;
        } else if (element.deadline.month == 3) {
          remaindersCount[2]++;
        } else if (element.deadline.month == 4) {
          remaindersCount[3]++;
        } else if (element.deadline.month == 5) {
          remaindersCount[4]++;
        } else if (element.deadline.month == 6) {
          remaindersCount[5]++;
        } else if (element.deadline.month == 7) {
          remaindersCount[6]++;
        } else if (element.deadline.month == 8) {
          remaindersCount[7]++;
        } else if (element.deadline.month == 9) {
          remaindersCount[8]++;
        } else if (element.deadline.month == 10) {
          remaindersCount[9]++;
        } else if (element.deadline.month == 11) {
          remaindersCount[10]++;
        } else if (element.deadline.month == 12) {
          remaindersCount[11]++;
        }
      });

      notebooks.forEach((element) {
        if (element.createdAt.month == 1) {
          notebooksCount[0]++;
        } else if (element.createdAt.month == 2) {
          notebooksCount[1]++;
        } else if (element.createdAt.month == 3) {
          notebooksCount[2]++;
        } else if (element.createdAt.month == 4) {
          notebooksCount[3]++;
        } else if (element.createdAt.month == 5) {
          notebooksCount[4]++;
        } else if (element.createdAt.month == 6) {
          notebooksCount[5]++;
        } else if (element.createdAt.month == 7) {
          notebooksCount[6]++;
        } else if (element.createdAt.month == 8) {
          notebooksCount[7]++;
        } else if (element.createdAt.month == 9) {
          notebooksCount[8]++;
        } else if (element.createdAt.month == 10) {
          notebooksCount[9]++;
        } else if (element.createdAt.month == 11) {
          notebooksCount[10]++;
        } else if (element.createdAt.month == 12) {
          notebooksCount[11]++;
        }
      });

      myImages.forEach((element) {
        if (element.createdAt.month == 1) {
          imagesCount[0]++;
        } else if (element.createdAt.month == 2) {
          imagesCount[1]++;
        } else if (element.createdAt.month == 3) {
          imagesCount[2]++;
        } else if (element.createdAt.month == 4) {
          imagesCount[3]++;
        } else if (element.createdAt.month == 5) {
          imagesCount[4]++;
        } else if (element.createdAt.month == 6) {
          imagesCount[5]++;
        } else if (element.createdAt.month == 7) {
          imagesCount[6]++;
        } else if (element.createdAt.month == 8) {
          imagesCount[7]++;
        } else if (element.createdAt.month == 9) {
          imagesCount[8]++;
        } else if (element.createdAt.month == 10) {
          imagesCount[9]++;
        } else if (element.createdAt.month == 11) {
          imagesCount[10]++;
        } else if (element.createdAt.month == 12) {
          imagesCount[11]++;
        }
      });
      setState(() {
        chartData = <ChartData>[
          ChartData("January", journalsCount[0], notebooksCount[0],
              imagesCount[0], remaindersCount[0]),
          ChartData("February", journalsCount[1], notebooksCount[1],
              imagesCount[1], remaindersCount[1]),
          ChartData("March", journalsCount[2], notebooksCount[2],
              imagesCount[2], remaindersCount[2]),
          ChartData("April", journalsCount[3], notebooksCount[3],
              imagesCount[3], remaindersCount[3]),
          ChartData("May", journalsCount[4], notebooksCount[4], imagesCount[4],
              remaindersCount[4]),
          ChartData("June", journalsCount[5], notebooksCount[5], imagesCount[5],
              remaindersCount[5]),
          ChartData("July", journalsCount[6], notebooksCount[6], imagesCount[6],
              remaindersCount[6]),
          ChartData("August", journalsCount[7], notebooksCount[7],
              imagesCount[7], remaindersCount[7]),
          ChartData("Sept", journalsCount[8], notebooksCount[8], imagesCount[8],
              remaindersCount[8]),
          ChartData("October", journalsCount[9], notebooksCount[9],
              imagesCount[9], remaindersCount[9]),
          ChartData("November", journalsCount[10], notebooksCount[10],
              imagesCount[10], remaindersCount[10]),
          ChartData("December", journalsCount[11], notebooksCount[11],
              imagesCount[11], remaindersCount[11]),
        ];
      });
      _db.close();
    }
  }

  @override
  void initState() {
    buildChart();
    super.initState();
  }

  List<int> journalsCount = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  List<int> notebooksCount = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  List<int> imagesCount = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  List<int> remaindersCount = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  List<ChartData> chartData = <ChartData>[];

  @override
  Widget build(BuildContext context) {
    _db = AppDb();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text("Home screen"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              buildChart();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
                stops: [0.4, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          //Dashboard
          Container(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              color: Color(0xff000814),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                enableAxisAnimation: true,
                margin: const EdgeInsets.all(16),
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(
                    color: Color(0xffc7f9cc),
                    letterSpacing: 0.75,
                  ),
                  majorTickLines: MajorTickLines(width: 0),
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                ),
                crosshairBehavior: CrosshairBehavior(lineWidth: 10),
                palette: const [
                  Color(0xff590d22), //1
                  Color(0xffa4133c), //4
                  Color(0xffff4d6d), //2
                  Color(0xffff8fa3), //5
                  Color(0xffffccd5), //3
                ],
                primaryYAxis: NumericAxis(
                    labelStyle: const TextStyle(
                      color: Color(0xffc7f9cc),
                      letterSpacing: 0.75,
                    ),
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 0)),
                legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                title: ChartTitle(
                    text: "Overview",
                    textStyle: const TextStyle(
                      color: Colors.white,
                    )),
                series: <ChartSeries>[
                  StackedColumn100Series<ChartData, String>(
                      dataSource: chartData,
                      name: "Journal",
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.journals),
                  StackedColumn100Series<ChartData, String>(
                      dataSource: chartData,
                      name: "Notebook",
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.notebook),
                  StackedColumn100Series<ChartData, String>(
                      dataSource: chartData,
                      name: "Images",
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.album),
                  StackedColumn100Series<ChartData, String>(
                      dataSource: chartData,
                      name: "Reminder",
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.reminder),
                ]),
          ),
          SizedBox(
            height: 8,
          ),
          //Navigation
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.24,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(JournalScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 104,
                    width: 148,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesome5.journal_whills,
                          size: 28,
                          color: Color(0xff001427),
                        ),
                        Text(
                          "Journal",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff171214),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(NotebookScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 104,
                    width: 148,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesome5.sticky_note,
                          size: 28,
                          color: Color(0xff001427),
                        ),
                        Text(
                          "Notebook",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff171214),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AlbumScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 104,
                    width: 148,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.photo_album_rounded,
                          size: 28,
                          color: Color(0xff001427),
                        ),
                        Text(
                          "Album",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff171214),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(TodoScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 104,
                    width: 148,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesome5.tasks,
                          size: 28,
                          color: Color(0xff001427),
                        ),
                        Text(
                          "To - Do",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff171214)),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ReminderScreen.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 104,
                    width: 148,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.photo_album_rounded,
                          size: 28,
                          color: Color(0xff001427),
                        ),
                        Text(
                          "Reminder",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff171214),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //section 1

                //section 2
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.year,
    this.journals,
    this.notebook,
    this.album,
    this.reminder,
  );
  final String year;
  final int journals;
  final int notebook;
  final int album;
  final int reminder;
}
