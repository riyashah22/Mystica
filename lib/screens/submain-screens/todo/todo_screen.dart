import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/main-screen/login_screen.dart';
import 'package:mytica/widgets/Items/add_task.dart';
import 'package:mytica/widgets/Items/todo_item.dart';
import 'package:mytica/widgets/navigation.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:drift/drift.dart' as drift;
import 'package:shared_preferences/shared_preferences.dart';

class TodoScreen extends StatefulWidget {
  static const String routeName = '/todo-screen';
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late AppDb _db;
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<int> userId;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

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

  Map<String, double> dataMap = {
    "Completed": 5,
    "Not-Completed": 3,
  };

  @override
  Widget build(BuildContext context) {
    _db = AppDb();
    // userId = _prefs.then((SharedPreferences prefs) {
    //   return prefs.getInt('userId') ?? 0;
    // });

    //To-do: Add new task
    void _addNewTask(String task) async {
      _db = AppDb();
      // int id = userId;

      final todoEntity = TodosCompanion(
          title: drift.Value(task),
          isCompleted: drift.Value(0),
          userId: drift.Value(userId));
      print(todoEntity);
      int res = await _db.insertTodo(todoEntity);
      if (res != 0) {
        print("Todo added: $res");
        Navigator.of(context).pushReplacementNamed(TodoScreen.routeName);
      }
      await _db.close();
    }

    void _startAddTaskTransaction(BuildContext ctx) {
      // print("inside _startAddTaskTransaction...");
      showModalBottomSheet(
          context: ctx,
          builder: (_) {
            return GestureDetector(
              onTap: () {},
              child: AddTask(_addNewTask),
              behavior: HitTestBehavior.opaque,
              // behavior is important to catch the action like  onTap
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("To - Do")),
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
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final isUsernameRemoved =
                            await prefs.remove('username');
                        final isUserIdRemoved = await prefs.remove('userId');
                        final isUserProfileUrlRemoved =
                            await prefs.remove('userProfileUrl');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushNamed(LoginScreen.routeName);
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
      body: FutureBuilder<List<Todo>>(
        future: _db.getTodosByUserId(userId),
        builder: ((context, snapshot) {
          final List<Todo>? todos = snapshot.data;
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (todos != null) {
            _db.close();

            double completed = 0, notCompleted = 0;
            todos.forEach((t) {
              if (t.isCompleted == 1) {
                completed = completed + 1;
              } else if (t.isCompleted == 0) {
                notCompleted = notCompleted + 1;
              }
            });

            dataMap = {
              "Completed": completed,
              "Not-Completed": notCompleted,
            };

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xffADD8FF),
                Color(0xffEBF5FF)
              ], //final - 1
                      stops: [
                    0.4,
                    0.7
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Row(
                children: [
                  Container(
                    color: const Color(0xff001427),
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Quote of the Day",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xffCAF0F8)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "\" Life is either a daring adventure or nothing at all \"",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Color(0xffedf6f9)),
                          textAlign: TextAlign.center,
                        ),
                        NavigationRow(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  // margin: EdgeInsets.all(8),

                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0.0, 2.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  // color: Colors.yellow,
                                  height: 72,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: CircleAvatar(
                                          radius: 30,
                                          // backgroundColor: Colors.white,
                                          backgroundImage:
                                              AssetImage(userProfileUrl),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              fullName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: 0.5,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              username,
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    width: 4,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: const EdgeInsets.all(32),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: todos.isEmpty
                        ? Center(
                            child: Text(
                              "No Tasks pending, Hurray 🥳",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: Colors.black)],
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) =>
                                todo_item(todos[index], index),
                            itemCount: todos.length,
                          ),
                  ),
                  const VerticalDivider(
                    width: 4,
                    color: Colors.grey,
                  ),
                  Container(
                    // color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width * 0.1745,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "To-Do Overview:",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
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
                        Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.all(8),
                          width: 250,
                          height: 250,
                          child: PieChart(
                            dataMap: dataMap,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            chartLegendSpacing: 32,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText: "",
                            // colorList: colorList,
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.bottom,
                              showLegends: true,
                              // legendShape: BoxShape.rectangle,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Tasks: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${todos.length}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: Text("0 entires found"),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add Task"),
        icon: const Icon(Icons.add_task_rounded),
        onPressed: () => _startAddTaskTransaction(context),
      ),
    );
  }
}
