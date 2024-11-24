import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Expense Model
class Expense {
  int? id;
  String description;
  String category;
  double amount;
  DateTime date;

  Expense({
    this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
  });

  // Convert Expense object to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnDescription: description,
      DatabaseHelper.columnAmount: amount,
      DatabaseHelper.columnDate: date.toIso8601String(),
      DatabaseHelper.columnCategory: category,
    };
  }

  // Convert Map from database to Expense object
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map[DatabaseHelper.columnId],
      description: map[DatabaseHelper.columnDescription],
      amount: map[DatabaseHelper.columnAmount],
      date: DateTime.parse(map[DatabaseHelper.columnDate]),
      category: map[DatabaseHelper.columnCategory],
    );
  }
}

// Database Helper Class for Managing Database Operations
class DatabaseHelper {
  static final _databaseName = 'expenses.db';
  static final _tableName = 'expenses';

  static final columnId = '_id';
  static final columnDescription = 'description';
  static final columnAmount = 'amount';
  static final columnDate = 'date';
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
        $columnDate TEXT NOT NULL,
        $columnCategory TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertExpense(Expense expense) async {
    Database db = await instance.database;
    return await db.insert(_tableName, expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<int> updateExpense(Expense expense) async {
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

// Controller to Manage Expenses Using GetX
class ExpensesController extends GetxController {
  var expenses = <Expense>[].obs;

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
    required String description,
    required String category,
    required double amount,
    required DateTime date,
  }) async {
    final expense = Expense(
      id: id,
      description: description,
      category: category,
      amount: amount,
      date: date,
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

  void openBottomSheet(BuildContext context, {Expense? expense}) {
    final descriptionController =
    TextEditingController(text: expense?.description ?? '');
    final categoryController =
    TextEditingController(text: expense?.category ?? '');
    final amountController =
    TextEditingController(text: expense?.amount.toString() ?? '');
    DateTime selectedDate = expense?.date ?? DateTime.now();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date: ${selectedDate.toLocal().toString().split(' ')[0]}'),
                  TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        selectedDate = pickedDate;
                      }
                    },
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final description = descriptionController.text.trim();
                  final category = categoryController.text.trim();
                  final amount = double.tryParse(amountController.text) ?? 0;

                  if (description.isNotEmpty &&
                      category.isNotEmpty &&
                      amount > 0) {
                    addOrUpdateExpense(
                      id: expense?.id,
                      description: description,
                      category: category,
                      amount: amount,
                      date: selectedDate,
                    );
                    Get.back();
                  }
                },
                child: Text(expense == null ? 'Add Expense' : 'Update Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
