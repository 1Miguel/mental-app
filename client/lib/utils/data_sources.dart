// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

/// Keeps track of selected rows, feed the data into DesertsDataSource
class RestorableAppointmentSelections extends RestorableProperty<Set<int>> {
  Set<int> _appointmentSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _appointmentSelections.contains(index);

  /// Takes a list of [Appointment]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<Appointment> appointments) {
    final updatedSet = <int>{};
    for (var i = 0; i < appointments.length; i += 1) {
      var appointment = appointments[i];
      if (appointment.selected) {
        updatedSet.add(i);
      }
    }
    _appointmentSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _appointmentSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _appointmentSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _appointmentSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _appointmentSelections = value;
  }

  @override
  Object toPrimitives() => _appointmentSelections.toList();
}

int _idCounter = 0;

/// Domain model entity
class Appointment {
  Appointment(
    this.appId,
    this.date,
    this.schedule,
    this.doctor,
    this.patient,
    this.status,
  );

  final int id = _idCounter++;

  final int appId;
  final String date;
  final String schedule;
  final String doctor;
  final String patient;
  final String status;
  bool selected = false;
}

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class AppointmentDataSource extends DataTableSource {
  AppointmentDataSource.empty(this.context) {
    appointments = [];
  }

  AppointmentDataSource(this.context,
      [sortedByDate = false,
      this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]) {
    appointments = _appointments;
    if (sortedByDate) {
      sort((d) => d.date, true);
    }
  }

  final BuildContext context;
  late List<Appointment> appointments;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(Appointment d) getField, bool ascending) {
    appointments.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void updateSelectedAppointments(
      RestorableAppointmentSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < appointments.length; i += 1) {
      var appointment = appointments[i];
      if (selectedRows.isSelected(i)) {
        appointment.selected = true;
        _selectedCount += 1;
      } else {
        appointment.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= appointments.length) throw 'index > _appointments.length';
    final appointment = appointments[index];
    return DataRow2.byIndex(
      index: index,
      selected: appointment.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onSelectChanged: (value) {
        if (appointment.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          appointment.selected = value;
          notifyListeners();
        }
      },
      onTap: hasRowTaps
          ? () => _showSnackbar(context, 'Tapped on row ${appointment.appId}')
          : null,
      onDoubleTap: hasRowTaps
          ? () => _showSnackbar(
              context, 'Double Tapped on row ${appointment.appId}')
          : null,
      onLongPress: hasRowTaps
          ? () =>
              _showSnackbar(context, 'Long pressed on row ${appointment.appId}')
          : null,
      onSecondaryTap: hasRowTaps
          ? () => _showSnackbar(
              context, 'Right clicked on row ${appointment.appId}')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) => _showSnackbar(
              context, 'Right button down on row ${appointment.appId}')
          : null,
      specificRowHeight:
          hasRowHeightOverrides && appointment.patient.length >= 25
              ? 100
              : null,
      cells: [
        DataCell(Text(appointment.appId.toStringAsFixed(1))),
        DataCell(Text('${appointment.date}'),
            onTap: () => _showSnackbar(context,
                'Tapped on a cell with "${appointment.date}"', Colors.red)),
        DataCell(Text(appointment.schedule)),
        DataCell(Text('${appointment.doctor}')),
        DataCell(Text(appointment.patient)),
        DataCell(Text('${appointment.status}')),
      ],
    );
  }

  @override
  int get rowCount => appointments.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final appointment in appointments) {
      appointment.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? appointments.length : 0;
    notifyListeners();
  }
}

/// Async datasource for AsynPaginatedDataTabke2 example. Based on AsyncDataTableSource which
/// is an extension to FLutter's DataTableSource and aimed at solving
/// saync data fetching scenarious by paginated table (such as using Web API)
class AppointmentDataSourceAsync extends AsyncDataTableSource {
  AppointmentDataSourceAsync() {
    print('AppointmentDataSourceAsync created');
  }

  AppointmentDataSourceAsync.empty() {
    _empty = true;
    print('AppointmentDataSourceAsync.empty created');
  }

