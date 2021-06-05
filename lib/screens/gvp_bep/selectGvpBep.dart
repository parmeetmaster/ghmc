import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';

class SelectGvpBepScreen extends StatefulWidget {
  const SelectGvpBepScreen({Key? key}) : super(key: key);

  @override
  _SelectGvpBepScreenState createState() => _SelectGvpBepScreenState();
}

class _SelectGvpBepScreenState extends State<SelectGvpBepScreen> {
  List<String> items = ['GVP', 'BEP'];

  String itemValue = 'GVP';

  // formKey for form validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _circleController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();

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
        title: Text('Select GVP /BEP'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 20.0,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: DropdownButton(
                      value: itemValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.black,
                      // ),
                      items: items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          itemValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _landMarkController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Land Mark',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _wardController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ward',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _circleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Circle',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _zoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zone',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field should not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Done'),
                          content: Text('Your data is submit'),
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
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
