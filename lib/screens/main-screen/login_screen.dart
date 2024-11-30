import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import '../main-screen/home_screen.dart';
import '../main-screen/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AppDb _db;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  Future<bool> checkIfUserExistByUsername(String username) async {
    bool userExists = false;
    // final users = _db.getUsers();
    // users.then((values) => {
    //       values.forEach((value) {
    //         if (value.username == username) {
    //           userExists = true;
    //           print("userExist value After change: $userExists");
    //         }
    //       })
    //     });
    // print("userExist value: $userExists");

    final users = await _db.getUsers();
    users.forEach((user) {
      if (user.username == username) {
        userExists = true;
      }
    });
    return userExists;
  }

  final _usernameSignupEditController = TextEditingController();
  final _passwrodSignupEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Container(
          // color: Colors.red,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/image2.jpg',
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Card(
                  elevation: 14,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xffEBF5FF),
                            Color(0xffADD8FF)
                          ], //final - 1
                          stops: [
                            0.4,
                            0.7
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                    ),
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.center,
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/login_logo.png"))),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                const Text(
                                  "Mystica",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Home of emotions, experiences, observations, thoughts, events and many more insights of          sub-conscious",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: _usernameSignupEditController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Username'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                              controller: _passwrodSignupEditController,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Password'),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 36,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_usernameSignupEditController
                                              .text.isNotEmpty &&
                                          _passwrodSignupEditController
                                              .text.isNotEmpty) {
                                        String username =
                                            _usernameSignupEditController.text
                                                .toLowerCase();
                                        String password =
                                            _passwrodSignupEditController.text;
                                        bool userExists =
                                            await checkIfUserExistByUsername(
                                                username);
                                        if (userExists) {
                                          final user =
                                              await _db.getUser(username);

                                          if (user.username == username &&
                                              user.password == password) {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setInt(
                                                'userId', user.id);
                                            await prefs.setString(
                                                'username', user.username);
                                            await prefs.setString(
                                                'fullName', user.fullname);
                                            await prefs.setString(
                                                'userProfileUrl',
                                                user.userProfileUrl);
                                            // TODO: Implement presistent user login

                                            // print(user);
                                            // print(username + " " + password);
                                            _db.close();
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    HomeScreen.routeName);
                                          } else {
                                            showPasswordIncorrectDialogBox(
                                                context);
                                          }
                                        } else {
                                          // user does not exist
                                          showUserDoesNotExistDialogBox(
                                              context);
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account? ",
                                      style: TextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          _db.close();
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  SignUpScreen.routeName);
                                        },
                                        child: const Text("Sign up"))
                                  ],
                                ),
                                SizedBox(
                                  height: 48,
                                  child: TextButton(
                                    onPressed: () {
                                      /*   Navigator.of(context)
                                          .pushNamed(SignUpScreen.routeName); */
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 36,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Container(
                  /* decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color(0xffEBF5FF),
                      Color(0xffADD8FF)
                    ], //final - 1
                            stops: [
                          0.4,
                          0.7
                        ], begin: Alignment.topRight, end: Alignment.bottomLeft)), */
                  alignment: Alignment.center,
                  color: Colors.black87, //To-Do (Vansh): decrease opacity
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 100,
                        decoration: const BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                            image: AssetImage('assets/icons.png'),
                            // fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        // child: Image.asset(
                        //   "assets/icons.png",
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Start writing, no matter what,",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "The water does not flow until the faucet is turned on",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void showUserDoesNotExistDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Login Failed"),
        content: const Text("User Account Does Not Exist..."),
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

  void showPasswordIncorrectDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Login Failed"),
        content: const Text("Wrong Password. Please try again..."),
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
