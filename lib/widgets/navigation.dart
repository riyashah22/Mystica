import 'package:flutter/material.dart';
import 'package:mytica/screens/main-screen/home_screen.dart';
import 'package:mytica/screens/main-screen/profile_screen.dart';
import 'package:mytica/screens/submain-screens/album/album_screen.dart';
import 'package:mytica/screens/submain-screens/journal/journal_screen.dart';
import 'package:mytica/screens/submain-screens/notebook/notebook_screen.dart';
import 'package:mytica/screens/submain-screens/reminder/reminder_screen.dart';
import 'package:mytica/screens/submain-screens/todo/todo_screen.dart';

class NavigationRow extends StatefulWidget {
  const NavigationRow({super.key});

  @override
  State<NavigationRow> createState() => _NavigationRowState();
}

class _NavigationRowState extends State<NavigationRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
          Text(
            "Overview",
            style: TextStyle(
                letterSpacing: 1.5,
                color: Color(0xff6c757d)), //To-Do (Vansh): Font family
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.home,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                  child: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            height: 8,
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.person,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ProfileScreen.routeName);
                  },
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            height: 7,
            color: Colors.transparent,
          ),
          Divider(
            height: 2,
            color: Colors.transparent,

            // color: Color(0xff6c757d),
          ),
          Divider(
            height: 14,
            color: Colors.transparent,
          ),
          Text(
            "Screens",
            style: TextStyle(
                letterSpacing: 1.5,
                color: Color(0xff6c757d)), //To-Do (Vansh): Font family
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.note,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(JournalScreen.routeName);
                  },
                  child: Text(
                    "Journal",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            color: Colors.transparent,
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.notes_rounded,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 14,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(NotebookScreen.routeName);
                  },
                  child: Text(
                    "Notebooks",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            color: Colors.transparent,
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.image_rounded,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AlbumScreen.routeName);
                  },
                  child: Text(
                    "Album",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            height: 16,
            color: Colors.transparent,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.alarm_rounded,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ReminderScreen.routeName);
                  },
                  child: Text(
                    "Reminder",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            height: 16,
            color: Colors.transparent,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              const Icon(
                Icons.task_rounded,
                color: Colors.white54,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TodoScreen.routeName);
                  },
                  child: Text(
                    "To-Do",
                    style: TextStyle(fontSize: 16, color: Color(0xffedf6f9)),
                  )),
            ],
          ),
          Divider(
            height: 16,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
