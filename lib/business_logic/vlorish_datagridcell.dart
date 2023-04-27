import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VlorishDataGridCell extends DataGridCell {
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

}
