import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
  List<Appointment> appointments = <Appointment>[];
  late AppointmentDataSource appointmentDataSource;

  @override
  void initState() {
    super.initState();
    appointments = getAppointmentData();
    appointmentDataSource =
        AppointmentDataSource(appointmentData: appointments);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 600,
            width: MediaQuery.sizeOf(context).width,
            child: SfDataGridTheme(
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
                      columnName: 'appId',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Appointment ID'))),
                  GridColumn(
                      minimumWidth: 200,
                      maximumWidth: 300,
                      columnName: 'appName',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Appointment Name'))),
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
                      columnName: 'time',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Time',
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      minimumWidth: 200,
                      maximumWidth: 300,
                      columnName: 'doctor',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Doctor',
                              overflow: TextOverflow.ellipsis))),
                  GridColumn(
                      minimumWidth: 200,
                      maximumWidth: 300,
                      columnName: 'patient',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Patient'))),
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
          ),
          Container(
            height: 70,
            color: Colors.white,
            child: SfDataPager(
              pageCount: (appointments.length / rowsPerPage).ceilToDouble(),
              delegate: appointmentDataSource,
              direction: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  List<Appointment> getAppointmentData() {
    return [
      Appointment(10001, 'Appointment - Jack', '2023-10-16', '09:00-10:00',
          'PMHA Doctor', 'Jack Doe', 'PENDING'),
      Appointment(10002, 'Appointment - Perry', '2023-10-17', '10:00-11:00',
          'PMHA Doctor', 'Perry Doe', 'PENDING'),
      Appointment(10003, 'Appointment - Lara', '2023-10-18', '11:00-12:00',
          'PMHA Doctor', 'Lara Doe', 'PENDING'),
      Appointment(10004, 'Appointment - Ellis', '2023-10-19', '01:00-02:00',
          'PMHA Doctor', 'Ellis Doe', 'APPROVED'),
      Appointment(10005, 'Appointment - Adams', '2023-10-20', '03:00-4:00',
          'PMHA Doctor', 'Adams Doe', 'APPROVED'),
      Appointment(10006, 'Appointment - Owens', '2023-10-21', '04:00-05:00',
          'PMHA Doctor', 'Owens Doe', 'APPROVED'),
      Appointment(10007, 'Appointment - Balnc', '2023-10-22', '09:00-10:00',
          'PMHA Doctor', 'Balnc Doe', 'PENDING'),
      Appointment(10008, 'Appointment - Steve', '2023-10-23', '10:00-11:00',
          'PMHA Doctor', 'Steve Doe', 'PENDING'),
      Appointment(10009, 'Appointment - Linda', '2023-10-24', '11:00-12:00',
          'PMHA Doctor', 'Linda Doe', 'PENDING'),
      Appointment(10010, 'Appointment - Michael', '2023-10-25', '01:00-02:00',
          'PMHA Doctor', 'Michael Doe', 'PENDING'),
      Appointment(10011, 'Appointment - Jack', '2023-10-16', '09:00-10:00',
          'PMHA Doctor', 'Jack Doe', 'PENDING'),
      Appointment(10012, 'Appointment - Perry', '2023-10-17', '10:00-11:00',
          'PMHA Doctor', 'Perry Doe', 'PENDING'),
      Appointment(10013, 'Appointment - Lara', '2023-10-18', '11:00-12:00',
          'PMHA Doctor', 'Lara Doe', 'PENDING'),
      Appointment(10014, 'Appointment - Ellis', '2023-10-19', '01:00-02:00',
          'PMHA Doctor', 'Ellis Doe', 'APPROVED'),
      Appointment(10015, 'Appointment - Adams', '2023-10-20', '03:00-4:00',
          'PMHA Doctor', 'Adams Doe', 'APPROVED'),
      Appointment(10016, 'Appointment - Owens', '2023-10-21', '04:00-05:00',
          'PMHA Doctor', 'Owens Doe', 'APPROVED'),
      Appointment(10017, 'Appointment - Balnc', '2023-10-22', '09:00-10:00',
          'PMHA Doctor', 'Balnc Doe', 'PENDING'),
      Appointment(10018, 'Appointment - Steve', '2023-10-23', '10:00-11:00',
          'PMHA Doctor', 'Steve Doe', 'PENDING'),
      Appointment(10019, 'Appointment - Linda', '2023-10-24', '11:00-12:00',
          'PMHA Doctor', 'Linda Doe', 'PENDING'),
      Appointment(10020, 'Appointment - Michael', '2023-10-25', '01:00-02:00',
          'PMHA Doctor', 'Michael Doe', 'PENDING')
    ];
  }
}

class AppointmentDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  AppointmentDataSource({required List<Appointment> appointmentData}) {
    _appointmentDataGridRows = appointmentData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'appId', value: e.appId),
              DataGridCell<String>(columnName: 'appName', value: e.appName),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'time', value: e.time),
              DataGridCell<String>(columnName: 'doctor', value: e.doctor),
              DataGridCell<String>(columnName: 'patient', value: e.patient),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
    _appointmentData = appointmentData;
    _paginatedRows =
        appointmentData.getRange(0, rowsPerPage).toList(growable: false);
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _appointmentDataGridRows = _paginatedRows
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'appId', value: e.appId),
              DataGridCell<String>(columnName: 'appName', value: e.appName),
              DataGridCell<String>(columnName: 'date', value: e.date),
              DataGridCell<String>(columnName: 'time', value: e.time),
              DataGridCell<String>(columnName: 'doctor', value: e.doctor),
              DataGridCell<String>(columnName: 'patient', value: e.patient),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _appointmentDataGridRows = [];
  List<Appointment> _paginatedRows = [];
  List<Appointment> _appointmentData = [];

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
      _paginatedRows = <Appointment>[];
    }
    buildDataGridRow();
    notifyListeners();
    return Future<bool>.value(true);
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }
}