  AppointmentDataSourceAsync.error() {
    _errorCounter = 0;
    print('AppointmentDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _datesFilter;

  RangeValues? get datesFilter => _datesFilter;
  set datesFilter(RangeValues? date) {
    _datesFilter = date;
    refreshDatasource();
  }

  final AppointmentsFakeWebService _repo = AppointmentsFakeWebService();

  String _sortColumn = "name";
  bool _sortAscending = true;

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }

  Future<int> getTotalRecords() {
    return Future<int>.delayed(const Duration(milliseconds: 0),
        () => _empty ? 0 : _appointmentsX3.length);
  }

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    print('getRows($startIndex, $count)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(startIndex >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var x = _empty
        ? await Future.delayed(const Duration(milliseconds: 2000),
            () => AppointmentsFakeWebServiceResponse(0, []))
        : await _repo.getData(
            startIndex, count, datesFilter, _sortColumn, _sortAscending);

    var r = AsyncRowsResponse(
        x.totalRecords,
        x.data.map((appointment) {
          return DataRow(
            key: ValueKey<int>(appointment.id),
            selected: appointment.selected,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(ValueKey<int>(appointment.id), value);
              }
            },
            cells: [
              DataCell(Text(appointment.appId.toStringAsFixed(1))),
              DataCell(Text(appointment.date)),
              DataCell(Text(appointment.schedule)),
              DataCell(Text(appointment.doctor)),
              DataCell(Text(appointment.patient)),
              DataCell(Text(appointment.status)),
            ],
          );
        }).toList());

    return r;
  }
}

class AppointmentsFakeWebServiceResponse {
  AppointmentsFakeWebServiceResponse(this.totalRecords, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int totalRecords;

  /// One page, e.g. 10 reocrds
  final List<Appointment> data;
}

class AppointmentsFakeWebService {
  int Function(Appointment, Appointment)? _getComparisonFunction(
      String column, bool ascending) {
    var coef = ascending ? 1 : -1;
    switch (column) {
      case 'id':
        return (Appointment d1, Appointment d2) =>
            coef * d1.appId.compareTo(d2.appId);
      case 'date':
        return (Appointment d1, Appointment d2) =>
            coef * d1.date.compareTo(d2.date);
      case 'schedule':
        return (Appointment d1, Appointment d2) =>
            coef * d1.schedule.compareTo(d2.schedule);
      case 'doctor':
        return (Appointment d1, Appointment d2) =>
            coef * d1.doctor.compareTo(d2.doctor);
      case 'patient':
        return (Appointment d1, Appointment d2) =>
            coef * d1.patient.compareTo(d2.patient);
      case 'status':
        return (Appointment d1, Appointment d2) =>
            coef * d1.status.compareTo(d2.status);
    }

    return null;
  }

  Future<AppointmentsFakeWebServiceResponse> getData(int startingAt, int count,
      RangeValues? datesFilter, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
        Duration(
            milliseconds: startingAt == 0
                ? 2650
                : startingAt < 20
                    ? 2000
                    : 400), () {
      var result = _appointmentsX3;

      if (datesFilter != null) {
        // result = result
        //     .where(
        //         (e) => e.date >= datesFilter.start && e.date <= datesFilter.end)
        //     .toList();
      }

      result.sort(_getComparisonFunction(sortedBy, sortedAsc));
      return AppointmentsFakeWebServiceResponse(
          result.length, result.skip(startingAt).take(count).toList());
    });
  }
}

int _selectedCount = 0;

List<Appointment> _appointments = <Appointment>[
  Appointment(
    001,
    '20220715',
    '09:00-10:00',
    'John Hughes',
    'Jane Doe',
    'BOOKED',
  ),
  Appointment(
    002,
    '20220715',
    '10:00-11:00',
    'John Hughes',
    'Jane Doe',
    'BOOKED',
  ),
  Appointment(
    003,
    '20220715',
    '11:00-12:00',
    'John Hughes',
    'Jane Doe',
    'BOOKED',
  ),
  Appointment(
    004,
    '20220715',
    '1:00-2:00',
    'John Hughes',
    'John Doe',
    'BOOKED',
  ),
  Appointment(
    005,
    '20231016',
    '1:00-2:00',
    'John Hughes',
    'Amari Doe',
    'BOOKED',
  ),
  Appointment(
    006,
    '20231017',
    '1:00-2:00',
    'John Hughes',
    'Kim K',
    'BOOKED',
  ),
];

List<Appointment> _appointmentsX3 = _appointments.toList()
  ..addAll(_appointments.map((i) =>
      Appointment(i.appId, i.date, i.schedule, i.doctor, i.patient, i.status)))
  ..addAll(_appointments.map((i) =>
      Appointment(i.appId, i.date, i.schedule, i.doctor, i.patient, i.status)));

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
