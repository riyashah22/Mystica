import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:intl/intl.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/album/image/image_screen.dart';

class DetailImageScreen extends StatefulWidget {
  static const routeName = '/detail-image-screen';
  const DetailImageScreen({super.key});

  @override
  State<DetailImageScreen> createState() => _DetailImageScreenState();
}

class _DetailImageScreenState extends State<DetailImageScreen> {
  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)?.settings.arguments as MyImage;

    void _deleteImage() async {
      print("Image deleted..");
      final db = AppDb();
      final album = await db.getAlbum(image.albumId);
      await db.deleteImage(image.id);
      await db.close().whenComplete(() {
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushReplacementNamed(ImageScreen.routeName, arguments: album);
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _deleteImage,
              icon: Icon(
                Icons.delete_forever_rounded,
              ))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffADD8FF), Color(0xffEBF5FF)], //final - 1
              stops: [0.4, 0.7],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              // color: Colors.red,
              width: MediaQuery.of(context).size.width * 0.65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image(
                  image: FileImage(
                    File(image.imageurl),
                  ),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  colorBlendMode: BlendMode.clear,
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(24),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffADD8FF),
                    offset: Offset(0.0, 2.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Image  Details:",
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
                  Text(
                    image.tag,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    image.imageurl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DateFormat.yMMMMd().format(image.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