// /// An object to set the employee collection data source to the datagrid. This
// /// is used to map the employee data to the datagrid widget.
// class AppointmentDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
//   // AppointmentDataSource({required List<Appointment> appointmentData}) {
//   //   _appointmentData = appointmentData
//   //       .map<DataGridRow>((e) => DataGridRow(cells: [
//   //             DataGridCell<int>(columnName: 'appId', value: e.appId),
//   //             DataGridCell<String>(columnName: 'appName', value: e.appName),
//   //             DataGridCell<String>(columnName: 'date', value: e.date),
//   //             DataGridCell<String>(columnName: 'time', value: e.time),
//   //             DataGridCell<String>(columnName: 'doctor', value: e.doctor),
//   //             DataGridCell<String>(columnName: 'patient', value: e.patient),
//   //             DataGridCell<String>(columnName: 'status', value: e.status),
//   //           ]))
//   //       .toList(growable: false);
//   //   _paginatedRows = appointmentData;
//   //   buildDataGridRow();
//   // }

//   /// Creates the employee data source class with required details.
//   AppointmentDataSource({required List<Appointment> appointmentData}) {
//     _appointmentData = appointmentData;
//     _paginatedRows = appointmentData;
//     buildDataGridRow();
//   }

//   void buildDataGridRow() {
//     _appointmentDataGridRows = _paginatedRows
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: 'appId', value: e.appId),
//               DataGridCell<String>(columnName: 'appName', value: e.appName),
//               DataGridCell<String>(columnName: 'date', value: e.date),
//               DataGridCell<String>(columnName: 'time', value: e.time),
//               DataGridCell<String>(columnName: 'doctor', value: e.doctor),
//               DataGridCell<String>(columnName: 'patient', value: e.patient),
//               DataGridCell<String>(columnName: 'button', value: null),
//             ]))
//         .toList();
//     print(_appointmentDataGridRows);
//   }

//   List<DataGridRow> _appointmentDataGridRows = [];
//   List<Appointment> _paginatedRows = [];
//   List<Appointment> _appointmentData = [];

//   @override
//   List<DataGridRow> get rows => _appointmentDataGridRows;

