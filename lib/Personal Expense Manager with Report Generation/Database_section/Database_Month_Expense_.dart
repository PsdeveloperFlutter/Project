import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Expense Model for Monthly Data
class MonthlyExpense {
  int? id;
  String description_month;
  String category_month;
  double amount_month;
  int month_month;
  int year_month;

  MonthlyExpense({
    this.id,
    required this.description_month,
    required this.category_month,
    required this.amount_month,
    required this.month_month,
    required this.year_month,
  });

  // Convert MonthlyExpense object to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnDescription: description_month,
      DatabaseHelper.columnAmount: amount_month,
      DatabaseHelper.columnMonth: month_month,
      DatabaseHelper.columnYear: year_month,
      DatabaseHelper.columnCategory: category_month,
    };
  }

  // Convert Map from database to MonthlyExpense object
  factory MonthlyExpense.fromMap(Map<String, dynamic> map) {
    return MonthlyExpense(
      id: map[DatabaseHelper.columnId],
      description_month: map[DatabaseHelper.columnDescription],
      amount_month: map[DatabaseHelper.columnAmount],
      month_month: map[DatabaseHelper.columnMonth],
      year_month: map[DatabaseHelper.columnYear],
      category_month: map[DatabaseHelper.columnCategory],
    );
  }
}

// Database Helper Class for Managing Monthly Database Operations
class DatabaseHelper {
  static final _databaseName = 'monthly_expenses.db';
  static final _tableName = 'monthly_expenses';

  static final columnId = '_id';
  static final columnDescription = 'description';
  static final columnAmount = 'amount';
  static final columnMonth = 'month';
  static final columnYear = 'year';
  static final columnCategory = 'category';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $columnId INTEGER PRIMARY KEY,
        $columnDescription TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnMonth INTEGER NOT NULL,
        $columnYear INTEGER NOT NULL,
        $columnCategory TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertExpense(MonthlyExpense expense) async {
    Database db = await instance.database;
    return await db.insert(_tableName, expense.toMap());
  }

  Future<List<MonthlyExpense>> getExpenses() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return MonthlyExpense.fromMap(maps[i]);
    });
  }

  Future<int> updateExpense(MonthlyExpense expense) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      expense.toMap(),
      where: '$columnId = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}

// Controller to Manage Monthly Expenses Using GetX
class MonthlyExpensesController extends GetxController {
  var expenses = <MonthlyExpense>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final data = await DatabaseHelper.instance.getExpenses();
    expenses.assignAll(data);
  }

  Future<void> addOrUpdateExpense({
    int? id,
    required String description_month,
    required String category_month,
    required double amount_month,
    required int month_month,
    required int year_month,
  }) async {
    final expense = MonthlyExpense(
      id: id,
      description_month: description_month,
      category_month: category_month,
      amount_month: amount_month,
      month_month: month_month,
      year_month: year_month,
    );

    if (id == null) {
      await DatabaseHelper.instance.insertExpense(expense);
    } else {
      await DatabaseHelper.instance.updateExpense(expense);
    }

    loadExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await DatabaseHelper.instance.deleteExpense(id);
    loadExpenses();
  }

  void openBottomSheet(BuildContext context, {MonthlyExpense? expense}) {
    final descriptionController =
    TextEditingController(text: expense?.description_month ?? '');
    final categoryController =
    TextEditingController(text: expense?.category_month ?? '');
    final amountController =
    TextEditingController(text: expense?.amount_month.toString() ?? '');
    int selectedMonth = expense?.month_month ?? DateTime.now().month;
    int selectedYear = expense?.year_month ?? DateTime.now().year;

    Get.bottomSheet(
      backgroundColor: Colors.white,
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Month: $selectedMonth, Year: $selectedYear'),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(selectedYear, selectedMonth),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          selectedMonth = pickedDate.month;
                          selectedYear = pickedDate.year;
                        }
                      },
                      child: Text('Pick Month/Year'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final description_month = descriptionController.text.trim();
                  final category_month = categoryController.text.trim();
                  final amount_month =
                      double.tryParse(amountController.text) ?? 0;

                  if (description_month.isNotEmpty &&
                      category_month.isNotEmpty &&
                      amount_month > 0) {
                    addOrUpdateExpense(
                      id: expense?.id,
                      description_month: description_month,
                      category_month: category_month,
                      amount_month: amount_month,
                      month_month: selectedMonth,
                      year_month: selectedYear,
                    );
                    Get.back();
                  }
                },
                child: Text(
                    expense == null ? 'Add Expense' : 'Update Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
