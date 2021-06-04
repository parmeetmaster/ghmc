import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghmc/screens/transfer/transfer_station.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/location.dart';
import 'package:location/location.dart';

class AddTransferStation extends StatefulWidget {
  const AddTransferStation({Key? key}) : super(key: key);

  @override
  _AddTransferStationState createState() => _AddTransferStationState();
}

class _AddTransferStationState extends State<AddTransferStation> {
  File? photo;
  bool islocationgrab=false;
  LocationData? location;
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
        title: Text("Add Transfer Station"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: DropdownButton(
                    items: [],
                    isExpanded: true,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 40,
                    ),
                    hint: Center(
                      child: Text(
                        "Add Transfer Station",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(15.0)),
              height: 250,
              width: 340,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: this.islocationgrab?Colors.green:Colors.black,
                      onPressed: () async{
                        CustomLocation customlocation=new CustomLocation();
                        location= await  customlocation.getLocation();
                        setState(() {
                          if( location!=null && (location!.latitude!.isNaN==false))
                            this.islocationgrab=true;
                        });
                      },
                      child: Image.asset(
                        "assets/images/location.png",
                        color: Colors.white,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(height: 20,),
                    if(location!=null)
                    Text("📌 Longitude:${this.location!.longitude}\n\n📌 Latitude: ${this.location!.latitude}")
                  ],
                ),
              ),
            ),
          ),
          this.photo == null
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
                      child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () async {
                            photo = await FilePick().takepic();
                            setState(() {

                            });
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 40,
                          )),
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
          SizedBox(
            height: 20,
          ),
          Container(
            child: FlatButton(
                height: 40,
                minWidth: 320,
                onPressed: () {



               /*   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransferStation()),
                  );*/
                },
                child: Text(
                  'Submit',
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
        ],
      ),
    );
  }
}