//   // @override
//   // DataGridRowAdapter buildRow(DataGridRow row) {
//   //   return DataGridRowAdapter(
//   //       color: backgroundColor,
//   //       cells: row.getCells().map<Widget>((dataGridCell) {
//   //         return Container(
//   //             alignment: Alignment.center,
//   //             child: dataGridCell.columnName == 'button'
//   //                 ? LayoutBuilder(builder:
//   //                     (BuildContext context, BoxConstraints constraints) {
//   //                     return Row(
//   //                       children: [
//   //                         Padding(
//   //                           padding:
//   //                               const EdgeInsets.only(left: 8.0, right: 8.0),
//   //                           child: MaterialButton(
//   //                               color: unselectedLightBlue,
//   //                               onPressed: () {
//   //                                 showDialog(
//   //                                     context: context,
//   //                                     builder: (context) => AlertDialog(
//   //                                         content: SizedBox(
//   //                                             height: 100,
//   //                                             child: Column(
//   //                                               mainAxisAlignment:
//   //                                                   MainAxisAlignment
//   //                                                       .spaceBetween,
//   //                                               children: [
//   //                                                 Text(
//   //                                                     'Appointment ID: ${row.getCells()[0].value.toString()}'),
//   //                                                 Text(
//   //                                                     'Appointment Name: ${row.getCells()[1].value.toString()}'),
//   //                                                 Text(
//   //                                                     'Employee Designation: ${row.getCells()[2].value.toString()}'),
//   //                                               ],
//   //                                             ))));
//   //                               },
//   //                               child: const Text('Approve')),
//   //                         ),
//   //                         Padding(
//   //                           padding:
//   //                               const EdgeInsets.only(left: 8.0, right: 8.0),
//   //                           child: MaterialButton(
//   //                               color: unselectedGray,
//   //                               onPressed: () {
//   //                                 showDialog(
//   //                                     context: context,
//   //                                     builder: (context) => AlertDialog(
//   //                                         content: SizedBox(
//   //                                             height: 100,
//   //                                             child: Column(
//   //                                               mainAxisAlignment:
//   //                                                   MainAxisAlignment
//   //                                                       .spaceBetween,
//   //                                               children: [
//   //                                                 Text(
//   //                                                     'Appointment ID: ${row.getCells()[0].value.toString()}'),
//   //                                                 Text(
//   //                                                     'Appointment Name: ${row.getCells()[1].value.toString()}'),
//   //                                                 Text(
//   //                                                     'Employee Designation: ${row.getCells()[2].value.toString()}'),
//   //                                               ],
//   //                                             ))));
//   //                               },
//   //                               child: const Text('Unapprove')),
//   //                         ),
//   //                       ],
//   //                     );
//   //                   })
//   //                 : Text(dataGridCell.value.toString()));
//   //       }).toList());
//   // }

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//       return Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(8.0),
//         child: Text(e.value.toString()),
//       );
//     }).toList());
//   }

//   // @override
//   // Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) {
//   //   final int _startIndex = newPageIndex * _rowsPerPage;
//   //   int _endIndex = _startIndex + _rowsPerPage;
//   //   if (_endIndex > _appointmentData.length) {
//   //     _endIndex = _appointmentData.length;
//   //   }

//   //   /// Get a particular range from the sorted collection.
//   //   if (_startIndex < _appointmentData.length &&
//   //       _endIndex <= _appointmentData.length) {
//   //     _paginatedRows =
//   //         _appointmentData.getRange(_startIndex, _endIndex).toList();
//   //   } else {
//   //     _paginatedRows = <Appointment>[];
//   //   }
//   //   buildDataGridRow();
//   //   notifyListeners();
//   //   return Future<bool>.value(true);
//   // }

//   void updateDataGriDataSource() {
//     notifyListeners();
//   }
// }

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Appointment {
  /// Creates the employee class with required details.
  Appointment(this.appId, this.appName, this.date, this.time, this.doctor,
      this.patient, this.status);

  /// Id of an employee.
  final int appId;

  /// Name of an employee.
  final String appName;

  /// Appointment Date
  final String date;

  /// Appointment Timeslot;
  final String time;

  /// Designation of an employee.
  final String doctor;

  /// Salary of an employee.
  final String patient;

  /// Appointment Status
  final String status;
}
