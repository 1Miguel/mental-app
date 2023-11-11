// standard imports
import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/admin_appointment_controller.dart';
import 'package:flutter_intro/controllers/admin_membership_controller.dart';

// local imports
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/model/appointment.dart';
import 'package:flutter_intro/controllers/appointment_controller.dart';

// third-party imports
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';

class AppointmentRequestsMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointments Request List',
            style: TextStyle(
              color: primaryBlue,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'All Appointments',
              ),
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Approved',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: AppointmentsTable(),
            ),
            Center(
              child: AppointmentsTable(),
            ),
            Center(
              child: AppointmentsTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentsTable extends StatelessWidget {
  const AppointmentsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200,
      child: AppointmentRequestsView(),
    );
  }
}

final int rowsPerPage = 15;
bool showLoadingIndicator = true;

/// The home page of the application which hosts the datagrid.
class AppointmentRequestsView extends StatefulWidget {
  /// Creates the home page.
  const AppointmentRequestsView({Key? key}) : super(key: key);

  @override
  _AppointmentRequestsState createState() => _AppointmentRequestsState();
}

class _AppointmentRequestsState extends State<AppointmentRequestsView> {
  List<AppointmentInfo> appointments = <AppointmentInfo>[];
  late AppointmentDataSource appointmentDataSource;
  late Future<List<AppointmentInfo>> futureAppointmentList;
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  void initState() {
    super.initState();
    appointmentDataSource = AppointmentDataSource(
      appointmentData: [],
      onPressed: () {
        setState(() {
          print("set state in parent");
        });
      },
    );
  }

  Future<List<AppointmentInfo>> fethAppointmentRequests() async {
    futureAppointmentList = appointmentController.fetchAppointmentInfo();
    print(futureAppointmentList);
    return futureAppointmentList;
  }

  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    fethAppointmentRequests();
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        height: constraint.maxHeight - _dataPagerHeight,
        width: constraint.maxWidth,
        child: FutureBuilder<List<AppointmentInfo>>(
            future: fethAppointmentRequests(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final requestList = snapshot.data!;
                appointmentDataSource = AppointmentDataSource(
                    appointmentData: requestList,
                    onPressed: () {
                      setState(() {
                        print("set state in main");
                      });
                    });
                return Column(
                  children: [
                    Container(
                      height: constraint.maxHeight - _dataPagerHeight,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: primaryLightBlue,
                            headerHoverColor: backgroundColor),
                        child: SfDataGrid(
                          source: appointmentDataSource,
                          columnWidthMode: ColumnWidthMode.fill,
                          columns: <GridColumn>[
                            GridColumn(
                                minimumWidth: 150,
                                maximumWidth: 250,
                                columnName: 'id',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Appointment ID'))),
                            GridColumn(
                                minimumWidth: 200,
                                maximumWidth: 300,
                                columnName: 'patientId',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Patient ID'))),
                            GridColumn(
                                minimumWidth: 200,
                                maximumWidth: 300,
                                columnName: 'center',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Consulation Type',
                                        overflow: TextOverflow.ellipsis))),
                            GridColumn(
                                minimumWidth: 200,
                                maximumWidth: 300,
                                columnName: 'date',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Date',
                                        overflow: TextOverflow.ellipsis))),
                            GridColumn(
                                minimumWidth: 200,
                                maximumWidth: 300,
                                columnName: 'timeSlot',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Time Slot',
                                        overflow: TextOverflow.ellipsis))),
                            GridColumn(
                                minimumWidth: 200,
                                maximumWidth: 300,
                                columnName: 'status',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: const Text('Status'))),
                            GridColumn(
                              minimumWidth: 300,
                              maximumWidth: 350,
                              columnName: 'button',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text('Action '),
                              ),
                            ),
                          ],
                          //selectionMode: SelectionMode.multiple,
                        ),
                      ),
                    ),
                    Container(
                      height: _dataPagerHeight,
                      color: Colors.white,
                      child: SfDataPager(
                        pageCount:
                            (requestList.length / rowsPerPage).ceilToDouble(),
                        delegate: appointmentDataSource,
                        direction: Axis.horizontal,
                      ),
                    )
                  ],
                );
              } else {
                return const Text("No Records To Display");
              }
            }),
      );
    });
  }
}

