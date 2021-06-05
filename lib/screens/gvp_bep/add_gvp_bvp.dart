import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';

// import 'package:geolocator/geolocator.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/credentials.dart';
import 'package:ghmc/provider/addGvpBepProvider.dart';
import 'package:ghmc/util/geocoding_utils.dart';
import 'package:ghmc/util/location.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ghmc/util/utils.dart';
import '../../dashBordScreen.dart';
import 'googleMapScreen.dart';

class AddGvpBepScreen extends StatefulWidget {
  final Access data;

  const AddGvpBepScreen({Key? key, required this.data}) : super(key: key);

  @override
  _AddGvpBepScreenState createState() => _AddGvpBepScreenState(data: data);
}

class _AddGvpBepScreenState extends State<AddGvpBepScreen> {
  final Access data;

  _AddGvpBepScreenState({required this.data});

  var locationCredentials = '';

  double gap = 10.0;

  List<String> items = ['GVP', 'BEP'];

  String itemValue = 'GVP';

  bool mapData = false;

  var locationMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: main_color,
            ),
          ),
        ),
        title: Text('Add GVP / BEP'),
      ),
      body: _buidBody(context),
    );
  }

  Widget _buidBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  _getRowVehicleDetails(
                    key: "Landmark",
                    value: "${data.landmarks}",
                  ),
                  SizedBox(
                    height: gap,
                  ),
                  _getRowVehicleDetails(
                    key: "Ward",
                    value: "${data.ward}",
                  ),
                  SizedBox(
                    height: gap,
                  ),
                  _getRowVehicleDetails(
                    key: "Circle",
                    value: "${data.circle}",
                  ),
                  SizedBox(
                    height: gap,
                  ),
                  _getRowVehicleDetails(
                    key: "Zone",
                    value: "${data.zone}",
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: DropdownButton<String>(
                isExpanded: true,
                onChanged: (value) {
                  itemValue = value! as String;
                  setState(() {});
                },
                items: items
                    .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text("${e}"),
                ))
                    .toList(),
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
                    "${itemValue}",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.80,
              // child: IconButton(
              //   icon: Icon(Icons.map),
              //   onPressed: getCurrentLocation,
              // ),
              child: mapData == true ? _mapdata(context) : _mapEmpty(context),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: FlatButton(
                height: 40,
                minWidth: 300,
                onPressed: () async {
                  int selecteditem = 0;
                  if (itemValue.toLowerCase() == "gvp") {
                    selecteditem = 0;
                  } else if (itemValue.toLowerCase() == "bep") {
                    selecteditem = 1;
                  }

                  MProgressIndicator.show(context);
                  String? statename = await GeoUtils().getStateName(context);
                  LocationData? locationdata =
                      await CustomLocation().getLocation();

                  if (locationdata!.latitude == null) {
                    "Please Select Locaiton on map".showSnackbar(context);
                    return;
                  }

                  ApiResponse? response =
                      await AddGvpBepProvider.getInstance(context)
                          .addGvpBepData(
                    userId: '${Globals.userData!.data!.userId}',
                    circleId: '${data.circleId}',
                    landMarkId: '${data.landmarksId}',
                    wardId: '${data.wardId}',
                    zoneId: '${data.zoneId}',
                    address: '${statename}',
                    longitude: "${locationdata.longitude}",
                    latitude: "${locationdata.latitude}",
                    type: '$selecteditem',
                  );
                  if (response!.status == 200)
                    await SingleButtonDialog(
                      message: response.message,
                      imageurl: "assets/svgs/garbage-truck.svg",
                      onOk: (context) {
                        Navigator.pop(context);
                        DashBordScreen().pushAndPopTillFirst(context);
                      },
                    ).pushDialog(context);

                  MProgressIndicator.hide();
                },
                child: Text(
                  'Add GVP/BVP',
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
        ),
      ],
    );
  }

  Widget _mapEmpty(BuildContext context) {
    return Center(
        child: FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () async {
        LocationData? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GoogleMapScreen(),
          ),
        );
        if (result!.longitude != null) {
          mapData = true;
        }

        setState(() {
          mapData = true;
          locationCredentials =
              "Longitude : ${result.longitude} Latitude : ${result.latitude}";
        });
        // GoogleMapScreen();
        // getCurrentLocation();
      },
      child: Image.asset(
        "assets/images/location.png",
        color: Colors.white,
        fit: BoxFit.fitHeight,
      ),
    ));
  }

  Widget _mapdata(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green[400],
            onPressed: () {},
            child: Image.asset(
              "assets/images/location.png",
              color: Colors.white,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text('$locationCredentials'),
          ),
        ],
      ),
    );
  }

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
}
