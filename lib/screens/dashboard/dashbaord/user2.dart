import 'package:flutter/material.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/widget/dashboard_screen/dashboard_grid_button.dart';
import 'package:ghmc/util/utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class User2DashBoard extends StatefulWidget {
  const User2DashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoard2State createState() => _UserDashBoard2State();
}

class _UserDashBoard2State extends State<User2DashBoard> {
  int tab_index = 0;
  String userindex = "1";

  @override
  void initState() {
    super.initState();
    Globals.userData!.data!.token!.toString().printwtf;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(userindex),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // show above tabs shifters as per index and true condition shows 2 tabs and 3 show while false
          child: userindex == "3"
              ? Card(
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
                            flex: 11,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  tab_index = 3;
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
              : Card(
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
                ),
        ),
        // adding condition to show

        // only for gvp bep and vehicles
        if (userindex == "1")
          Expanded(
            child: Column(
              /*     shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),*/
              children: [
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: (2.8 / 1),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  //physics:BouncingScrollPhysics(),
                  padding: EdgeInsets.all(10.0),
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width*0.8,
                                  color: Colors.white,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      SfDateRangePicker(
                                        onSelectionChanged: (s) {
                                          DateRangePickerSelectionChangedArgs
                                              dateargs = s;
                                          print(dateargs.value);
                                          print(dateargs.value.startDate);
                                          print(dateargs.value.endDate);
                                        },
                                        startRangeSelectionColor: Colors.green[500],
                                        endRangeSelectionColor: Colors.red[500],
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                      ),
                                      GradientButton(onclick: (){
                                        Navigator.pop(context);
                                      },title: "Done",height: 15,fontsize: 14,padding: 4,)
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
                              "Zones",
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
                    Container(
                      child: Row(
                        children: [
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
                    Container(
                      child: Row(
                        children: [
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
                    Container(
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
                  ],
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

        // only for transfer station
        if (userindex == "3")
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
  }
}