class AppointmentDataSource extends DataGridSource {
  final VoidCallback onPressed;
  AdminAppointmentController adminAppointmentController =
      Get.put(AdminAppointmentController());

  /// Creates the employee data source class with required details.
  AppointmentDataSource(
      {required List<AppointmentInfo> appointmentData,
      required this.onPressed}) {
    _appointmentDataGridRows = appointmentData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'patientId', value: e.patientId),
              DataGridCell<String>(columnName: 'center', value: e.center),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(
                  columnName: 'timeSlot', value: '${e.startTime}-${e.endTime}'),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
    _appointmentData = appointmentData;
    _paginatedRows = appointmentData
        .getRange(
            0,
            appointmentData.length < rowsPerPage
                ? appointmentData.length
                : rowsPerPage)
        .toList(growable: false);
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _appointmentDataGridRows = _paginatedRows
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'patientId', value: e.patientId),
              DataGridCell<String>(columnName: 'center', value: e.center),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(
                  columnName: 'timeSlot', value: '${e.startTime}-${e.endTime}'),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _appointmentDataGridRows = [];
  List<AppointmentInfo> _paginatedRows = [];
  List<AppointmentInfo> _appointmentData = [];

  @override
  List<DataGridRow> get rows => _appointmentDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: backgroundColor,
        cells: row.getCells().map<Widget>((dataGridCell) {
          Color getColor() {
            if (dataGridCell.columnName == 'status') {
              if (dataGridCell.value == 'PENDING') {
                return Colors.orangeAccent;
              } else if (dataGridCell.value == 'ACTIVE') {
                return Colors.greenAccent;
              } else if (dataGridCell.value == 'REJECTED') {
                return Colors.redAccent;
              }
            }

            return Colors.black87;
          }

          return Container(
              alignment: Alignment.center,
              child: dataGridCell.columnName == 'button'
                  ? LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                      var enabled =
                          row.getCells()[5].value.toString() == "PENDING"
                              ? true
                              : false;
                      return Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: FilledButton.icon(
                              icon: Icon(Icons.check_circle, size: 15),
                              onPressed: enabled == false
                                  ? null
                                  : () => {
                                        _onApproveButtonPressed(
                                            context, row.getCells()[0].value),
                                      },
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(40, 40)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          enabled == true
                                              ? Colors.green
                                              : Colors.grey),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                              label: Text('Approve'),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: FilledButton.icon(
                              icon: Icon(Icons.cancel, size: 15),
                              onPressed: enabled == false
                                  ? null
                                  : () => {
                                        _onRejectButtonPressed(
                                            context, row.getCells()[0].value),
                                      },
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(40, 40)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          enabled == true
                                              ? primaryGrey
                                              : Colors.grey),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                              label: Text('Reject'),
                            ),
                          ),
                        ],
                      );
                    })
                  : Text(
                      dataGridCell.value.toString(),
                      style: TextStyle(color: getColor()),
                    ));
        }).toList());
  }

  _onApproveButtonPressed(context, int id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirm Action",
      desc: "Approve Request?",
      buttons: [
        DialogButton(
          child: Text(
            "Approve",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            adminAppointmentController.approveAppointment(id);
            Navigator.of(context, rootNavigator: true).pop();
            onPressed();
            buildDataGridRow();
            notifyListeners();
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          color: Colors.redAccent,
        )
      ],
    ).show();
  }

  _onRejectButtonPressed(context, int id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirm Action",
      desc: "Reject Request?",
      buttons: [
        DialogButton(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            adminAppointmentController.cancelAppointment(id);
            Navigator.of(context, rootNavigator: true).pop();
            onPressed();
            buildDataGridRow();
            notifyListeners();
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          color: Colors.redAccent,
        )
      ],
    ).show();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) {
    final int _startIndex = newPageIndex * rowsPerPage;
    int _endIndex = _startIndex + rowsPerPage;
    if (_endIndex > _appointmentData.length) {
      _endIndex = _appointmentData.length;
    }

    /// Get a particular range from the sorted collection.
    if (_startIndex < _appointmentData.length &&
        _endIndex <= _appointmentData.length) {
      _paginatedRows =
          _appointmentData.getRange(_startIndex, _endIndex).toList();
    } else {
      _paginatedRows = <AppointmentInfo>[];
    }
    buildDataGridRow();
    notifyListeners();
    return Future<bool>.value(true);
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }
}
