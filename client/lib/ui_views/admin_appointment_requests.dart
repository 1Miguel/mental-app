import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_intro/model/appointment.dart';
import 'package:flutter_intro/controllers/appointment_controller.dart';
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
    return Column(
      children: [
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 65.0, bottom: 15.0, top: 20.0),
          child: AppointmentRequestsView(),
        ),
      ],
    );
  }
}

final int rowsPerPage = 10;
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
    appointmentDataSource = AppointmentDataSource(appointmentData: []);
  }

  Future<List<AppointmentInfo>> fethAppointmentRequests() async {
    futureAppointmentList = appointmentController.fetchAppointmentInfo();
    print(futureAppointmentList);
    return futureAppointmentList;
  }

  @override
  Widget build(BuildContext context) {
    fethAppointmentRequests();
    return Container(
      child: Column(children: [
        SizedBox(
          height: 600,
          width: MediaQuery.sizeOf(context).width,
          child: FutureBuilder<List<AppointmentInfo>>(
              future: fethAppointmentRequests(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final requestList = snapshot.data!;
                  appointmentDataSource =
                      AppointmentDataSource(appointmentData: requestList);
                  return Column(children: [
                    SfDataGridTheme(
                      data: SfDataGridThemeData(
                          headerColor: primaryLightBlue,
                          headerHoverColor: backgroundColor),
                      child: SfDataGrid(
                        source: appointmentDataSource,
                        columnWidthMode: ColumnWidthMode.auto,
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
                                  child: const Text('Center',
                                      overflow: TextOverflow.ellipsis))),
                          GridColumn(
                              minimumWidth: 200,
                              maximumWidth: 300,
                              columnName: 'startTime',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: const Text('Start Time',
                                      overflow: TextOverflow.ellipsis))),
                          GridColumn(
                              minimumWidth: 200,
                              maximumWidth: 300,
                              columnName: 'endTime',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: const Text('End Time',
                                      overflow: TextOverflow.ellipsis))),
                          GridColumn(
                              minimumWidth: 200,
                              maximumWidth: 300,
                              columnName: 'Status',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: const Text('Status'))),
                          GridColumn(
                            minimumWidth: 200,
                            maximumWidth: 300,
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
                    Container(
                      height: 70,
                      color: Colors.white,
                      child: SfDataPager(
                        pageCount:
                            (requestList.length / rowsPerPage).ceilToDouble(),
                        delegate: appointmentDataSource,
                        direction: Axis.horizontal,
                      ),
                    )
                  ]);
                } else {
                  return const Text("No Records To Display");
                }
              }),
        ),
      ]),
    );
  }
}

class AppointmentDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  AppointmentDataSource({required List<AppointmentInfo> appointmentData}) {
    _appointmentDataGridRows = appointmentData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'appId', value: e.id),
              DataGridCell<int>(columnName: 'appName', value: e.patientId),
              DataGridCell<String>(columnName: 'date', value: e.center),
              DataGridCell<String>(columnName: 'time', value: e.startTime),
              DataGridCell<String>(columnName: 'doctor', value: e.endTime),
              DataGridCell<String>(columnName: 'patient', value: e.status),
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
              DataGridCell<int>(columnName: 'appId', value: e.id),
              DataGridCell<int>(columnName: 'appName', value: e.patientId),
              DataGridCell<String>(columnName: 'date', value: e.center),
              DataGridCell<String>(columnName: 'time', value: e.startTime),
              DataGridCell<String>(columnName: 'doctor', value: e.endTime),
              DataGridCell<String>(columnName: 'patient', value: e.status),
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
          return Container(
              alignment: Alignment.center,
              child: dataGridCell.columnName == 'button'
                  ? LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: MaterialButton(
                                color: unselectedLightBlue,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          content: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Appointment ID: ${row.getCells()[0].value.toString()}'),
                                                  Text(
                                                      'Appointment Name: ${row.getCells()[1].value.toString()}'),
                                                  Text(
                                                      'Employee Designation: ${row.getCells()[2].value.toString()}'),
                                                ],
                                              ))));
                                },
                                child: const Text('Approve')),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: MaterialButton(
                                color: unselectedGray,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          content: SizedBox(
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Appointment ID: ${row.getCells()[0].value.toString()}'),
                                                  Text(
                                                      'Appointment Name: ${row.getCells()[1].value.toString()}'),
                                                  Text(
                                                      'Employee Designation: ${row.getCells()[2].value.toString()}'),
                                                ],
                                              ))));
                                },
                                child: const Text('Unapprove')),
                          ),
                        ],
                      );
                    })
                  : Text(dataGridCell.value.toString()));
        }).toList());
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
