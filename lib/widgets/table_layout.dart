import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../business_logic/syncfusion_datasource.dart';
import '../data/employee.dart';

const jbKey = 'januaryBudget';
const jaKey = 'januaryActual';
const jdKey = 'januaryDifference';

const fbKey = 'februaryBudget';
const faKey = 'februaryActual';
const fdKey = 'februaryDifference';

const mbKey = 'marchBudget';
const maKey = 'marchActual';
const mdKey = 'marchDifference';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TableData employees = TableData([]);
  late SFDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = SFDataSource(employees);
  }

  @override
  void didChangeDependencies() {
    employeeDataSource = SFDataSource(employees);
    super.didChangeDependencies();
  }

  var showDiff = true;
  var showActual = true;
  var showBudget = false;
  var scroll = const ScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataGrid Sample'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(value: showBudget, onChanged: (value) => setState(() => showBudget = !showBudget)),
              const Text('budget'),
              Checkbox(value: showActual, onChanged: (value) => setState(() => showActual = !showActual)),
              const Text('actual'),
              Checkbox(value: showDiff, onChanged: (value) => setState(() => showDiff = !showDiff)),
              const Text('difference')
            ],
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }, physics: const ScrollPhysics().applyTo(const ClampingScrollPhysics())),
              child: Builder(builder: (context) {
                return SfDataGrid(
                  navigationMode: GridNavigationMode.cell,
                  allowEditing: true,
                  editingGestureType: EditingGestureType.doubleTap,
                  selectionMode: SelectionMode.single,
                  source: employeeDataSource,
                  columnWidthMode: ColumnWidthMode.none,
                  frozenColumnsCount: 1,
                  isScrollbarAlwaysShown: true,
                  defaultColumnWidth: 150,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  stackedHeaderRows: <StackedHeaderRow>[
                    StackedHeaderRow(cells: [
                      StackedHeaderCell(
                        columnNames: [jbKey, jaKey, jdKey],
                        child: Container(
                          color: const Color(0xFFF1F1F1),
                          child: const Center(
                            child: Text('January'),
                          ),
                        ),
                      ),
                      StackedHeaderCell(
                        columnNames: [fbKey, faKey, fdKey],
                        child: Container(
                          color: const Color(0xFFF1F1F1),
                          child: const Center(
                            child: Text('February'),
                          ),
                        ),
                      ),
                      StackedHeaderCell(
                        columnNames: [mbKey, maKey, mdKey],
                        child: Container(
                          color: const Color(0xFFF1F1F1),
                          child: const Center(
                            child: Text('March'),
                          ),
                        ),
                      ),
                    ])
                  ],
                  columns: <GridColumn>[
                    GridColumn(
                      allowEditing: false,
                      columnName: 'category',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'CATEGORY',
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showBudget,
                      columnName: jbKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('BUDGET'),
                      ),
                    ),
                    GridColumn(
                      visible: showActual,
                      columnName: jaKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ACTUAL',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showDiff,
                      columnName: jdKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('DIFFERENCE'),
                      ),
                    ),
                    GridColumn(
                      visible: showBudget,
                      columnName: fbKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('BUDGET'),
                      ),
                    ),
                    GridColumn(
                      visible: showActual,
                      columnName: faKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ACTUAL',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showDiff,
                      columnName: fdKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('DIFFERENCE'),
                      ),
                    ),
                    GridColumn(
                      visible: showBudget,
                      columnName: mbKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('BUDGET'),
                      ),
                    ),
                    GridColumn(
                      visible: showActual,
                      columnName: maKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ACTUAL',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      visible: showDiff,
                      columnName: mdKey,
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('DIFFERENCE'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'YEAR',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('YEAR'),
                      ),
                    ),
                    GridColumn(
                      columnName: '%',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('%'),
                      ),
                    ),
                  ],
                  onCellTap: (DataGridCellTapDetails details) {
                    print(details.column.columnName);
                    print(details.column.label);
                    print(details.rowColumnIndex);
                    print(details.kind);
                    //rows == widgets
                  },
                  // onCellDoubleTap: (DataGridCellDoubleTapDetails details){//TODO: remove row from datasource
                  //   print(details.rowColumnIndex.rowIndex);
                  //   employeeDataSource.dataGridRows.removeAt(details.rowColumnIndex.rowIndex);
                  //   employeeDataSource.notifyListeners();
                  // },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  //
  TableData getEmployeeData() {
    const categoriesCount = 5;
    const subcategoryCount = 5;
    const monthCount = 12;

    List<Category> categories = List.generate(
        categoriesCount,
        (categoryIndex) => Category(
            yearData: List.generate(
                monthCount,
                (monthIndex) =>
                    MonthData(10000, 30000, 10000, categoryIndex.toString(), 0.toString(), monthIndex.toString())),
            category: 'Category $categoryIndex',
            id: categoryIndex.toString(),
            subCategories: List.generate(
                subcategoryCount,
                (subcategoryIndex) => SubCategory(
                      yearData: List.generate(
                        monthCount,
                        (monthIndex) => MonthData(
                          10000,
                          30000,
                          10000,
                          categoryIndex.toString(),
                          subcategoryIndex.toString(),
                          monthIndex.toString(),
                        ),
                      ),
                      category: 'subcategory $subcategoryIndex',
                      categoryId: categoryIndex.toString(),
                      id: subcategoryIndex.toString(),
                    ))));

    return TableData(categories);
  }
}
