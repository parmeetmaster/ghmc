import 'dart:io';

import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/recording.dart';
import 'package:ghmc/util/utils.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);

  @override
  _ComplainScreenState createState() => _ComplainScreenState();
}

class _ComplainScreenState<T> extends State<ComplainScreen> {
  RecodingAudioPlayer? recorder;
  Icon? icon;
  Color color = Colors.red;
  int currunt_step = 0;

  var photo;

  startRecording() {
    recorder = new RecodingAudioPlayer(
        timerstatus: (i) {
          i.toString().printwarn;
          currunt_step = i;
          setState(() {
            if (i == 30) {
              recorder!.stop();
              recorder!.getPath();
              recorder!.reset();
            }
          });
        },
        updateStatus: (s) {
          s.toString().printinfo;
          setState(() {});
        },
        recordingstatus: (irec) {});
  }

  @override
  void initState() {
    super.initState();
    startRecording();
  }

  Widget _buildControl() {
    if (recorder!.status == null) {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ClipOval(
            child: Material(
              color: color,
              child: InkWell(
                child: SizedBox(width: 50, height: 50, child: icon),
                onTap: () async {
                  if (recorder!.status == null) {
                    await recorder!.start();
                  } else if (recorder!.status == recordsEnum.start ||
                      recorder!.status == recordsEnum.resume) {
                    await recorder!.pause();
                  } else if (recorder!.status == recordsEnum.pause) {
                    await recorder!.resume();
                  }
                  setState(() {
                    if (recorder!.status == recordsEnum.start ||
                        recorder!.status == recordsEnum.resume) {
                      final theme = Theme.of(context);
                      icon = Icon(Icons.play_arrow,
                          color: theme.primaryColor, size: 30);
                      color = theme.primaryColor.withOpacity(0.1);
                    } else if (recorder!.status == recordsEnum.pause) {
                      icon = Icon(Icons.pause, color: Colors.red, size: 30);
                      color = Colors.red.withOpacity(0.1);
                    }
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  StepProgressIndicator(
                    totalSteps: 30,
                    currentStep: currunt_step,
                    size: 8,
                    padding: 0,
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.cyan,
                    roundedEdges: Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: main_color,
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey, Colors.grey],
                    ),
                  ),
                  Text(
                      "Status: ${recorder!.status == recordsEnum.start || recorder!.status == recordsEnum.resume ? "recording" : recorder!.status == recordsEnum.stop ? "Complete" : "pause"}")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          title: Text('Complaint'),
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
           children: [
             SizedBox(height: 25,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: Text("Select Complaint",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
             ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 340,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),borderRadius: BorderRadius.circular(10)
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    items: [],
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
                        "GVP",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
             SizedBox(height: 25,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: Text("Add Photograph",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                          photo = await FilePick().takecameraPic();
                          setState(() {});
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
             SizedBox(height: 25,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: Text("Please speak you complaint",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
             ),
             SizedBox(height: 10,),
             _buildControl(),
             SizedBox(height: 20,),
             Padding(
               padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
               child: Container(
                   child: Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: Center(
                       child: Text(
                         'Submit Complaint',
                         style: TextStyle(
                             color: Colors.white, fontSize: 20),
                       ),
                     ),
                   ),
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
             )


            ],
          ),
        ));
  }

/*
   _getDropDown(dynamic f) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: DropdownButton<TransferTypeDataItem>(
            onChanged: (val) {
              this.selected_transferStation = val as TransferTypeDataItem?;
              setState(() {});
            },
            // validation to check not null
            items: this.transferStations == null
                ? []
                : this
                    .transferStations!
                    .data!
                    .map((e) => DropdownMenuItem<TransferTypeDataItem>(
                          value: e,
                          child: Text("${e.name}"),
                        ))
                    .toList(),
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
                this.selected_transferStation == null
                    ? " Transfer Station List"
                    : "${this.selected_transferStation!.name}",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
*/

}
