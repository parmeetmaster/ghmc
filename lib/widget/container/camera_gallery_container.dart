import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/utils.dart';

class CameraGalleryContainerWidget extends StatefulWidget {
  Function(File)? oncapture;
  CameraGalleryContainerWidget({Key? key, required this.oncapture})
      : super(key: key);

  @override
  _CameraGalleryContainerWidgetState createState() =>
      _CameraGalleryContainerWidgetState();
}

class _CameraGalleryContainerWidgetState
    extends State<CameraGalleryContainerWidget> {
  File? photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.photo == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: 340,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () async {
                            photo = await FilePick().takecameraPic();
                            if (photo != null) {
                              "Photo taken".printinfo;
                              if (widget.oncapture != null) {
                                widget.oncapture!(photo!);
                              }
                            }

                            setState(() {});
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 40,
                          )),
                      FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () async {
                            photo = await FilePick().pickFile();
                            if (photo != null) {
                              "Photo taken".printinfo;
                              if (widget.oncapture != null) {
                                widget.oncapture!(photo!);
                              }
                            }
                            setState(() {});
                          },
                          child: Icon(
                            Icons.picture_in_picture_sharp,
                            color: Colors.white,
                            size: 40,
                          )),
                    ],
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: 340,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image.file(this.photo!)),
                ),
              ),
            ),
    );
  }
}
