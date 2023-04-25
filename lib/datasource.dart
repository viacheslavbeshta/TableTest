import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tabletest/table_screen.dart';

import 'cell_widgets.dart';
import 'employee.dart';

class SFDataSource extends DataGridSource {
  SFDataSource(this._categoriesData);

  final TableData _categoriesData;

  late final dataGridRows = _categoriesData.categories;

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();
  List<String> unexpadedCategories = [];
  List<String> hiddenSubcategories = [];

  List<DataGridRow> getDataGridRows(List<Category> categories) {
    List<DataGridRow> dataGridRows = [];

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
      dataGridRows.add(DataGridRow(cells: categoryCells));
      if (unexpadedCategories.contains('CATEGORY ${category.id}')) continue;

      for (var sub in category.subCategories) {
        if(hiddenSubcategories.contains('${sub.category} ${category.id}${sub.id}')) continue;
        var cells = [
          DataGridCell<String>(columnName: 'category', value: '${sub.category} ${category.id}${sub.id}'),
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
        dataGridRows.add(DataGridRow(cells: cells));
      }
    }
    return dataGridRows;
  }

  @override
  List<DataGridRow> get rows => getDataGridRows(dataGridRows);

  void updateDataGridSource() => notifyListeners();

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
              updateDataGridSource();
            },
          ),
        );
        continue;
      }
      if (dataGridCell.columnName == 'category') {
        cells.add(CategoryCell(
          value: dataGridCell.value.toString(),
          onDoubleTap: () {
            if (hiddenSubcategories.contains(list.first.value.toString())) {
              hiddenSubcategories.remove(list.first.value.toString());
            } else {
              hiddenSubcategories.add(list.first.value.toString());
            }
            print('hiddenSubcategories');
            print(hiddenSubcategories);
            updateDataGridSource();
          },
        ));
        continue;
      }
      cells.add(PreviewCell(value: dataGridCell.value.toString()));
    }

    return DataGridRowAdapter(cells: cells);
  }

  // @override
  // Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
  //   final dynamic oldValue = dataGridRow
  //           .getCells()
  //           .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
  //           ?.value ??
  //       '';
  //
  //   final int dataRowIndex = dataGridRows.indexOf(dataGridRow);
  //
  //   if (newCellValue == null || oldValue == newCellValue) {
  //     return Future<void>.value();
  //   }
  //
  //   if (column.columnName == 'name') {
  //     dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<int>(columnName: 'name', value: newCellValue);
  //     _employees[dataRowIndex].salary = newCellValue as int;
  //   } else if (column.columnName == 'designation') {
  //     dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<int>(columnName: 'designation', value: newCellValue);
  //     _employees[dataRowIndex].salary = newCellValue as int;
  //   } else {
  //     dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<int>(columnName: 'salary', value: newCellValue);
  //     _employees[dataRowIndex].salary = newCellValue as int;
  //   }
  // }

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
}
