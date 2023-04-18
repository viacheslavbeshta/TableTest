import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'datasource.dart';
import 'employee.dart';

class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employees);
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
              child: SfDataGrid(
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
                      columnNames: ['name', 'designation', 'salary'],
                      child: Container(
                        color: const Color(0xFFF1F1F1),
                        child: const Center(
                          child: Text('January'),
                        ),
                      ),
                    ),
                    StackedHeaderCell(
                      columnNames: ['name1', 'designation1', 'salary1'],
                      child: Container(
                        color: const Color(0xFFF1F1F1),
                        child: const Center(
                          child: Text('February'),
                        ),
                      ),
                    ),
                    StackedHeaderCell(
                      columnNames: ['name2', 'designation2', 'salary2'],
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
                      columnName: 'id',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'CATEGORY',
                          ))),
                  GridColumn(
                    visible: showBudget,
                    columnName: 'name',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('BUDGET'),
                    ),
                  ),
                  GridColumn(
                    visible: showActual,
                    columnName: 'designation',
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
                    columnName: 'salary',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DIFFERENCE'),
                    ),
                  ),
                  GridColumn(
                    visible: showBudget,
                    columnName: 'name1',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('BUDGET'),
                    ),
                  ),
                  GridColumn(
                    visible: showActual,
                    columnName: 'designation1',
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
                    columnName: 'salary1',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('DIFFERENCE'),
                    ),
                  ),
                  GridColumn(
                    visible: showBudget,
                    columnName: 'name2',
                    label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('BUDGET'),
                    ),
                  ),
                  GridColumn(
                    visible: showActual,
                    columnName: 'designation2',
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
                    columnName: 'salary2',
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
                },
                // onCellDoubleTap: (DataGridCellDoubleTapDetails details){
                //   if(details.column.columnName=='id') {
                //    employeeDataSource.rows.removeAt(details.rowColumnIndex.rowIndex);
                //   }
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  List<Employee> getEmployeeData() => [
        Employee(10001, 'James', 'Project Lead', 10000),
        Employee(10002, 'Kathryn', 'Manager', 20000),
        Employee(10003, 'Lara', 'Developer', 3000),
        Employee(10004, 'Michael', 'Designer', 4000),
        Employee(10005, 'Martin', 'Developer', 5000),
        Employee(10006, 'Newberry', 'Developer', 6000),
        Employee(10007, 'Balnc', 'Developer', 7000),
        Employee(10008, 'Perry', 'Developer', 8000),
        Employee(10009, 'Gable', 'Developer', 9000),
        Employee(10010, 'Grimes', 'Developer', 10000),
        Employee(10011, 'Grimes', 'Developer', 11000),
        Employee(10012, 'James', 'Project Lead', 12000),
        Employee(10013, 'Kathryn', 'Manager', 13000),
        Employee(10014, 'Lara', 'Developer', 14000),
        Employee(10015, 'Michael', 'Designer', 15000),
        Employee(10016, 'Martin', 'Developer', 16000),
        Employee(10017, 'Newberry', 'Developer', 17000),
        Employee(10018, 'Balnc', 'Developer', 18000),
        Employee(10019, 'Perry', 'Developer', 19000),
        Employee(10020, 'Gable', 'Developer', 20000),
        Employee(10021, 'Grimes', 'Developer', 21000),
      ];
}
