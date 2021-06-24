import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/model/dashboard/vehicle_table_model.dart';
import 'package:ghmc/model/dashboard/zone_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/widget/drawer.dart';
import 'package:ghmc/util/utils.dart';
import 'package:intl/intl.dart';

class DownloadViewScreenDashboard extends StatefulWidget {
  DateTime? startDate;
  DateTime? endDate;

  MenuItem? selected_zone;
  MenuItem? selected_vehicle;

  DownloadViewScreenDashboard(
      {this.startDate,
      this.endDate,
      this.selected_vehicle,
      this.selected_zone});

  @override
  _DownloadViewScreenDashboardState createState() =>
      _DownloadViewScreenDashboardState();
}

class _DownloadViewScreenDashboardState
    extends State<DownloadViewScreenDashboard> {
  VehicleTableModel? table_report;

  @override
  void initState() {
    super.initState();
    loadReport();
  }

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
          /*    leading: IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'menu',
              onPressed: () {},
            ),*/
          title: const Text('Dash Board'),
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              tooltip: 'map',
              onPressed: () {},
            ),
          ],
        ),
        body: table_report != null
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: DataTable2(
                  headingTextStyle: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black87),
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 2000,
                  dataRowHeight: 80,
                  columns: [
                    if (table_report != null)
                      ...table_report!.data!.columns!.map((e) => DataColumn(
                            label: Text(e.camelCase),
                          )),
                  ],
                  rows: [
                    if (table_report != null)
                      ...table_report!.data!.rows!.mapIndexed((e, index) =>
                          DataRow(
                              color: (index + 1) % 2 == 0
                                  ? MaterialStateProperty.all(Colors.grey[200])
                                  : MaterialStateProperty.all(
                                      Colors.transparent),
                              cells: [
                                ...e.map((e) => DataCell(Text("${e}"))),
                              ]))
                  ],

                  /*     rows: List<DataRow>.generate(
                  10,
                  (index) => DataRow(
                          color: (index + 1) % 2 == 0
                              ? MaterialStateProperty.all(Colors.grey[200])
                              : MaterialStateProperty.all(Colors.transparent),
                          cells: [
                            DataCell(Text('A' * (10 - index % 10))),
                            DataCell(Text('B' * (10 - (index + 5) % 10))),
                            DataCell(Text('C' * (15 - (index + 5) % 10))),
                            DataCell(Text('D' * (15 - (index + 10) % 10))),
                            DataCell(Text(((index + 0.1) * 25.4).toString()))
                          ]))*/
                ),
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }

  loadReport() async {
    DateFormat format = new DateFormat("dd-MM-yyyy");

    ApiResponse? response = await DashBoardProvider.getReference(context)
        .getReport(
            startdate: format.format(widget.startDate!),
            enddate: format.format(widget.endDate!),
            zone: widget.selected_zone,
            vehicle: widget.selected_vehicle);
    if (response!.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    table_report = VehicleTableModel.fromJson(response.completeResponse);
    // table_report!.data!.columns!.length.toString().printwarn;

    // this block for testing purposes
    if (mode == modes.testing) {
      table_report!.data!.rows!.forEach((element) {
        " Coloumn count ${table_report!.data!.columns!.length.toString()} Row count ${element.length.toString()}"
            .printwarn;
        if (table_report!.data!.columns!.length != element.length) {
          "This not compatable data ${element}".printwarn;
        }
      });
    }

    setState(() {});
  }
}
