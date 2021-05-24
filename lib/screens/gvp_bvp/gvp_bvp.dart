import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';

class GvpBvpScreen extends StatefulWidget {
  const GvpBvpScreen({Key? key}) : super(key: key);

  @override
  _GvpBvpScreenState createState() => _GvpBvpScreenState();
}

class _GvpBvpScreenState extends State<GvpBvpScreen> {
  double gap = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: grid,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'menu',
          onPressed: () {},
        ),
        title: const Text('Transfer Station'),
        actions: [
          Container(width: 1,
            padding: EdgeInsets.only(top:10,bottom: 10),
            child: Expanded(child: Container( color: Colors.white,),),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Scan',
            onPressed: _truck_loader,
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _getRowVehicleDetails(
                        key: "Landmark", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "Ward", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "Circle", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "Zone", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "City", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: btn_grid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "Add GVP/BVP",
                        style: TextStyle(
                          color: Colors.white,
                         // fontWeight: FontWeight.bold,
                          fontSize: 17
                        ),
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _getRowVehicleDetails(
                        key: "Landmark", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "Ward", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "Circle", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "Zone", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(key: "City", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: btn_grid),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                            "Add GVP/BVP",
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // widgets
  _getRowVehicleDetails({String key = "", String value = ""}) {
    int flexleft = 4;
    int flexright = 5;
    TextStyle style = TextStyle(
      fontSize: 16,
    );
    return Row(
      children: [
        Expanded(flex: flexleft, child: Text("$key", style: style)),
        SizedBox(
          width: 15,
          child: Text(":"),
        ),
        Expanded(
            flex: flexright,
            child: Text(
              "$value",
              style: style,
            ))
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
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )),
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

  void _truck_loader() {}
}
