import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransferStation extends StatefulWidget {
  const TransferStation({Key? key}) : super(key: key);

  @override
  _TransferStationState createState() => _TransferStationState();
}

class _TransferStationState extends State<TransferStation> {
  double gap = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF9C27B0),
                Color(0xFFF06292),
                Color(0xFFFF5277),
              ],
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
          Image.asset("assets/truck.png"),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Scan',
            onPressed: _truck_loader,
          ),
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
                        key: "Owner Type", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Vehicle Type", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Vehicle Number", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Drive Name", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
                    _getRowVehicleDetails(
                        key: "Driver Number", value: "DATA IS HERE"),
                    SizedBox(
                      height: gap,
                    ),
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
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Center(
                child: Text(
              "Percentage of Waste",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF9C27B0),
                  Color(0xFFF06292),
                  Color(0xFFFF5277),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getPercentageContainer("25%"),
              _getPercentageContainer("50%"),
              _getPercentageContainer("75%"),
              _getPercentageContainer("100%"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
                child: Text(
              "Type of Waste",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF9C27B0),
                  Color(0xFFF06292),
                  Color(0xFFFF5277),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineButton(
                onPressed: () {},
                borderSide: BorderSide(color: Colors.black87),
                shape: StadiumBorder(),
                child: const Text("Domestic"),
              ),
              OutlineButton(
                onPressed: () {},
                borderSide: BorderSide(color: Colors.black87),
                shape: StadiumBorder(),
                child: const Text("Commercial"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF9C27B0),
                              Color(0xFFF06292),
                              Color(0xFFFF5277),
                            ],
                          ),
                        ),
                        height: 50,
                        width: 99,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 100,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 200,
                      width: 99,
                    ),
                  ],
                )),
          )
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
