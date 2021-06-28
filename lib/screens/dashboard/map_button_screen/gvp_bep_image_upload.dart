

import 'package:flutter/material.dart';
import 'package:ghmc/widget/appbar/appbar.dart';

class GvpBepImageUpload extends StatefulWidget {
  const GvpBepImageUpload({Key? key}) : super(key: key);

  @override
  _GvpBepImageUploadState createState() => _GvpBepImageUploadState();
}

class _GvpBepImageUploadState extends State<GvpBepImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(),
      body: ListView(children: [
        Row(children: [

        ],)

      ],),
    );
  }
}
