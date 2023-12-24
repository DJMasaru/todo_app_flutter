import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model.dart';

class DBHelper{
  // DbHelperをinstance化する
  static final DBHelper instance = DBHelper._createInstance();
  static Database? _database;

  DBHelper._createInstance();

  // databaseをオープンしてインスタンス化する
  Future<Database> get database async {
    return _database ??= await _initDB();       // 初回だったら_initDB()=DBオープンする
  }

  // データベースをオープンする
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todo.db');    // tododbのパスを取得する

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,      // dbがなかった時の処理を指定する（DBは勝手に作られる）
    );
  }

  // データベースがなかった時の処理
  Future _onCreate(Database database, int version) async {
    //catsテーブルをcreateする
    await database.execute('''
      CREATE TABLE mytodo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        desc TEXT,
        dateandtime TEXT
      )
    ''');
  }

  Future<TodoModel> insert(TodoModel todoModel) async {
    var dbClient = await database;
    await dbClient.insert('mytodo',todoModel.toMap());
    return todoModel;
  }

  Future<List<TodoModel>>getDataList()async{
    await database;
    final List<Map<String, Object?>>queryResult = await _database!.rawQuery(
        '''
      SELECT * FROM mytodo
    '''
    );
    return queryResult.map((e) => TodoModel.fromMap(e)).toList();
  }
  
  Future<int> delete(int id)async{
    var dbClient = await database;
    return await dbClient.delete('mytodo',where: 'id = ?',whereArgs: [id]);
  }

  Future<int> update(TodoModel todoModel) async {
    var dbClient = await database;
    return await dbClient.update('mytodo', todoModel.toMap(),where:'id = ?',whereArgs:[todoModel.id]);
  }
}