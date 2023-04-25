import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'datasource.dart';
import 'employee.dart';

const jbKey = 'januaryBudget';
const jaKey = 'januaryActual';
const jdKey = 'januaryDifference';

const fbKey = 'februaryBudget';
const faKey = 'februaryActual';
const fdKey = 'februaryDifference';

const mbKey = 'marchBudget';
const maKey = 'marchActual';
const mdKey = 'marchDifference';

class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employees);
  }

  @override
  void didChangeDependencies() {
    employeeDataSource = EmployeeDataSource(employees);
    super.didChangeDependencies();
  }

  var showDiff = true;
  var showActual = true;
  var showBudget = false;
  var scroll = const ScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(value: showBudget, onChanged: (value) => setState(() => showBudget = !showBudget)),
              const Text('budget'),
              Checkbox(value: showActual, onChanged: (value) => setState(() => showActual = !showActual)),
              const Text('actual'),
              Checkbox(value: showDiff, onChanged: (value) => setState(() => showDiff = !showDiff)),
              const Text('difference')
            ],
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }, physics: const ScrollPhysics().applyTo(const ClampingScrollPhysics())),
              child: Builder(builder: (context) {
                return SfDataGrid(
                  navigationMode: GridNavigationMode.cell,
                  allowEditing: true,
                  editingGestureType: EditingGestureType.doubleTap,
                  selectionMode: SelectionMode.single,
                  source: employeeDataSource,
                  columnWidthMode: ColumnWidthMode.none,
                  frozenColumnsCount: 1,
                  isScrollbarAlwaysShown: true,
                  defaultColumnWidth: 150,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  stackedHeaderRows: <StackedHeaderRow>[
                    StackedHeaderRow(cells: [
                      StackedHeaderCell(
                        columnNames: [jbKey, jaKey, jdKey],
                        child: Container(
                          color: const Color(0xFFF1F1F1),
                          child: const Center(
                            child: Text('January'),
                          ),
                        ),
                      ),
                      StackedHeaderCell(
                        columnNames: [fbKey, faKey, fdKey],
                        child: Container(
                          color: const Color(0xFFF1F1F1),
                          child: const Center(
                            child: Text('February'),
                          ),
                        ),
                      ),
                      StackedHeaderCell(
                        columnNames: [mbKey, maKey, mdKey],
                        child: Container(
                          color: const Color(0xFFF1F1F1),
                          child: const Center(
                            child: Text('March'),
                          ),
                        ),
                      ),
                    ])
                  ],
                  columns: <GridColumn>[
                    GridColumn(
                      allowEditing: false,
                      columnName: 'category',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'CATEGORY',
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showBudget,
                      columnName: jbKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('BUDGET'),
                      ),
                    ),
                    GridColumn(
                      visible: showActual,
                      columnName: jaKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ACTUAL',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showDiff,
                      columnName: jdKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('DIFFERENCE'),
                      ),
                    ),
                    GridColumn(
                      visible: showBudget,
                      columnName: fbKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('BUDGET'),
                      ),
                    ),
                    GridColumn(
                      visible: showActual,
                      columnName: faKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ACTUAL',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showDiff,
                      columnName: fdKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('DIFFERENCE'),
                      ),
                    ),
                    GridColumn(
                      visible: showBudget,
                      columnName: mbKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('BUDGET'),
                      ),
                    ),
                    GridColumn(
                      visible: showActual,
                      columnName: maKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ACTUAL',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showDiff,
                      columnName: mdKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('DIFFERENCE'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'YEAR',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('YEAR'),
                      ),
                    ),
                    GridColumn(
                      columnName: '%',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('%'),
                      ),
                    ),
                  ],
                  onCellTap: (DataGridCellTapDetails details) {
                    print(details.column.columnName);
                    print(details.column.label);
                    print(details.rowColumnIndex);
                    print(details.kind);
                    if (details.rowColumnIndex.rowIndex == 0 && details.rowColumnIndex.columnIndex == 0) {
                      employeeDataSource.isFirstCategoryShown = !employeeDataSource.isFirstCategoryShown;
                      employeeDataSource.updateDataGridSource();
                    }
                    if (details.rowColumnIndex.rowIndex == 9 && details.rowColumnIndex.columnIndex == 0) {
                      employeeDataSource.isSecondCategoryShown = !employeeDataSource.isSecondCategoryShown;
                      employeeDataSource.updateDataGridSource();
                    }
                    //rows == widgets
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  //
  List<Employee> getEmployeeData() => [
        Employee(10001, 10000),
        Employee(10002, 20000),
        Employee(10003, 3000),
        Employee(10004, 4000),
        Employee(10005, 5000),
        Employee(10006, 6000),
        Employee(10007, 7000),
        Employee(10008, 8000),
        Employee(10009, 9000),
        Employee(10010, 10000),
        Employee(10011, 11000),
        Employee(10012, 12000),
        Employee(10013, 13000),
        Employee(10014, 14000),
        Employee(10015, 15000),
        Employee(10016, 16000),
        Employee(10017, 17000),
        Employee(10018, 18000),
        Employee(10019, 19000),
        Employee(10020, 20000),
        Employee(10021, 21000),
      ];
}
