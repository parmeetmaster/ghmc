import 'package:flutter/material.dart';

class CardSeperateRow extends StatelessWidget {
  String? keyval;
  String? value;

  CardSeperateRow(this.keyval, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "${keyval}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          width: 15,
          child: Text(":", style: TextStyle(fontSize: 25)),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "${value??""}",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }


}
