import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/dashboard/vehicle_table_model.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/widget/drawer.dart';
import 'package:ghmc/util/utils.dart';

class DownloadViewScreenDashboard extends StatefulWidget {
  const DownloadViewScreenDashboard({Key? key}) : super(key: key);

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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 1000,
              sortAscending: true,
              columns: [
            /*    if(table_report!=null)
                  ...table_report!.data!.columns!.map((e) =>   DataColumn2(
                    label: Text('Column A'),
                    size: ColumnSize.S,
                  )),
*/

                DataColumn2(
                  label: Text('Column A'),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text('Column B'),
                ),
                DataColumn(
                  label: Text('Column C'),
                ),
                DataColumn(
                  label: Text('Column D'),
                ),
                DataColumn(
                  label: Text('Column NUMBERS'),
                  numeric: true,
                ),
              ],
              rows: List<DataRow>.generate(
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
                          ]))),
        ));
  }

  loadReport() async {
    ApiResponse? response =
        await DashBoardProvider.getReference(context).getReport();
    if (response!.status != 200) {
      response.message!.showSnackbar(context);
      return;
    }
    table_report = VehicleTableModel.fromJson(response.completeResponse);
    table_report!.data!.rows!.forEach((element) {
      "${element.toString()}".printwarn;

    });

    setState(() {});
  }
}
