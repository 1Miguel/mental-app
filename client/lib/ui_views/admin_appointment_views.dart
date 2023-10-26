import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Third-party import
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/utils/data_sources.dart';
import 'package:flutter_intro/utils/nav_helper.dart';
import 'package:flutter_intro/utils/custom_pager.dart';

class MainAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 1200, height: 900, child: PaginatedDataTable2Demo()),
      ],
    );
  }
}

class PaginatedDataTable2Demo extends StatefulWidget {
  const PaginatedDataTable2Demo({super.key});

  @override
  PaginatedDataTable2DemoState createState() => PaginatedDataTable2DemoState();
}

class PaginatedDataTable2DemoState extends State<PaginatedDataTable2Demo> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  late AppointmentDataSource _appointmentsDataSource;
  bool _initialized = false;
  PaginatorController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _appointmentsDataSource = AppointmentDataSource(
          context, getCurrentRouteOption(context) == defaultSorting);

      _controller = PaginatorController();

      if (getCurrentRouteOption(context) == defaultSorting) {
        _sortColumnIndex = 1;
      }
      _initialized = true;
    }
  }

  void sort<T>(
    Comparable<T> Function(Appointment d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _appointmentsDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void dispose() {
    _appointmentsDataSource.dispose();
    super.dispose();
  }

  List<DataColumn> get _columns {
    return [
      DataColumn(
        label: const Text('Appointment #'),
        onSort: (columnIndex, ascending) =>
            sort<num>((d) => d.appId, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Date'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<String>((d) => d.date, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Schedule'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<String>((d) => d.schedule, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Doctor'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<String>((d) => d.doctor, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Patient'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<String>((d) => d.patient, columnIndex, ascending),
      ),
      DataColumn(
        label: const Text('Status'),
        numeric: true,
        onSort: (columnIndex, ascending) =>
            sort<String>((d) => d.status, columnIndex, ascending),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      PaginatedDataTable2(
        // 100 Won't be shown since it is smaller than total records
        availableRowsPerPage: const [2, 5, 10, 30, 100],
        horizontalMargin: 20,
        checkboxHorizontalMargin: 12,
        columnSpacing: 0,
        wrapInCard: false,
        renderEmptyRowsInTheEnd: false,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => primaryLightPurple),
        header:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Appointment List',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontFamily: 'Proza Libre',
                  fontWeight: FontWeight.w500)),
          if (kDebugMode && getCurrentRouteOption(context) == custPager)
            Row(children: [
              OutlinedButton(
                  onPressed: () => _controller!.goToPageWithRow(25),
                  child: const Text('Go to row 25')),
              OutlinedButton(
                  onPressed: () => _controller!.goToRow(5),
                  child: const Text('Go to row 5'))
            ]),
          if (getCurrentRouteOption(context) == custPager &&
              _controller != null)
            PageNumber(controller: _controller!)
        ]),
        rowsPerPage: _rowsPerPage,
        autoRowsToHeight: getCurrentRouteOption(context) == autoRows,
        minWidth: 800,
        fit: FlexFit.tight,
        border: TableBorder(
            top: const BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.grey[300]!),
            left: BorderSide(color: Colors.grey[300]!),
            right: BorderSide(color: Colors.grey[300]!),
            verticalInside: BorderSide(color: Colors.grey[300]!),
            horizontalInside: const BorderSide(color: Colors.grey, width: 1)),
        onRowsPerPageChanged: (value) {
          // No need to wrap into setState, it will be called inside the widget
          // and trigger rebuild
          //setState(() {
          _rowsPerPage = value!;
          print(_rowsPerPage);
          //});
        },
        initialFirstRowIndex: 0,
        onPageChanged: (rowIndex) {
          print(rowIndex / _rowsPerPage);
        },
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
        sortArrowAnimationDuration:
            const Duration(milliseconds: 0), // custom animation duration
        onSelectAll: _appointmentsDataSource.selectAll,
        controller:
            getCurrentRouteOption(context) == custPager ? _controller : null,
        hidePaginator: getCurrentRouteOption(context) == custPager,
        columns: _columns,
        empty: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey[200],
                child: const Text('No data'))),
        source: getCurrentRouteOption(context) == noData
            ? AppointmentDataSource.empty(context)
            : _appointmentsDataSource,
      ),
      if (getCurrentRouteOption(context) == custPager)
        Positioned(bottom: 16, child: CustomPager(_controller!))
    ]);
  }
}
