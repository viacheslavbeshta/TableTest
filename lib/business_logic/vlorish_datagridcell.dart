import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VlorishDataGridCell<T> extends DataGridCell<T> {
  VlorishDataGridCell({
    required super.columnName,
    required super.value,
    required this.categoryId,
    required this.subcategoryId,
    required this.monthId,
  });

  final String categoryId;
  final String subcategoryId;
  final String monthId;

  VlorishDataGridCell copyWith(T newValue) {
    return VlorishDataGridCell<T>(
        columnName: columnName,
        value: newValue,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        monthId: monthId);
  }

  @override
  String toString() {
    return 'VlorishDataGridCell{categoryId: $categoryId, subcategoryId: $subcategoryId, monthId: $monthId, columnName: $columnName, value: $value}';
  }
}
