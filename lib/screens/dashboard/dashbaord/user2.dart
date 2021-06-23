import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/model/dashboard/dashboard_vehicle.dart';
import 'package:ghmc/model/dashboard/zone_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/screens/dashboard/download_screen/download_screen.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/dashboard_screen/dashboard_grid_button.dart';
import 'package:ghmc/util/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class User2DashBoard extends StatefulWidget {
  const User2DashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoard2State createState() => _UserDashBoard2State();
}

class _UserDashBoard2State extends State<User2DashBoard> {
  int tab_index = 0;

  DateTime? startDate;
  DateTime? endDate;
  DashboardVehicleModel? _dashboardVehicleModel;
  MenuItem? _selected_zone;
  MenuItem? _selected_vehicle;

  @override
  void initState() {
    super.initState();
    Globals.userData!.data!.token!.toString().printwtf;
    updateVehicleData(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardProvider>(builder: (context, value, child) {
      Widget tab = Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // show above tabs shifters as per index and true condition shows 2 tabs and 3 show while false
          child: /*userindex == "1" ?*/
              Card(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            tab_index = 0;
                          });
                        },
                        child: Center(
                          child: Text(
                            "Vehicles",
                            style: TextStyle(
                                color: Color(0xffE33535), fontSize: 16),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[500],
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            tab_index = 1;
                          });
                        },
                        child: Center(
                          child: Text(
                            "GVP / BEP",
                            style: TextStyle(
                                color: Color(0xff2796B7), fontSize: 16),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[500],
                    ),
                  ),
                  Expanded(
                      flex: 12,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            tab_index = 2;
                          });
                        },
                        child: Center(
                          child: Text(
                            "Transfer Station",
                            style: TextStyle(
                                color: Color(0xff2796B7), fontSize: 16),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          )
          /* : Card(
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                tab_index = 0;
                              });
                            },
                            child: Center(
                              child: Text(
                                "Vehicles",
                                style: TextStyle(
                                    color: Color(0xffE33535), fontSize: 16),
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              width: 1,
                              height: 40,
                              color: Colors.grey[500],
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                tab_index = 1;
                              });
                            },
                            child: Center(
                              child: Text(
                                "GVP / BEP",
                                style: TextStyle(
                                    color: Color(0xff2796B7), fontSize: 16),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),*/
          );
      Widget button_with_options = GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: (2.8 / 1),
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
        //physics:BouncingScrollPhysics(),
        padding: EdgeInsets.all(10.0),
        children: [
          // zone container
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (c) {
                    return AlertDialog(
                      content: Container(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * .8),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Text(
                              "Select Zone",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                ...value.zones!.data!.map((e) => InkWell(
                                      child: DropdownMenuItem(
                                        child: Text("${e.name}"),
                                        onTap: () {},
                                      ),
                                      onTap: () {
                                        print("Clicked");
                                        _selected_zone = e;
                                        Navigator.pop(c);
                                        setState(() {});
                                      },
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    _selected_zone == null
                        ? "Zones"
                        : _selected_zone!.name ?? "Zone Undefined",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                    size: 25,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Color(0xffF24169),
                    Color(0xffF4754C),
                  ])),
            ),
          ),
          //vehicle type
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (c) {
                    return AlertDialog(
                      content: Container(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * .8),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Text(
                              "Select Vehicle Type",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                ...value.vehicle_type!.data!.map((e) => InkWell(
                                      child: DropdownMenuItem(
                                        child: Text("${e.name!.camelCase}"),
                                        onTap: () {},
                                      ),
                                      onTap: () {
                                        print("Clicked");
                                        _selected_vehicle = e;
                                        Navigator.pop(c);
                                        setState(() {});
                                      },
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    _selected_vehicle == null
                        ? "Vehicle Type"
                        : _selected_vehicle!.name!.camelCase ??
                            "Vehicle Undefined",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                    size: 25,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Color(0xff6CC06B),
                    Color(0xff3AB370),
                  ])),
            ),
          ),
          // date selection
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      content: Container(
                        height: 350,
                        width: MediaQuery.of(ctx).size.width * 0.8,
                        color: Colors.white,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SfDateRangePicker(
                              onSelectionChanged: (s) {
                                DateRangePickerSelectionChangedArgs dateargs =
                                    s;
                                startDate = dateargs.value.startDate;
                                endDate = dateargs.value.endDate;
                                //   setState(() {});
                              },
                              maxDate: DateTime.now(),
                              startRangeSelectionColor: Colors.green[500],
                              endRangeSelectionColor: Colors.red[500],
                              selectionColor: Colors.pink,

                              // todayHighlightColor: Colors.pink,
                              selectionMode: DateRangePickerSelectionMode.range,
                            ),
                            GradientButton(
                              onclick: () {
                                Navigator.pop(ctx);
                                setState(() {});
                                if (startDate == null || endDate == null) {
                                  "Please choose Start Date and End Date"
                                      .showSnackbar(context);
                                }
                              },
                              title: "Done",
                              height: 15,
                              fontsize: 14,
                              padding: 4,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              child: Row(
                children: [
                  if (startDate == null || endDate == null)
                    Text(
                      "Select Date",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),

                  if (startDate != null && endDate != null)
                    Text(
                      startDate != null
                          ? "Start Date : " +
                              DateFormat.yMMMMd().format(startDate!) +
                              "\n" +
                              "End Date : " +
                              DateFormat.yMMMMd()
                                  .format(endDate ?? DateTime.now())
                          : "Select Date",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  SizedBox(
                    width: 7,
                  ),
                  // icon not display while date is avaiable
                  if (startDate == null)
                    Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.white,
                      size: 25,
                    )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Color(0xff58B9EC),
                    Color(0xff4065AC),
                  ])),
            ),
          ),
          // view downloads
          InkWell(
            onTap: () {
              if (this._selected_zone == null ||
                  this.startDate == null ||
                  this.endDate == null ||
                  this._selected_vehicle == null) {
                "Please Select all options before download"
                    .showSnackbar(context);
                return;
              }
              DownloadViewScreenDashboard(
                      startDate: startDate,
                      endDate: endDate,
                      selected_vehicle: _selected_vehicle,
                      selected_zone: _selected_zone)
                  .push(context);
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 25,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "View Downloads",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [
                    Color(0xff935498),
                    Color(0xff6D58A3),
                  ])),
            ),
          ),
        ],
      );

      // only vehicles and gvp bep with 2 tabs
      Widget vehicles_and_gvp_bep = Expanded(
        child: Column(
          children: [
            button_with_options,

            // vehicle title with 4 buttons here
            if (tab_index == 0)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: [
                    if (_dashboardVehicleModel != null)
                      ..._dashboardVehicleModel!.data!.map((item) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.tag}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                childAspectRatio: (1.5 / 1),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 2,
                                //physics:BouncingScrollPhysics(),
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xffF24169),
                                          Color(0xffF4754C),
                                        ],
                                        header: "Total",
                                        amount: "${item.total}"),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xff67C7E3),
                                          Color(0xff5AAADC),
                                        ],
                                        header: "Attend",
                                        amount: "${item.attend}"),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xffEF788D),
                                          Color(0xffF078A8),
                                        ],
                                        header: "Not Attend",
                                        amount: "${item.notAttend}"),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: DashBoardItemButton(
                                        color_grid: [
                                          Color(0xff3AB370),
                                          Color(0xff6CC06B),
                                        ],
                                        header: "Trips",
                                        amount: "${item.tsTrips}"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                    if (_dashboardVehicleModel == null)
                      Container(
                          child: Center(
                        child: CircularProgressIndicator(
                          color: primary_color,
                        ),
                      ))
                  ],
                ),
              ),
            // add gvp bvp
            if (tab_index == 1)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gvp",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          childAspectRatio: (1.5 / 1),
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 2,
                          //physics:BouncingScrollPhysics(),
                          children: [
                            DashBoardItemButton(color_grid: [
                              Color(0xffF24169),
                              Color(0xffF4754C),
                            ], header: "Total", amount: "1000"),
                            DashBoardItemButton(color_grid: [
                              Color(0xff67C7E3),
                              Color(0xff5AAADC),
                            ], header: "Attend", amount: "1000"),
                            DashBoardItemButton(color_grid: [
                              Color(0xffEF788D),
                              Color(0xffF078A8),
                            ], header: "Not Attend", amount: "1000"),
                            DashBoardItemButton(color_grid: [
                              Color(0xff3AB370),
                              Color(0xff6CC06B),
                            ], header: "Trips", amount: "1000"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "BEP",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      childAspectRatio: (1.5 / 1),
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 2,
                      //physics:BouncingScrollPhysics(),
                      children: [
                        DashBoardItemButton(color_grid: [
                          Color(0xffF24169),
                          Color(0xffF4754C),
                        ], header: "Total", amount: "1000"),
                        DashBoardItemButton(color_grid: [
                          Color(0xff67C7E3),
                          Color(0xff5AAADC),
                        ], header: "Attend", amount: "1000"),
                        DashBoardItemButton(color_grid: [
                          Color(0xffEF788D),
                          Color(0xffF078A8),
                        ], header: "Not Attend", amount: "1000"),
                        DashBoardItemButton(color_grid: [
                          Color(0xff3AB370),
                          Color(0xff6CC06B),
                        ], header: "Trips", amount: "1000"),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      );

      return Column(
        children: [
          // top tab
          tab,
          // only for gvp bep and vehicles
          if (tab_index == 0 || tab_index == 1) vehicles_and_gvp_bep,

          if (tab_index == 2)
            Expanded(
              child: Column(
                /*     shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),*/
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/calendar.png",
                            height: 50,
                          ),
                          Text(
                            "Vehicle Type",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          gradient: LinearGradient(colors: [
                            Color(0xff6CC06B),
                            Color(0xff3AB370),
                          ])),
                    ),
                  ),

                  // vehicle
                  if (tab_index == 0)
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: [
                          Text(
                            "Total Vehicles",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: (1.5 / 1),
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            //physics:BouncingScrollPhysics(),
                            children: [
                              DashBoardItemButton(color_grid: [
                                Color(0xffF24169),
                                Color(0xffF4754C),
                              ], header: "Total", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff67C7E3),
                                Color(0xff5AAADC),
                              ], header: "Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xffEF788D),
                                Color(0xffF078A8),
                              ], header: "Not Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff3AB370),
                                Color(0xff6CC06B),
                              ], header: "Trips", amount: "1000"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Swach Auto",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: (1.5 / 1),
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            //physics:BouncingScrollPhysics(),
                            children: [
                              DashBoardItemButton(color_grid: [
                                Color(0xffF24169),
                                Color(0xffF4754C),
                              ], header: "Total", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff67C7E3),
                                Color(0xff5AAADC),
                              ], header: "Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xffEF788D),
                                Color(0xffF078A8),
                              ], header: "Not Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff3AB370),
                                Color(0xff6CC06B),
                              ], header: "Trips", amount: "1000"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Secondary Vehicles",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: (1.5 / 1),
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            //physics:BouncingScrollPhysics(),
                            children: [
                              DashBoardItemButton(color_grid: [
                                Color(0xffF24169),
                                Color(0xffF4754C),
                              ], header: "Total", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff67C7E3),
                                Color(0xff5AAADC),
                              ], header: "Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xffEF788D),
                                Color(0xffF078A8),
                              ], header: "Not Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff3AB370),
                                Color(0xff6CC06B),
                              ], header: "Trips", amount: "1000"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  // add gvp bvp
                  if (tab_index == 1)
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gvp",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                childAspectRatio: (1.5 / 1),
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 2,
                                //physics:BouncingScrollPhysics(),
                                children: [
                                  DashBoardItemButton(color_grid: [
                                    Color(0xffF24169),
                                    Color(0xffF4754C),
                                  ], header: "Total", amount: "1000"),
                                  DashBoardItemButton(color_grid: [
                                    Color(0xff67C7E3),
                                    Color(0xff5AAADC),
                                  ], header: "Attend", amount: "1000"),
                                  DashBoardItemButton(color_grid: [
                                    Color(0xffEF788D),
                                    Color(0xffF078A8),
                                  ], header: "Not Attend", amount: "1000"),
                                  DashBoardItemButton(color_grid: [
                                    Color(0xff3AB370),
                                    Color(0xff6CC06B),
                                  ], header: "Trips", amount: "1000"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "BEP",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: (1.5 / 1),
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 2,
                            //physics:BouncingScrollPhysics(),
                            children: [
                              DashBoardItemButton(color_grid: [
                                Color(0xffF24169),
                                Color(0xffF4754C),
                              ], header: "Total", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff67C7E3),
                                Color(0xff5AAADC),
                              ], header: "Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xffEF788D),
                                Color(0xffF078A8),
                              ], header: "Not Attend", amount: "1000"),
                              DashBoardItemButton(color_grid: [
                                Color(0xff3AB370),
                                Color(0xff6CC06B),
                              ], header: "Trips", amount: "1000"),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      );
    });
  }

  // Vehicles list with download options
  void updateVehicleData(DateTime? vehicle_date) async {
    final provider = Provider.of<DashBoardProvider>(context, listen: false);

    String str = DateFormat("dd-MM-yyyy").format(vehicle_date!);
    print(str);
    ApiResponse? response = await provider.getVehicesInfo(
        userid: Globals.userData!.data!.userId!, dateString: str);
    if (response!.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    _dashboardVehicleModel =
        DashboardVehicleModel.fromJson(response.completeResponse);
    setState(() {});
  }
}
