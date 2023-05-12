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
            columnName: ybKey,
            value: category.rowBudgetSum(),
            categoryId: category.id,
            subcategoryId: '',
            monthId: 'year'),
        VlorishDataGridCell<int>(
            columnName: yaKey,
            value: category.rowActualSum(),
            categoryId: category.id,
            subcategoryId: '',
            monthId: 'year'),
        VlorishDataGridCell<int>(
            columnName: ydKey,
            value: category.rowDiffSum(),
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
              columnName: ybKey,
              value: sub.rowBudgetSum(),
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: 'year'),
          VlorishDataGridCell<int>(
              columnName: yaKey,
              value: sub.rowActualSum(),
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: 'year'),
          VlorishDataGridCell<int>(
              columnName: ydKey,
              value: sub.rowDiffSum(),
              categoryId: category.id,
              subcategoryId: sub.id,
              monthId: 'year'),
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
    updateTableView();
  }

  ///func for building row (set widget for cell)
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    print('buildRow');
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
              categoriesList[int.parse((dataGridCell as VlorishDataGridCell).categoryId)]
                  .subCategories
                  .removeWhere((subcategory) => dataGridCell.subcategoryId == subcategory.id);
              updateTable();
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
    const actualWord = "Actual";
    const budgetWord = "Budget";

    var editCell = dataGridRows[rowColumnIndex.rowIndex].getCells()[rowColumnIndex.columnIndex] as VlorishDataGridCell;

    var isActualColumn = editCell.columnName.contains(actualWord);
    var isBudgetColumn = editCell.columnName.contains(budgetWord);

    ///find the old cell value from row
    final oldCellValue = editCell.value;

    if (newCellValue == null || oldCellValue == newCellValue) {
      return Future<void>.value();
    }

    changeCellValue(
        editCell, oldCellValue, rowColumnIndex.rowIndex, rowColumnIndex.columnIndex, isActualColumn, isBudgetColumn);

    changeYearlyRowData(isActualColumn, isBudgetColumn, rowColumnIndex.rowIndex, oldCellValue, newCellValue);

    saveChangesToData(editCell, newCellValue, isActualColumn, isBudgetColumn);
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

  void updateTableView() => notifyListeners();

  Future<void> changeCellValue(VlorishDataGridCell editCell, int oldCellValue, int rowIndex, int columnIndex,
      bool isActual, bool isBudget) async {
    ///change value in table view
    dataGridRows[rowIndex].getCells()[columnIndex] = editCell.copyWith(newCellValue as int);

    var shiftIndexToDiffColumn = isActual ? 1 : 2;
    var newDiffValue = isActual
        ? dataGridRows[rowIndex].getCells()[columnIndex - 1].value -
            dataGridRows[rowIndex].getCells()[columnIndex].value
        : dataGridRows[rowIndex].getCells()[columnIndex].value -
            dataGridRows[rowIndex].getCells()[columnIndex + 1].value;

    dataGridRows[rowIndex].getCells()[columnIndex + shiftIndexToDiffColumn] = editCell.copyWith(newDiffValue);
    notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex, columnIndex + shiftIndexToDiffColumn));
  }

  void changeYearlyRowData(bool isActual, bool isBudget, int rowIndex, int oldCellValue, int newCellValue) {
    const yearlyBudgetColumnIndex = 10;
    const yearlyActualColumnIndex = 11;
    const yearlyDifferenceColumnIndex = 12;

    ///update ACTUAL value in year column
    if (isActual) {
      dataGridRows[rowIndex].getCells()[yearlyActualColumnIndex] =
          (dataGridRows[rowIndex].getCells()[yearlyActualColumnIndex] as VlorishDataGridCell)
              .copyWith(dataGridRows[rowIndex].getCells()[yearlyActualColumnIndex].value - oldCellValue + newCellValue);
    }

    ///update BUDGET value in year column
    if (isBudget) {
      dataGridRows[rowIndex].getCells()[yearlyBudgetColumnIndex] =
          (dataGridRows[rowIndex].getCells()[yearlyBudgetColumnIndex] as VlorishDataGridCell)
              .copyWith(dataGridRows[rowIndex].getCells()[yearlyBudgetColumnIndex].value - oldCellValue + newCellValue);
    }

    ///update DIFFERENCE value in year column
    dataGridRows[rowIndex].getCells()[yearlyDifferenceColumnIndex] =
        (dataGridRows[rowIndex].getCells()[yearlyDifferenceColumnIndex] as VlorishDataGridCell).copyWith(
            dataGridRows[rowIndex].getCells()[yearlyBudgetColumnIndex].value -
                dataGridRows[rowIndex].getCells()[yearlyActualColumnIndex].value);

    notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex, yearlyBudgetColumnIndex));
    notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex, yearlyActualColumnIndex));
    notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex, yearlyDifferenceColumnIndex));
  }

  void saveChangesToData(VlorishDataGridCell cell, dynamic newCellValue, bool isActual, bool isBudget) {
    var cellInData = categoriesList
        .firstWhere((category) => category.id == cell.categoryId)
        .subCategories
        .firstWhere((subcategory) => subcategory.id == cell.subcategoryId)
        .yearData
        .firstWhere((month) => month.id == cell.monthId);

    //TODO: handle error state

    var catIndex = categoriesList.indexOf(categoriesList.firstWhere((category) => category.id == cell.categoryId));

    var subCatIndex = categoriesList[catIndex].subCategories.indexOf(
        categoriesList[catIndex].subCategories.firstWhere((subcategory) => subcategory.id == cell.subcategoryId));

    var monthIndex = categoriesList[catIndex].subCategories[subCatIndex].yearData.indexOf(cellInData);

    /// Save the new cell value to model collection.
    if (isActual) {
      cellInData = cellInData.copyWith(newActual: newCellValue);
      categoriesList[catIndex].subCategories[subCatIndex].yearData[monthIndex] =
          categoriesList[subCatIndex].subCategories[subCatIndex].yearData[catIndex].copyWith(
                newActual: newCellValue as int,
                newDiff: cellInData.budget - newCellValue,
              );
    }
    if (isBudget) {
      categoriesList[catIndex].subCategories[subCatIndex].yearData[monthIndex] =
          categoriesList[subCatIndex].subCategories[subCatIndex].yearData[catIndex].copyWith(
                newBudget: newCellValue as int,
                newDiff: newCellValue - cellInData.actual,
              );
    }
  }

  ///Found on https://support.syncfusion.com/kb/article/12401/how-to-update-cell-in-specific-column-based-on-other-column-cell-value-when-editing-at-run
  @override
  void notifyDataSourceListeners({RowColumnIndex? rowColumnIndex}) {
    super.notifyDataSourceListeners(rowColumnIndex: rowColumnIndex);
  }
}
