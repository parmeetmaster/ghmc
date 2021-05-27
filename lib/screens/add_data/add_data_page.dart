import 'package:flutter/material.dart';
import 'package:ghmc/screens/add_vehicle/add_vehicle_page.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';


class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {
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
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Data",
              style: TextStyle(fontSize: 25),
            ),
            IconButton(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 35,
                ),
                onPressed: () {})
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 310,
                width: 340,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Land Mark",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Ward",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Circle",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Zone",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "City",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: FlatButton(
                              height: 30,
                              minWidth: 200,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (AddVehiclePage()),
                                    ));
                              },
                              child: Text(
                                'Add Vehicle',
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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: FlatButton(
                              height: 30,
                              minWidth: 200,
                              onPressed: () {
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          (TransferStation()),
                                    ));*/
                              },
                              child: Text(
                                'Transfer Station',
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
                    ],
                  ),
                ),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 310,
                width: 340,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Land Mark",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Ward",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Circle",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Zone",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "City",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Text(
                              ":",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: FlatButton(
                              height: 30,
                              minWidth: 200,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (AddVehiclePage()),
                                    ));
                              },
                              child: Text(
                                'Add Vehicle',
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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          child: FlatButton(
                              height: 30,
                              minWidth: 200,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          (TransferStation()),
                                    ));
                              },
                              child: Text(
                                'Transfer Station',
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
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
