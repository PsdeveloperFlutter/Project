import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Receipe App/Screen/UI component .dart';

// Database helper class to handle SQLite operations
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('task_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        due_date TEXT NOT NULL,
        completed INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await instance.database;
    return await db.insert('tasks', task);
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final db = await instance.database;
    return await db.query('tasks');
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task,
      where: 'id = ?',
      whereArgs: [task['id']],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Main app class
void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskHomeScreen(),
    );
  }
}

class TaskHomeScreen extends StatefulWidget {
  @override
  _TaskHomeScreenState createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadTasks();
  }

  _loadTasks() async {
    final tasks = await DatabaseHelper.instance.fetchTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  _deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    _loadTasks();
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.greenAccent.shade200,
      context: context,
      isScrollControlled: true,
      builder: (_) => AddTaskSheet(onTaskAdded: _loadTasks),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Task Manager',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 12, fontFamily: 'Itim'),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.yellow.shade700,
          tabs: [
            Tab(text: 'View'),
            Tab(text: 'Update'),
            Tab(text: 'Delete'),
          ],
        ),
      ),
      body: Stack(
        children: [
          HomePage(),
          TabBarView(
            controller: _tabController,
            children: [
              TaskListView(tasks: _tasks, onUpdate: _loadTasks),
              TaskListView(tasks: _tasks, isUpdate: true, onUpdate: _loadTasks),
              TaskListView(
                  tasks: _tasks, isDelete: true, onDelete: _deleteTask, onUpdate: _loadTasks),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        onPressed: () => _showAddTaskSheet(context),
        child: Icon(CupertinoIcons.add, color: Colors.white),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final bool isUpdate;
  final bool isDelete;
  final Function(int)? onDelete;
  final VoidCallback? onUpdate;

  TaskListView({
    required this.tasks,
    this.isUpdate = false,
    this.isDelete = false,
    this.onDelete,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(child: Text('No tasks available'))
        : ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Card(
              elevation: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text("Title :- ${task['title']}"),
                      subtitle: Text('Date: ${task['due_date']}'),
                      trailing: isDelete
                          ? IconButton(
                        icon: Icon(CupertinoIcons.delete),
                        onPressed: () {
                          if (onDelete != null) onDelete!(task['id']);
                        },
                      )
                          : null,
                      onTap: isUpdate
                          ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        );
                        if (onUpdate != null) onUpdate!();
                      }
                          : null,
                    ),
                    Text(task['description'])
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddTaskSheet extends StatefulWidget {
  final VoidCallback onTaskAdded;

  AddTaskSheet({required this.onTaskAdded});

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;

  _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  _saveTask() async {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final task = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'due_date': _dueDate.toString(),
        'completed': 0,
      };
      await DatabaseHelper.instance.insertTask(task);
      widget.onTaskAdded();
      Navigator.pop(context as BuildContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title',labelStyle: TextStyle(color: Colors.brown)),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description',labelStyle: TextStyle(color: Colors.brown)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _dueDate == null
                          ? 'Select Due Date'
                          : 'Due Date: ${_dueDate!.toString()}'.split(' ')[0],
                    ),
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.calendar_today),
                    onPressed: () => _pickDueDate(context),
                  ),

                ],
              ),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditTaskScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task['title'];
    _descriptionController.text = widget.task['description'];
    _dueDate = DateTime.parse(widget.task['due_date']);
  }

  _updateTask() async {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final task = {
        'id': widget.task['id'],
        'title': _titleController.text,
        'description': _descriptionController.text,
        'due_date': _dueDate.toString(),
        'completed': widget.task['completed'],
      };
      await DatabaseHelper.instance.updateTask(task);
      Navigator.pop(context as BuildContext, true); // Indicate an update occurred
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back)),
        title: Text('Edit Task'),
      ),
      body: Stack(
        children: [
          HomePage(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dueDate == null
                              ? 'Select Due Date'
                              : 'Due Date: ${_dueDate.toString()}'.split(' ')[0],
                        ),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.calendar,color: Colors.black,),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _dueDate!,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null && picked != _dueDate) {
                            setState(() {
                              _dueDate = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _updateTask,
                    child: Text('Update Task'),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
