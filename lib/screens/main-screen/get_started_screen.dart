import 'package:flutter/material.dart';
import './login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(child: Text("Welcome to your Mystica World"))),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                // colors: [Color(0xff8EC5FC), Color(0xffE0C3FC)], //final - 1
                colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
                stops: [0.4, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  //color: Colors.red,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  // ignore: prefer_const_constructors
                  child: CircleAvatar(
                    radius: 300,
                    backgroundColor: Colors.transparent,
                    child: const Image(
                      image: AssetImage('assets/logo_resized_1.png'),
                      height: 300,
                      width: 300,
                    ),
                    //child: Image(image: AssetImage('assets/logo_resized.png')),
                  )),
              Container(
                  //color: Colors.yellow,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 24),
                      ))),
            ],
          ),
        ));
  }
}
