// standard imports
import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/admin_appointment_controller.dart';
import 'package:flutter_intro/controllers/admin_membership_controller.dart';
import 'package:flutter_intro/controllers/admin_user_controller.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:intl/intl.dart';

// local imports
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/model/appointment.dart';
import 'package:flutter_intro/controllers/appointment_controller.dart';

// third-party imports
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';

class BannedUsersTable extends StatefulWidget {
  /// Creates the home page.
  final VoidCallback onPressed;
  final String filter;
  const BannedUsersTable({
    super.key,
    required this.onPressed,
    required this.filter,
  });

  @override
  _BannedUsersTableState createState() =>
      _BannedUsersTableState(onPressed: onPressed, filter: filter);
}

class _BannedUsersTableState extends State<BannedUsersTable> {
  final VoidCallback onPressed;
  final String filter;

  _BannedUsersTableState({required this.onPressed, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200,
      child: BannedUsersMainView(
        onPressed: () {
          setState(() {});
          onPressed();
        },
        filter: filter,
      ),
    );
  }
}

final int rowsPerPage = 15;
bool showLoadingIndicator = true;

class BannedUsersMainView extends StatefulWidget {
  /// Creates the home page.
  final VoidCallback onPressed;
  final String filter;
  const BannedUsersMainView(
      {super.key, required this.onPressed, required this.filter});

  @override
  _BannedUsersMainViewState createState() =>
      _BannedUsersMainViewState(onPressed: onPressed, filter: filter);
}

class _BannedUsersMainViewState extends State<BannedUsersMainView> {
  List<User> appointments = <User>[];
  late BannedUserDataSource bannedUsersDataSource;
  late Future<List<User>> futureUsersList;
  AdminUserController adminUserController = Get.put(AdminUserController());
  final VoidCallback onPressed;
  final String filter;

  _BannedUsersMainViewState({required this.onPressed, required this.filter});

  @override
  void initState() {
    super.initState();
    bannedUsersDataSource = BannedUserDataSource(
      bannedData: [],
      onPressed: () {
        setState(() {
          print("set state in parent");
        });
        onPressed();
      },
    );
  }

  Future<List<User>> fetchBannedUsers() async {
    futureUsersList = adminUserController.fetchAllBannedUsers();
    print(futureUsersList);
    print("fetched Updated Lists");
    return futureUsersList;
  }

  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        height: constraint.maxHeight - _dataPagerHeight,
        width: constraint.maxWidth,
        child: FutureBuilder<List<User>>(
            future: fetchBannedUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final requestList = snapshot.data!;
                bannedUsersDataSource = BannedUserDataSource(
                    bannedData: requestList,
                    onPressed: () {
                      setState(() {
                        print("set state in main");
                      });
                      onPressed();
                    });
                if (filter == "pending") {
                  bannedUsersDataSource.addFilter(
                      'status',
                      FilterCondition(
                          type: FilterType.equals, value: "PENDING"));
                }
                if (filter == "reserved") {
                  bannedUsersDataSource.addFilter(
                      'status',
                      FilterCondition(
                          type: FilterType.equals, value: "RESERVED"));
                }
                if (filter == "cancelled") {
                  bannedUsersDataSource.addFilter(
                      'status',
                      FilterCondition(
                          type: FilterType.equals, value: "CANCELLED"));
                }
                return Column(
                  children: [
                    Container(
                      height: constraint.maxHeight - _dataPagerHeight,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: Colors.teal,
                            headerHoverColor: backgroundColor),
                        child: SfDataGrid(
                          allowPullToRefresh: true,
                          allowFiltering: true,
                          source: bannedUsersDataSource,
                          columnWidthMode: ColumnWidthMode.fill,
                          columns: getColumns,

                          allowSorting: true,
                          //selectionMode: SelectionMode.multiple,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("No Records To Display");
              }
            }),
      );
    });
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          minimumWidth: 150,
          maximumWidth: 250,
          columnName: 'id',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'ID',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'email',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Email',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'fname',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'First Name',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'lname',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Last Name',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'uname',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Username',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'date',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'Member Since',
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      GridColumn(
        minimumWidth: 200,
        maximumWidth: 300,
        columnName: 'button',
        allowSorting: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            'Action ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }
}

class BannedUserDataSource extends DataGridSource {
  final VoidCallback onPressed;
  AdminUserController adminUserController = Get.put(AdminUserController());

  String getFormattedDate(String date) {
    String formattedDate =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(date));
    return formattedDate;
  }

  /// Creates the employee data source class with required details.
  BannedUserDataSource(
      {required List<User> bannedData, required this.onPressed}) {
    _bannedUserDataGridRows = bannedData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'fname', value: e.firstname),
              DataGridCell<String>(columnName: 'lname', value: e.lastname),
              DataGridCell<String>(columnName: 'uname', value: e.username),
              DataGridCell<String>(
                  columnName: 'date', value: getFormattedDate(e.dateCreated)),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
    _bannedData = bannedData;
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _bannedUserDataGridRows = _bannedData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'fname', value: e.firstname),
              DataGridCell<String>(columnName: 'lname', value: e.lastname),
              DataGridCell<String>(columnName: 'uname', value: e.username),
              DataGridCell<String>(
                  columnName: 'date', value: getFormattedDate(e.dateCreated)),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _bannedUserDataGridRows = [];
  List<User> _bannedData = [];

  @override
  List<DataGridRow> get rows => _bannedUserDataGridRows;

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
                      var enabled = true;
                      if (row.getCells()[1].value == "admin0@mentalapp.com" ||
                          (row.getCells()[1].value ==
                              "superadmin0@mentalapp.com")) {
                        enabled = false;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: FilledButton.icon(
                              icon: Icon(Icons.remove_circle_outline, size: 15),
                              onPressed: enabled == false
                                  ? null
                                  : () => {
                                        _onUnbanButtonPressed(
                                            context, row.getCells()[0].value),
                                      },
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(40, 40)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          enabled == true
                                              ? Colors.orange
                                              : Colors.grey),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                              label: Text('Unban'),
                            ),
                          ),
                        ],
                      );
                    })
                  : Text(
                      dataGridCell.value.toString(),
                      style: TextStyle(color: Colors.black),
                    ));
        }).toList());
  }

  _onUnbanButtonPressed(context, int id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirm Action",
      desc: "Unban this User?",
      buttons: [
        DialogButton(
          child: Text(
            "Unban",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            adminUserController.unbanUser(id, onPressed);
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

  void updateDataGriDataSource() {
    notifyListeners();
  }
}
