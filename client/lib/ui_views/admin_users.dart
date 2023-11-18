// standard imports
import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/admin_appointment_controller.dart';
import 'package:flutter_intro/controllers/admin_membership_controller.dart';
import 'package:flutter_intro/controllers/admin_user_controller.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/admin_users_archived.dart';
import 'package:flutter_intro/ui_views/admin_users_banned.dart';
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

class AdminUsersMainView extends StatefulWidget {
  const AdminUsersMainView({super.key});

  @override
  _AdminUsersMainViewState createState() => _AdminUsersMainViewState();
}

class _AdminUsersMainViewState extends State<AdminUsersMainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Users',
            style: TextStyle(
              color: loginDarkTeal,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
          bottom: TabBar(
            labelColor: loginDarkTeal,
            indicatorColor: Colors.tealAccent,
            tabs: <Widget>[
              Tab(
                text: 'All Members',
              ),
              Tab(
                text: 'Archived',
              ),
              Tab(
                text: 'Banned',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: UsersTable(
                filter: "all",
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
            Center(
              child: ArchivedUsersTable(
                filter: "reserved",
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
            Center(
              child: BannedUsersTable(
                filter: "BANNED",
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
            Center(
              child: UsersTable(
                filter: "",
                onPressed: () {
                  setState(() {
                    print('set state in tab');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsersTable extends StatefulWidget {
  /// Creates the home page.
  final VoidCallback onPressed;
  final String filter;
  const UsersTable({
    super.key,
    required this.onPressed,
    required this.filter,
  });

  @override
  _UsersTableState createState() =>
      _UsersTableState(onPressed: onPressed, filter: filter);
}

class _UsersTableState extends State<UsersTable> {
  final VoidCallback onPressed;
  final String filter;

  _UsersTableState({required this.onPressed, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200,
      child: UsersMainView(
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

class UsersMainView extends StatefulWidget {
  /// Creates the home page.
  final VoidCallback onPressed;
  final String filter;
  const UsersMainView(
      {super.key, required this.onPressed, required this.filter});

  @override
  _UsersMainViewState createState() =>
      _UsersMainViewState(onPressed: onPressed, filter: filter);
}

class _UsersMainViewState extends State<UsersMainView> {
  List<User> appointments = <User>[];
  late UserDataSource usersDataSource;
  late Future<List<User>> futureUsersList;
  AdminUserController adminUserController = Get.put(AdminUserController());
  final VoidCallback onPressed;
  final String filter;

  _UsersMainViewState({required this.onPressed, required this.filter});

  @override
  void initState() {
    super.initState();
    usersDataSource = UserDataSource(
      userData: [],
      onPressed: () {
        setState(() {
          print("set state in parent");
        });
        onPressed();
      },
    );
  }

  Future<List<User>> fetchAllUsers() async {
    futureUsersList = adminUserController.fetchAllUsers();
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
            future: fetchAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final requestList = snapshot.data!;
                usersDataSource = UserDataSource(
                    userData: requestList,
                    onPressed: () {
                      setState(() {
                        print("set state in main");
                      });
                      onPressed();
                    });
                if (filter == "all") {
                  usersDataSource.addFilter(
                      'status',
                      FilterCondition(
                          type: FilterType.notEqual, value: "BANNED"));
                }
                if (filter == "reserved") {
                  usersDataSource.addFilter(
                      'status',
                      FilterCondition(
                          type: FilterType.equals, value: "RESERVED"));
                }
                if (filter == "cancelled") {
                  usersDataSource.addFilter(
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
                          source: usersDataSource,
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

class UserDataSource extends DataGridSource {
  final VoidCallback onPressed;
  AdminUserController adminUserController = Get.put(AdminUserController());

  String getFormattedDate(String date) {
    String formattedDate =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(date));
    return formattedDate;
  }

  /// Creates the employee data source class with required details.
  UserDataSource({required List<User> userData, required this.onPressed}) {
    _userDataGridRows = userData
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
    _userData = userData;
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _userDataGridRows = _userData
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

  List<DataGridRow> _userDataGridRows = [];
  List<User> _userData = [];

  @override
  List<DataGridRow> get rows => _userDataGridRows;

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
                              icon: Icon(Icons.delete, size: 15),
                              onPressed: enabled == false
                                  ? null
                                  : () => {
                                        _onDeleteButtonPressed(
                                            context, row.getCells()[0].value),
                                      },
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(40, 40)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          enabled == true
                                              ? Colors.red.shade400
                                              : Colors.grey),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                              label: Text('Delete'),
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

  _onDeleteButtonPressed(context, int id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirm Action",
      desc: "Delete this User?",
      buttons: [
        DialogButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            adminUserController.deleteUser(id, onPressed);
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
