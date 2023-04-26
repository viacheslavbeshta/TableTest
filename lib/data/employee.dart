import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tabletest/widgets/table_layout.dart';

class MonthData {
  final int budget;
  final int actual;
  final int diff;

  MonthData(
    this.budget,
    this.actual,
    this.diff,
  );
}

class RegularRow {
  final List<MonthData> yearData;
  final String category;
  final String id;

  const RegularRow(this.yearData, this.category, this.id);
}

class SubCategory extends RegularRow {
  SubCategory(super.yearData, super.category, super.id);
}

class Category extends RegularRow {
  const Category(super.yearData, super.category, super.id, this.subCategories);

  final List<SubCategory> subCategories;

    /// columnName: |        jbKey       |     jaKey         | ...
    /// value:      | yearData[0].budget | yearData[0].actual|...

  // DataGridRow getDataGridRow() => DataGridRow(cells: [
  //       DataGridCell<String>(columnName: 'category', value: id),
  //       DataGridCell<int>(columnName: jbKey, value: yearData[0].budget),
  //       DataGridCell<int>(columnName: jaKey, value: yearData[0].actual),
  //       DataGridCell<int>(columnName: jdKey, value: yearData[0].diff),
  //       DataGridCell<int>(columnName: fbKey, value: yearData[1].budget),
  //       DataGridCell<int>(columnName: faKey, value: yearData[1].actual),
  //       DataGridCell<int>(columnName: fdKey, value: yearData[1].diff),
  //       DataGridCell<int>(columnName: mbKey, value: yearData[2].budget),
  //       DataGridCell<int>(columnName: maKey, value: yearData[2].actual),
  //       DataGridCell<int>(columnName: mdKey, value: yearData[2].diff),
  //       DataGridCell<int>(columnName: 'YEAR', value: yearData.first.diff),
  //       DataGridCell<int>(columnName: '%', value: yearData.first.diff ~/ 1000),
  //     ]);
}

class TableData {
  final List<Category> categories;

  TableData(this.categories);
}