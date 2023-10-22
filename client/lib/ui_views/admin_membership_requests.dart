import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_intro/model/membership.dart';
import 'package:flutter_intro/controllers/membership_controller.dart';

import 'package:get/get.dart';

class MembershipRequestsMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Membership Request List',
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
                text: 'All Membership',
              ),
              Tab(
                text: 'Individual',
              ),
              Tab(
                text: 'Group',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: MembershipTable(),
            ),
            Center(
              child: MembershipTable(),
            ),
            Center(
              child: MembershipTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipTable extends StatelessWidget {
  const MembershipTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 65.0, bottom: 15.0, top: 20.0),
          child: MembershipRequestsView(),
        ),
      ],
    );
  }
}

final int rowsPerPage = 10;
bool showLoadingIndicator = true;

/// The home page of the application which hosts the datagrid.
class MembershipRequestsView extends StatefulWidget {
  /// Creates the home page.
  const MembershipRequestsView({Key? key}) : super(key: key);

  @override
  _MembershipRequestsState createState() => _MembershipRequestsState();
}

class _MembershipRequestsState extends State<MembershipRequestsView> {
  late Future<List<Membership>> futureMemberList;
  MembershipController membershipController = Get.put(MembershipController());

  late MembershipDataSource membershipDataSource;

  Future<List<Membership>> fethMembershipRequests() async {
    futureMemberList = membershipController.fetchMembershipRequests(0);
    print(futureMemberList);
    return futureMemberList;
  }

  @override
  void initState() {
    super.initState();
    membershipDataSource = MembershipDataSource(membershipData: []);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 600,
            width: MediaQuery.sizeOf(context).width,
            child: FutureBuilder<List<Membership>>(
                future: fethMembershipRequests(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final requestList = snapshot.data!;
                    membershipDataSource =
                        MembershipDataSource(membershipData: requestList);
                    return Column(
                      children: [
                        SfDataGridTheme(
                          data: SfDataGridThemeData(
                              headerColor: primaryLightBlue,
                              headerHoverColor: backgroundColor),
                          child: SfDataGrid(
                            source: membershipDataSource,
                            columnWidthMode: ColumnWidthMode.auto,
                            columns: <GridColumn>[
                              GridColumn(
                                  minimumWidth: 150,
                                  maximumWidth: 250,
                                  columnName: 'id',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text('Request ID'))),
                              GridColumn(
                                  minimumWidth: 200,
                                  maximumWidth: 300,
                                  columnName: 'user',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text('User ID'))),
                              GridColumn(
                                  minimumWidth: 200,
                                  maximumWidth: 300,
                                  columnName: 'fname',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text('First Name',
                                          overflow: TextOverflow.ellipsis))),
                              GridColumn(
                                  minimumWidth: 200,
                                  maximumWidth: 300,
                                  columnName: 'lname',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text('Last Name',
                                          overflow: TextOverflow.ellipsis))),
                              GridColumn(
                                  minimumWidth: 200,
                                  maximumWidth: 300,
                                  columnName: 'email',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text('Email',
                                          overflow: TextOverflow.ellipsis))),
                              GridColumn(
                                  minimumWidth: 200,
                                  maximumWidth: 300,
                                  columnName: 'type',
                                  label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text('Type'))),
                              GridColumn(
                                  minimumWidth: 200,
                                  maximumWidth: 300,
                                  columnName: 'status',
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
                            pageCount: (requestList.length / rowsPerPage)
                                .ceilToDouble(),
                            delegate: membershipDataSource,
                            direction: Axis.horizontal,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text("No Records To Display");
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class MembershipDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  MembershipDataSource({required List<Membership> membershipData}) {
    print(membershipData);
    _membershipDataGridRows = membershipData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'user', value: e.user),
              DataGridCell<String>(columnName: 'fname', value: e.firstname),
              DataGridCell<String>(columnName: 'amount', value: e.lastname),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'type', value: e.type),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
    _membershipData = membershipData;
    if (membershipData.isNotEmpty) {
      _paginatedRows = membershipData
          .getRange(
              0,
              membershipData.length < rowsPerPage
                  ? membershipData.length
                  : rowsPerPage)
          .toList(growable: false);
      buildDataGridRow();
    }
  }

  void buildDataGridRow() {
    _membershipDataGridRows = _paginatedRows
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'user', value: e.user),
              DataGridCell<String>(columnName: 'fname', value: e.firstname),
              DataGridCell<String>(columnName: 'amount', value: e.lastname),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'type', value: e.type),
              DataGridCell<String>(columnName: 'status', value: e.status),
              DataGridCell<String>(columnName: 'button', value: null),
            ]))
        .toList();
  }

  List<DataGridRow> _membershipDataGridRows = [];
  List<Membership> _paginatedRows = [];
  List<Membership> _membershipData = [];

  @override
  List<DataGridRow> get rows => _membershipDataGridRows;

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
    if (_endIndex > _membershipData.length) {
      _endIndex = _membershipData.length;
    }

    /// Get a particular range from the sorted collection.
    if (_startIndex < _membershipData.length &&
        _endIndex <= _membershipData.length) {
      _paginatedRows =
          _membershipData.getRange(_startIndex, _endIndex).toList();
    } else {
      _paginatedRows = <Membership>[];
    }
    buildDataGridRow();
    notifyListeners();
    return Future<bool>.value(true);
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }
}
