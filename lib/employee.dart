import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);

  ///
  final int id;

  ///
  String name;

  ///
  String designation;

  ///
  int salary;

  DataGridRow getDataGridRow() => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'id', value: 'CATEGORY $id'),//TODO: category column
      DataGridCell<int>(columnName: 'name', value: salary),//TODO: redo names for better reading
      DataGridCell<int>(columnName: 'designation', value: salary),
      DataGridCell<int>(columnName: 'salary', value: salary),
      DataGridCell<int>(columnName: 'name1', value: salary),
      DataGridCell<int>(columnName: 'designation1', value: salary),
      DataGridCell<int>(columnName: 'salary1', value: salary),
      DataGridCell<int>(columnName: 'name2', value: salary),
      DataGridCell<int>(columnName: 'designation2', value: salary),
      DataGridCell<int>(columnName: 'salary2', value: salary),
      DataGridCell<int>(columnName: 'YEAR', value: id),
      DataGridCell<int>(columnName: '%', value: id),
    ]);
}