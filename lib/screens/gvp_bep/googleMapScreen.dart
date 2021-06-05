import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/provider/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
      ),
      body: googleMap(context),
    );
  }

  Widget googleMap(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (consumerContext, model, child) {
        if (model.locationPosition != null) {
          return Stack(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: model.locationPosition,
                    zoom: 18.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: _onMapCreated,
                ),
              ),
              Positioned(
                left: 120.0,
                bottom: 30.0,
                child: ElevatedButton(
                  child: Text('Add Location'),
                  onPressed: () {
                    print('5555555555555555555${model.locationPosition}');
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Your location'),
                        content: Text('${model.locationPosition}'),
                        actions: <Widget>[
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("Done"),
                            ),
                          ),
                        ],
                      ),
                    );
                    Navigator.pop(context, '${model.locationPosition}');
                  },
                ),
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
