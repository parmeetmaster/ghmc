import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  Function? onclick;
  String? title;

  GradientButton({this.title = "", this.onclick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FlatButton(
            height: 30,
            onPressed: () {
              if (onclick != null) onclick!();
            },
            child: Text(
              '${title!}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}
