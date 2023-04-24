import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'employee.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(this._employees);

  final List<Employee> _employees;

  late List<DataGridRow> dataGridRows =
      _employees.map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow()).toList();

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;
  bool isCategoryShown = true;
  void updateDataGridSource() => notifyListeners();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final cells = <Widget>[];
    final list = row.getCells();

    for (var i = 0; i < list.length; i++) {
      final dataGridCell = list[i];
      if (dataGridRows.indexOf(row) == 0 && dataGridCell.columnName == 'id') {
        //todo: row index
        cells.add(
          ToggleCell(
            value: dataGridCell.value.toString(),
            onCheckboxToggled: (value) {
              isCategoryShown = !isCategoryShown;
              updateDataGridSource();
            },
          ),
        );
        continue;
      }
      if (!isCategoryShown) {
        cells.add(SizedBox());
        continue;
      }
      if (dataGridCell.columnName == 'id') {
        cells.add(CategoryCell(
          value: dataGridCell.value.toString(),
          onDoubleTap: () {
            dataGridRows.remove(row);
            updateDataGridSource();
          },
        ));
        continue;
      }
      cells.add(PreviewCell(value: dataGridCell.value.toString()));
    }

    return DataGridRowAdapter(cells: cells);
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return Future<void>.value();
    }

    if (column.columnName == 'name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'name', value: newCellValue);
      _employees[dataRowIndex].salary = newCellValue as int;
    } else if (column.columnName == 'designation') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'designation', value: newCellValue);
      _employees[dataRowIndex].salary = newCellValue as int;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'salary', value: newCellValue);
      _employees[dataRowIndex].salary = newCellValue as int;
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
}

class CategoryCell extends StatelessWidget {
  const CategoryCell({Key? key, required this.value, required this.onDoubleTap}) : super(key: key);

  final VoidCallback onDoubleTap;

  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: Text(value)),
    );
  }
}

class PreviewCell extends StatelessWidget {
  const PreviewCell({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          value,
          overflow: TextOverflow.ellipsis,
        ));
  }
}

class ToggleCell extends StatefulWidget {
  const ToggleCell({Key? key, this.onCheckboxToggled, required this.value}) : super(key: key);
  final Function? onCheckboxToggled;
  final String value;
  @override
  State<ToggleCell> createState() => _ToggleCellState();
}

class _ToggleCellState extends State<ToggleCell> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.cyanAccent),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Text('${widget.value} - isChecked $isChecked'),
            GestureDetector(
              onTap: () => setState(() {
                isChecked = !isChecked;
                widget.onCheckboxToggled!(isChecked);
              }),
              child: isChecked ? Icon(Icons.expand_circle_down) : Icon(Icons.unfold_less_sharp),
            )
          ],
        ),
      ),
    );
  }
}
