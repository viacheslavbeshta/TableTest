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
      List<VlorishDataGridCell> categoryCells = [
        VlorishDataGridCell<String>(
            columnName: 'category',
            value: 'CATEGORY ${category.id}',
            categoryId: category.id,
            subcategoryId: '',
            monthId: '0'),
        VlorishDataGridCell<int>(
            columnName: jbKey,
            value: category.yearData[0].budget,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '0'),
        VlorishDataGridCell<int>(
            columnName: jaKey,
            value: category.yearData[0].actual,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '0'),
        VlorishDataGridCell<int>(
            columnName: jdKey,
            value: category.yearData[0].diff,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '0'),
        VlorishDataGridCell<int>(
            columnName: fbKey,
            value: category.yearData[1].budget,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '1'),
        VlorishDataGridCell<int>(
            columnName: faKey,
            value: category.yearData[1].actual,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '1'),
        VlorishDataGridCell<int>(
            columnName: fdKey,
            value: category.yearData[1].diff,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '1'),
        VlorishDataGridCell<int>(
            columnName: mbKey,
            value: category.yearData[2].budget,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '2'),
        VlorishDataGridCell<int>(
            columnName: maKey,
            value: category.yearData[2].actual,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '2'),
        VlorishDataGridCell<int>(
            columnName: mdKey,
            value: category.yearData[2].diff,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '2'),
        VlorishDataGridCell<int>(
            columnName: 'YEAR',
            value: category.yearData.first.diff,
            categoryId: category.id,
            subcategoryId: '',
            monthId: 'year'),
        VlorishDataGridCell<int>(
            columnName: '%',
            value: category.yearData.first.diff ~/ 100,
            categoryId: category.id,
            subcategoryId: '',
            monthId: '%'),
      ];

      categoriesDataGridRows.add(DataGridRow(cells: categoryCells));
      if (unexpadedCategories.contains('CATEGORY ${category.id}')) continue;

      for (var sub in category.subCategories) {
        // if (hiddenSubcategories.contains('${sub.category} ${category.id}${sub.id}'))
        //   continue; //TODO: remove subcategories feature 1

        var subcategoryCells = [
          VlorishDataGridCell<String>(
              columnName: 'category', value: sub.category, categoryId: category.id, subcategoryId: sub.id, monthId: ''),
          VlorishDataGridCell<int>(
              columnName: jbKey,
              value: sub.yearData[0].budget,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '0'),
          VlorishDataGridCell<int>(
              columnName: jaKey,
              value: sub.yearData[0].actual,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '0'),
          VlorishDataGridCell<int>(
              columnName: jdKey,
              value: sub.yearData[0].diff,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '0'),
          VlorishDataGridCell<int>(
              columnName: fbKey,
              value: sub.yearData[1].budget,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '1'),
          VlorishDataGridCell<int>(
              columnName: faKey,
              value: sub.yearData[1].actual,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '1'),
          VlorishDataGridCell<int>(
              columnName: fdKey,
              value: sub.yearData[1].diff,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '1'),
          VlorishDataGridCell<int>(
              columnName: mbKey,
              value: sub.yearData[2].budget,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '2'),
          VlorishDataGridCell<int>(
              columnName: maKey,
              value: sub.yearData[2].actual,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '2'),
          VlorishDataGridCell<int>(
              columnName: mdKey,
              value: sub.yearData[2].diff,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '2'),
          VlorishDataGridCell<int>(
              columnName: 'YEAR',
              value: category.yearData.first.diff,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: 'YEAR'),
          VlorishDataGridCell<int>(
              columnName: '%',
              value: category.yearData.first.diff ~/ 100,
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: '%'),
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
              print(dataGridCell.columnName);
              (dataGridCell as VlorishDataGridCell);
              print('categoryId: ${dataGridCell.categoryId}');
              print('subcategoryId: ${dataGridCell.subcategoryId}');

              categoriesList[int.parse((dataGridCell).categoryId)]
                  .subCategories
                  .removeWhere((subcategory)=>dataGridCell.subcategoryId==subcategory.id);
              //TODO: remove subcategories feature 2
              updateTable();
              print('------------------------------');
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

    var editCell = dataGridRows[rowColumnIndex.rowIndex].getCells()[rowColumnIndex.columnIndex];
    print(editCell.runtimeType);

    /// change value in cell
    dataGridRows[rowColumnIndex.rowIndex].getCells()[rowColumnIndex.columnIndex] =
        (editCell as VlorishDataGridCell).copyWith(newCellValue as int);

    const actualWord = "Actual";
    const budgetWord = "Budget";
    const diffWord = "Difference";

    var isActualColumn = editCell.columnName.contains(actualWord);
    var isBudgetColumn = editCell.columnName.contains(budgetWord);
    var isDifferenceColumn = editCell.columnName.contains(diffWord);

    var cellInData = categoriesList
        .firstWhere((category) => category.id == editCell.categoryId)
        .subCategories
        .firstWhere((subcategory) => subcategory.id == editCell.subcategoryId)
        .yearData
        .firstWhere((month) => month.id == editCell.monthId);

    var catIndex = categoriesList.indexOf(categoriesList.firstWhere((category) => category.id == editCell.categoryId));

    var subCatIndex = categoriesList[catIndex].subCategories.indexOf(
        categoriesList[catIndex].subCategories.firstWhere((subcategory) => subcategory.id == editCell.subcategoryId));

    var monthIndex = categoriesList[catIndex].subCategories[subCatIndex].yearData.indexOf(cellInData);

    print(cellInData.toString());
    print('catIndex: $catIndex');
    print('subCatIndex: $subCatIndex');
    print('monthIndex: $monthIndex');

    /// Save the new cell value to model collection also.
    if (isActualColumn) {
      cellInData = cellInData.copyWith(newActual: newCellValue);
      categoriesList[catIndex].subCategories[subCatIndex].yearData[monthIndex] = categoriesList[subCatIndex]
          .subCategories[subCatIndex]
          .yearData[catIndex]
          .copyWith(newActual: newCellValue as int);
    }
    if (isBudgetColumn) {
      categoriesList[catIndex].subCategories[subCatIndex].yearData[monthIndex] = categoriesList[subCatIndex]
          .subCategories[subCatIndex]
          .yearData[catIndex]
          .copyWith(newBudget: newCellValue as int);
    }
    if (isDifferenceColumn) {
      categoriesList[catIndex].subCategories[subCatIndex].yearData[monthIndex] = categoriesList[subCatIndex]
          .subCategories[subCatIndex]
          .yearData[catIndex]
          .copyWith(newDiff: newCellValue as int);
    }
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
