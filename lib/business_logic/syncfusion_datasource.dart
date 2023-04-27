import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tabletest/business_logic/vlorish_datagridcell.dart';
import 'package:tabletest/widgets/table_layout.dart';

import '../widgets/cell_widgets.dart';
import '../data/employee.dart';

class SFDataSource extends DataGridSource {
  SFDataSource(this._tableData);

  final TableData _tableData;

  late List<Category> categoriesList = _tableData.categories;

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  late List<DataGridRow> dataGridRows = getDataGridRows(categoriesList);

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();
  List<String> unexpadedCategories = [];

  List<DataGridRow> getDataGridRows(List<Category> categories) {
    List<DataGridRow> categoriesDataGridRows = [];

    for (var category in categories) {
      List<DataGridCell> categoryCells = [
        DataGridCell<String>(columnName: 'category', value: 'CATEGORY ${category.id}'),
        DataGridCell<int>(columnName: jbKey, value: category.yearData[0].budget),
        DataGridCell<int>(columnName: jaKey, value: category.yearData[0].actual),
        DataGridCell<int>(columnName: jdKey, value: category.yearData[0].diff),
        DataGridCell<int>(columnName: fbKey, value: category.yearData[1].budget),
        DataGridCell<int>(columnName: faKey, value: category.yearData[1].actual),
        DataGridCell<int>(columnName: fdKey, value: category.yearData[1].diff),
        DataGridCell<int>(columnName: mbKey, value: category.yearData[2].budget),
        DataGridCell<int>(columnName: maKey, value: category.yearData[2].actual),
        DataGridCell<int>(columnName: mdKey, value: category.yearData[2].diff),
        DataGridCell<int>(columnName: 'YEAR', value: category.yearData.first.diff),
        DataGridCell<int>(columnName: '%', value: category.yearData.first.diff ~/ 100),
      ];

      categoriesDataGridRows.add(DataGridRow(cells: categoryCells));
      if (unexpadedCategories.contains('CATEGORY ${category.id}')) continue;

      for (var sub in category.subCategories) {
        // if (hiddenSubcategories.contains('${sub.category} ${category.id}${sub.id}'))
        //   continue; //TODO: remove subcategories feature 1

        var subcategoryCells = [
          DataGridCell<String>(columnName: 'category', value: sub.category),
          DataGridCell<int>(columnName: jbKey, value: sub.yearData[0].budget),
          DataGridCell<int>(columnName: jaKey, value: sub.yearData[0].actual),
          DataGridCell<int>(columnName: jdKey, value: sub.yearData[0].diff),
          DataGridCell<int>(columnName: fbKey, value: sub.yearData[1].budget),
          DataGridCell<int>(columnName: faKey, value: sub.yearData[1].actual),
          DataGridCell<int>(columnName: fdKey, value: sub.yearData[1].diff),
          DataGridCell<int>(columnName: mbKey, value: sub.yearData[2].budget),
          DataGridCell<int>(columnName: maKey, value: sub.yearData[2].actual),
          DataGridCell<int>(columnName: mdKey, value: sub.yearData[2].diff),
          DataGridCell<int>(columnName: 'YEAR', value: category.yearData.first.diff),
          DataGridCell<int>(columnName: '%', value: category.yearData.first.diff ~/ 100),
        ];
        categoriesDataGridRows.add(DataGridRow(cells: subcategoryCells));
      }
    }
    return categoriesDataGridRows;
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void updateTable() {
    dataGridRows = getDataGridRows(categoriesList);
    updateDataGridSource();
  }

  ///func for building row (set widget for cell)
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final cells = <Widget>[];
    final list = row.getCells();

    for (var i = 0; i < list.length; i++) {
      final dataGridCell = list[i];
      if (dataGridCell.columnName == 'category' && list.first.value.toString().startsWith('CATEGORY')) {
        //todo: row index
        cells.add(
          ToggleCell(
            value: dataGridCell.value.toString(),
            onCheckboxToggled: (value) {
              if (unexpadedCategories.contains(list.first.value.toString())) {
                unexpadedCategories.remove(list.first.value.toString());
              } else {
                unexpadedCategories.add(list.first.value.toString());
              }
              updateTable();
            },
          ),
        );
        continue;
      }
      if (dataGridCell.columnName == 'category') {
        cells.add(
          CategoryCell(
            value: dataGridCell.value.toString(),
            onDoubleTap: () {
              //TODO: remove subcategories feature 2
            },
          ),
        );
        continue;
      }
      cells.add(PreviewCell(value: dataGridCell.value.toString()));
    }

    return DataGridRowAdapter(cells: cells);
  }

  //
  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
    final cells = dataGridRow.getCells();

    ///find the old cell value from row
    final dynamic oldCellValue =
        cells.firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)?.value ??
            '';

    print('old value: $oldCellValue');
    // print('dataGridRow: ${dataGridRow.getCells().toString()}');

    print('rowIndex: ${rowColumnIndex.rowIndex}, columnIndex: ${rowColumnIndex.columnIndex}');

    ///find row index from getDataGridRows or rows
    print('row contains in rows: ${rows.contains(dataGridRow)}');
    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);
    print(dataRowIndex);
    //TODO: index not found

    if (newCellValue == null || oldCellValue == newCellValue) {
      return Future<void>.value();
    }

    /// change value in cell
    dataGridRows[rowColumnIndex.rowIndex].getCells()[rowColumnIndex.columnIndex] =
        DataGridCell<int>(columnName: column.columnName, value: newCellValue);

    print(cells.first.value);

    /// Save the new cell value to model collection also.
    ///

    // categoriesList = newCellValue as int;
    // dataGridRows[].category[] = newCellValue as int; //TODO: change value in object
  }

  @override
  Future<bool> canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(
      DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    const bool isNumericType = true;

    // Holds regular expression pattern based on the column type.
    final RegExp regExp = _getRegExp(isNumericType, column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerRight,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.right,
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(regExp)],
        // keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          print('onChanged $value');
          if (value.isNotEmpty) {
            newCellValue = int.parse(value);
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          print('onSubmitted $value');

          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  }

  void updateDataGridSource() => notifyListeners();
}
