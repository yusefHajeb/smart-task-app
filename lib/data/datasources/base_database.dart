import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseDatabase {
  Database? _database;

  Future<Database> get database;

  /// Initialize the database.
  Future<void> init();

  Future<void> open();
  Future<void> insert(String table, Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs});
  Future<void> update(String table, Map<String, dynamic> data,
      {String? where, List<Object?>? whereArgs});
  Future<void> delete(String table, {String? where, List<Object?>? whereArgs});

  /// Close the database.
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

class SqfliteDatabase extends BaseDatabase {
  // Database? _database;
  static final SqfliteDatabase _instance = SqfliteDatabase._();

  factory SqfliteDatabase() => _instance;
  SqfliteDatabase._();

  @override
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'smart_task.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //create tables here
        await db.execute('CREATE TABLE IF NOT EXISTS users ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'email TEXT NOT NULL,'
            'password TEXT NOT NULL,'
            'phone TEXT NOT NULL,'
            'address TEXT NOT NULL,'
            'created_at INTEGER NOT NULL,'
            'updated_at INTEGER NOT NULL'
            ')');
        await db.execute('CREATE TABLE IF NOT EXISTS categories ('
            'category_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'user_id INTEGER NOT NULL,'
            'name TEXT NOT NULL,'
            'created_at INTEGER NOT NULL,'
            'updated_at INTEGER NOT NULL'
            ')');
        await db.execute('CREATE TABLE IF NOT EXISTS tasks ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT NOT NULL,'
            'description TEXT NOT NULL,'
            'category TEXT NOT NULL,'
            'due_date INTEGER NOT NULL,'
            'priority TEXT NOT NULL,'
            'completed INTEGER NOT NULL,'
            'completed_at INTEGER,'
            'created_at INTEGER NOT NULL,'
            'updated_at INTEGER NOT NULL'
            ')');
        //daily stats
        await db.execute('CREATE TABLE IF NOT EXISTS daily_stats ('
            'stat_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'user_id INTEGER NOT NULL,'
            'date INTEGER NOT NULL,'
            'total_tasks INTEGER NOT NULL,'
            'completed_tasks INTEGER NOT NULL,'
            'overdue_tasks INTEGER NOT NULL'
            ')');
        //daily stats

        await db.execute('CREATE TABLE IF NOT EXISTS user_tasks ('
            'user_id INTEGER NOT NULL,'
            'task_id INTEGER NOT NULL'
            ')');
        await db.execute('CREATE TABLE IF NOT EXISTS category_tasks ('
            'category_id INTEGER NOT NULL,'
            'task_id INTEGER NOT NULL'
            ')');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS user_categories (' //user categories
            'user_id INTEGER NOT NULL,'
            'category_id INTEGER NOT NULL'
            ')');
      },
    );
  }

  @override
  Future<void> open() async {
    if (_database == null) {
      await init();
      _database = await database;
      //please explain me this code
      await _database?.execute('PRAGMA cache_size = 10000');
      await _database?.execute('PRAGMA foreign_keys = ON');
      await _database?.execute('PRAGMA journal_mode = WAL');
      await _database?.execute('PRAGMA synchronous = NORMAL');
      await _database?.execute('PRAGMA temp_store = MEMORY');
    }
  }

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    await _database?.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<Object?>? whereArgs}) async {
    return await _database?.query(table, where: where, whereArgs: whereArgs) ??
        [];
  }

  Future<int> getOverdueTasks() async {
    final List<Map<String, dynamic>> maps = await query('daily_stats');
    return maps.length;
  }

  Future<int> getTotalTasks() async {
    final List<Map<String, dynamic>> maps = await query('daily_stats');
    return maps.length;
  }

  Future<void> insertDailyStats(Map<String, dynamic> data) async {
    await insert('daily_stats', data);
  }

  Future<void> insertUserTasks(Map<String, dynamic> data) async {
    await insert('user_tasks', data);
  }

  Future<void> insertCategoryTasks(Map<String, dynamic> data) async {
    await insert('category_tasks', data);
  }

  Future<void> insertUserCategories(Map<String, dynamic> data) async {
    await insert('user_categories', data);
  }

  Future<int> getCompletedTasks(DateTime date) async {
    final List<Map<String, dynamic>> maps = await query('user_tasks',
        where: 'completed_at BETWEEN ? AND ?',
        whereArgs: [
          DateTime(date.year, date.month, date.day).millisecondsSinceEpoch,
          DateTime(date.year, date.month, date.day + 1).millisecondsSinceEpoch -
              1
        ]);
    return maps.length;
  }

  Future<List<Map<String, dynamic>>> getTasks(int userID) async {
    return await query('task', where: 'user_id = ?', whereArgs: [userID]);
  }

  Future<List<Map<String, dynamic>>> getAllUserTasks(int userId) async {
    return await query('user_tasks', where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<List<Map<String, dynamic>>> getAllUserCompletedTasks(
      int userId) async {
    return await query('tasks',
        where:
            'completed = 1 AND id IN (SELECT task_id FROM user_tasks WHERE user_id = ?)',
        whereArgs: [userId]);
  }

  @override
  Future<void> update(String table, Map<String, dynamic> data,
      {String? where, List<Object?>? whereArgs}) async {
    await _database?.update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    await _database?.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }

  @override
  Future<Database> get database async {
    if (_database == null) {
      await open();
    }
    return _database!;
  }
}
