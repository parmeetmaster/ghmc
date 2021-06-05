import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/screens/gvp_bep/selectGvpBep.dart';

import 'add_gvp_bvp.dart';

class GvpBepScreen extends StatefulWidget {
  const GvpBepScreen({Key? key}) : super(key: key);

  @override
  _GvpBepScreenState createState() => _GvpBepScreenState();
}

class _GvpBepScreenState extends State<GvpBepScreen> {
  double gap = 10;

  @override
  Widget build(BuildContext context) {
    // this have grey shade problem
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFAD1457),
                  Color(0xFFAD801D9E),
                ]),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GVP / BEP",

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: 2,
                  child: Container(
                    color: Colors.white,
                  ),
              ),
            ),

            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectGvpBepScreen(),
                    ),
                  );

                })
          ],
        ),
      ),

    /*  appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: main_color,
            ),
          ),
        ),
        title: const Text('GVP / BEP'),
        actions: [
          Container(
            width: 1,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'add',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectGvpBepScreen(),
                ),
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),*/
      body: ListView(
        shrinkWrap: true,
        children: Globals.userData!.data!.access!
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _getRowVehicleDetails(
                          key: "Landmark",
                          value: "${e.landmarks}",
                        ),
                        SizedBox(
                          height: gap,
                        ),
                        _getRowVehicleDetails(
                          key: "Ward",
                          value: "${e.ward}",
                        ),
                        SizedBox(
                          height: gap,
                        ),
                        _getRowVehicleDetails(
                          key: "Circle",
                          value: "${e.circle}",
                        ),
                        SizedBox(
                          height: gap,
                        ),
                        _getRowVehicleDetails(
                          key: "Zone",
                          value: "${e.zone}",
                        ),
                        SizedBox(
                          height: gap,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: FlatButton(
                                height: 40,
                                minWidth: 300,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddGvpBepScreen(
                                        data: e,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Add GVP/BVP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFAD1457),
                                    Color(0xFFAD801D9E)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                        ),
                        /*Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: btn_grid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size(200, 0),
                              ),
                              child: Text(
                                'Add GVP / BEP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                print('@@@@@@@@@@@@@@@@@@@@@@@@@$e}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddGvpBepScreen(
                                      data: e,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // widgets
  _getRowVehicleDetails({
    String key = "",
    String value = "",
  }) {
    int flexLeft = 4;
    int flexRight = 5;
    TextStyle style = TextStyle(
      fontSize: 16,
    );
    return Row(
      children: [
        Expanded(
          flex: flexLeft,
          child: Text(
            "$key",
            style: style,
          ),
        ),
        SizedBox(
          width: 15,
          child: Text(":"),
        ),
        Expanded(
          flex: flexRight,
          child: Text(
            "$value",
            style: style,
          ),
        ),
      ],
    );
  }

  _getPercentageContainer(String percent) {
    return Container(
      height: 40,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            percent,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFFF5277),
            Color(0xFFF06292),
            Color(0xFF9C27B0),
          ],
        ),
      ),
    );
  }
}
