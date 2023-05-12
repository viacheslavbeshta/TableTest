class MonthData {
  final int budget;
  final int actual;
  final int diff;
  final String categoryId;
  final String subcategoryId;
  final String id;

  MonthData(
    this.budget,
    this.actual,
    this.diff,
    this.categoryId,
    this.subcategoryId,
    this.id,
  );

  @override
  String toString() {
    return 'MonthData{budget: $budget, actual: $actual, diff: $diff, categoryId: $categoryId, subcategoryId: $subcategoryId, id: $id}';
  }

  MonthData copyWith({int? newActual, int? newBudget, int? newDiff}) {
    return MonthData(newBudget ?? budget, newActual ?? actual, newDiff ?? diff, categoryId, subcategoryId, id);
  }
}

class RegularRow {
  final List<MonthData> yearData;
  final String category;
  final String id;

  const RegularRow({required this.yearData, required this.category, required this.id});

  int rowActualSum() {
    var actualYearSum = 0;
    for (var month in yearData) {
      actualYearSum += month.actual;
    }
    return actualYearSum;
  }

  int rowBudgetSum() {
    var budgetYearSum = 0;
    for (var month in yearData) {
      budgetYearSum += month.budget;
    }
    return budgetYearSum;
  }

  int rowDiffSum() {
    var diffYearSum = 0;
    for (var month in yearData) {
      diffYearSum += month.diff;
    }
    return diffYearSum;
  }
}

class SubCategory extends RegularRow {
  SubCategory({required super.yearData, required super.category, required super.id, required this.categoryId});

  ///[id] is id of subcategory
  ///[categoryId] is id of parent category
  final String categoryId;
}

class Category extends RegularRow {
  const Category({required super.yearData, required super.category, required super.id, required this.subCategories});

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
