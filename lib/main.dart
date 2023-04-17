import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

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
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  var showDiff = true;
  var showActual = true;
  var showBudget = false;

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
              const Text('Difference')
            ],
          ),
          Expanded(
            child: SfDataGrid(
              navigationMode: GridNavigationMode.cell,
              allowEditing: true,
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
            ),
          ),
        ],
      ),
    );
  }

  //
  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }
}

//
/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);
  //
  /// Id of an employee.
  final int id;
  //
  /// Name of an employee.
  final String name;
  //
  /// Designation of an employee.
  final String designation;
  //
  /// Salary of an employee.
  final int salary;
}

//
/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'CATEGORY', value: 'CATEGORY ${e.id}'),
              DataGridCell<int>(columnName: 'Budget', value: e.salary),
              DataGridCell<int>(columnName: 'Actual', value: e.salary),
              DataGridCell<int>(columnName: 'Difference', value: e.salary),
              DataGridCell<int>(columnName: 'Budget', value: e.salary),
              DataGridCell<int>(columnName: 'Actual', value: e.salary),
              DataGridCell<int>(columnName: 'Difference', value: e.salary),
              DataGridCell<int>(columnName: 'Budget', value: e.salary),
              DataGridCell<int>(columnName: 'Actual', value: e.salary),
              DataGridCell<int>(columnName: 'Difference', value: e.salary),
              DataGridCell<int>(columnName: 'YEAR', value: e.id),
              DataGridCell<int>(columnName: '%', value: e.id),
            ]))
        .toList();
  }
  //
  List<DataGridRow> _employeeData = [];
  //
  @override
  List<DataGridRow> get rows => _employeeData;
  //
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'CATEGORY') {
        return GestureDetector(
            onDoubleTap: () {
              _employeeData.remove(row);
              updateDataGridSource();
            },
            child: Text(dataGridCell.value.toString()));
      } else if (dataGridCell.columnName != 'Budget') {
        return Container(alignment: Alignment.center, child: Text(dataGridCell.value.toString()));
      } else {
        var controller = TextEditingController(text: '0');

        return TextField(
          onChanged: (value) {},
          controller: controller,
          textAlign: TextAlign.center,
        );
      }
    }).toList());
  }

  void updateDataGridSource() => notifyListeners();
}
