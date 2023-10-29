import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_intro/model/membership.dart';
import 'package:flutter_intro/controllers/membership_controller.dart';

import 'package:get/get.dart';

final DataGridController _dataGridController = DataGridController();

class DonationRequestsMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Donation Request List',
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
              child: MembershipTable(filter: "all"),
            ),
            Center(
              child: MembershipTable(filter: "individual"),
            ),
            Center(
              child: MembershipTable(filter: "group"),
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipTable extends StatelessWidget {
  final String filter;
  const MembershipTable({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200,
      child: MembershipRequestsView(
        filterType: filter,
      ),
    );
  }
}

double pageCount = 0;
final int rowsPerPage = 15;
bool showLoadingIndicator = true;

class MembershipRequestsView extends StatefulWidget {
  String filterType;
  MembershipRequestsView({super.key, required this.filterType});

  @override
  _MembershipRequestsState createState() =>
      _MembershipRequestsState(filterType: filterType);
}

class _MembershipRequestsState extends State<MembershipRequestsView> {
  late Future<List<Membership>> futureMemberList;
  final String filterType;
  MembershipController membershipController = Get.put(MembershipController());

  late MembershipDataSource membershipDataSource;

  _MembershipRequestsState({required this.filterType});

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

  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        height: constraint.maxHeight - _dataPagerHeight,
        width: constraint.maxWidth,
        child: FutureBuilder<List<Membership>>(
            future: fethMembershipRequests(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final requestList = snapshot.data!;
                membershipDataSource =
                    MembershipDataSource(membershipData: requestList);
                if (filterType == "individual") {
                  membershipDataSource.addFilter(
                      'type',
                      FilterCondition(
                          type: FilterType.equals, value: "Contributing"));
                  membershipDataSource.addFilter('type',
                      FilterCondition(type: FilterType.equals, value: "Life"));
                  membershipDataSource.addFilter(
                      'type',
                      FilterCondition(
                          type: FilterType.equals, value: "Student"));
                } else if (filterType == "group") {
                  membershipDataSource.addFilter(
                      'type',
                      FilterCondition(
                          type: FilterType.equals, value: "Sustaining"));
                  membershipDataSource.addFilter(
                      'type',
                      FilterCondition(
                          type: FilterType.equals, value: "Corporate"));
                }
                //_updatePageCount();
                return Column(
                  children: [
                    Container(
                      height: constraint.maxHeight - _dataPagerHeight,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          brightness: Brightness.dark,
                          headerColor: primaryLightBlue,
                          headerHoverColor: backgroundColor,
                          filterIconColor: primaryBlue,
                          sortIconColor: primaryBlue,
                        ),
                        child: SfDataGrid(
                          source: membershipDataSource,
                          columnWidthMode: ColumnWidthMode.fill,
                          allowSorting: true,
                          allowFiltering: true,
                          columns: getColumns,
                          controller: _dataGridController,
                        ),
                      ),
                    ),
                    Container(
                      height: _dataPagerHeight,
                      color: Colors.white,
                      child: SfDataPager(
                        pageCount:
                            (requestList.length / rowsPerPage).ceilToDouble(),
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
      );
    });
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          minimumWidth: 80,
          maximumWidth: 100,
          columnName: 'id',
          allowSorting: false,
          allowFiltering: false,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Request ID'))),
      GridColumn(
          minimumWidth: 80,
          maximumWidth: 100,
          columnName: 'user',
          allowSorting: false,
          allowFiltering: false,
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
              child:
                  const Text('First Name', overflow: TextOverflow.ellipsis))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'lname',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Last Name', overflow: TextOverflow.ellipsis))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'email',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Email', overflow: TextOverflow.ellipsis))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'type',
          allowSorting: true,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Type'))),
      GridColumn(
          minimumWidth: 200,
          maximumWidth: 300,
          columnName: 'status',
          allowSorting: true,
          allowFiltering: true,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Status'))),
      GridColumn(
        minimumWidth: 350,
        maximumWidth: 450,
        columnName: 'button',
        allowSorting: false,
        allowFiltering: false,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text('Action '),
        ),
      ),
    ];
  }
}

class ViewInfoDialog extends StatelessWidget {
  final int membershipId;
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String type;

  ViewInfoDialog({
    super.key,
    required this.membershipId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
            width: 300,
            height: 500,
            child: Column(
              //mainAxisAlignment: MainAxisAlignme,
              children: [
                Text('Request Info:'),
                Row(
                  children: [
                    SizedBox(child: Text('Membership ID:')),
                    SizedBox(child: Text('$membershipId')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(child: Text('User ID:')),
                    SizedBox(child: Text('$userId')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(child: Text('First Name:')),
                    SizedBox(child: Text('$firstName')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(child: Text('Last Name:')),
                    SizedBox(child: Text('$lastName')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(child: Text('Email:')),
                    SizedBox(child: Text('$email')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(child: Text('Type:')),
                    SizedBox(child: Text('$type')),
                  ],
                ),
                Text('Membership ID: $membershipId'),
                Text('User ID: $userId'),
                Text('First Name: $firstName'),
                Text('Last Name: $lastName'),
                Text('Email: $email'),
                Text('Type: $type'),
              ],
            )));
  }
}

class MembershipDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  List<DataGridRow> _membershipDataGridRows = [];
  List<Membership> _paginatedRows = [];
  List<Membership> _membershipData = [];

  MembershipDataSource({required List<Membership> membershipData}) {
    var length = membershipData.length;
    print("MembershipData length: {$length}");
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
      print("paginatedRows: {$_paginatedRows}");
    }
  }

  @override
  List<DataGridRow> get rows => _membershipDataGridRows;

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
                      return Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: FilledButton.icon(
                              icon: Icon(Icons.check_circle, size: 15),
                              onPressed: enabled == false
                                  ? null
                                  : () => showDialog(
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
                                              )))),
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
                                                    ))))
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
                              label: Text('Unapprove'),
                            ),
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
