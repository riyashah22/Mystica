import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/main-screen/login_screen.dart';
import 'package:mytica/screens/submain-screens/album/create_album_screen.dart';
import 'package:mytica/widgets/Items/album_item.dart';
import 'package:mytica/widgets/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumScreen extends StatefulWidget {
  static const String routeName = '/album-screen';
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late AppDb _db;

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
    _db = AppDb();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Album")),
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
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
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
      body: FutureBuilder<List<Album>>(
        future: _db.getAlbumByUserId(userId),
        builder: ((context, snapshot) {
          final List<Album>? albums = snapshot.data;
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

          if (albums != null) {
            _db.close();

            return Container(
                // padding: EdgeInsets.all(16),
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
                      color: Color(0xff001427),
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Quote of the Day",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xffCAF0F8)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
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
                      // color: Colors.red,
                      padding: const EdgeInsets.all(32),
                      width: MediaQuery.of(context).size.width * 0.8773,
                      child: albums.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffADD8FF),
                                    Color(0xffEBF5FF)
                                  ], //final - 1
                                  stops: [0.4, 0.7],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "No memories   :(",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    shadows: [Shadow(color: Colors.black)],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : GridView.builder(
                              itemCount: albums.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 48,
                              ),
                              itemBuilder: (context, index) =>
                                  AlbumItem(albums[index]),
                            ),
                    ),
                  ],
                ));
          }
          return const Center(
            child: Text("0 entires found"),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* showModalBottomSheet(
            context: context,
            builder: (_) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const NewAlbum(),
              );
            },
          ); */
          Navigator.of(context)
              .pushNamed(CreateAlbum.routeName)
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
