import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tabletest/table_screen.dart';

class Employee {
  Employee(this.id, this.salary);

  ///
  final int id;

  ///
  int salary;

  DataGridRow getDataGridRow() => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'category', value: 'CATEGORY $id'),
        DataGridCell<int>(columnName: jbKey, value: salary),
        DataGridCell<int>(columnName: jaKey, value: salary),
        DataGridCell<int>(columnName: jdKey, value: salary),
        DataGridCell<int>(columnName: fbKey, value: salary),
        DataGridCell<int>(columnName: faKey, value: salary),
        DataGridCell<int>(columnName: fdKey, value: salary),
        DataGridCell<int>(columnName: mbKey, value: salary),
        DataGridCell<int>(columnName: maKey, value: salary),
        DataGridCell<int>(columnName: mdKey, value: salary),
        DataGridCell<int>(columnName: 'YEAR', value: id),
        DataGridCell<int>(columnName: '%', value: id),
      ]);
}
