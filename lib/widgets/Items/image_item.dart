import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mytica/data/local/db/app_db.dart';
import 'package:mytica/screens/submain-screens/album/image/detail_image_screen.dart';
import 'package:mytica/screens/submain-screens/album/image/image_screen.dart';

class ImageItem extends StatefulWidget {
  MyImage image;
  ImageItem(this.image);

  @override
  State<ImageItem> createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {
    //TO-DO: delete the image
    print(widget.image.imageurl);
    void _deleteImage() async {
      print("Image deleted..");
      final db = AppDb();
      await db.deleteImage(widget.image.id);
      await db.close().whenComplete(() =>
          {Navigator.of(context).pushReplacementNamed(ImageScreen.routeName)});
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailImageScreen.routeName, arguments: widget.image);
      },
      child: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 2.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: FileImage(File(widget.image.imageurl)),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 220,
                      width: 220,
                      child: Center(
                        child: Text(
                          "Image not found",
                          style: TextStyle(
                            fontSize: 20,
                            // color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },

                  height: 220,
                  width: 220, //492
                ),
              )),
          // SizedBox(
          //   height: 8,
          // ),
          // Container(
          //   width: 180,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         DateFormat.yMMMd().format(widget.image.createdAt),
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //           letterSpacing: 0.2,
          //         ),
          //       ),
          //       Text(
          //         widget.image.tag,
          //         style: TextStyle(
          //           fontSize: 16,
          //           // fontWeight: FontWeight.bold,
          //           color: Colors.black54,
          //           letterSpacing: 0.5,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
