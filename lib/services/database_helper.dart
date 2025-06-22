import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post_model.dart';

class DatabaseHelper {
  static const _databaseName = "HappyPets.db";
  static const _databaseVersion = 1; 

  static const tablePosts = 'posts';

  static const columnId = 'id';
  static const columnImagePath = 'imagePath';
  static const columnName = 'name';
  static const columnDescription = 'description';
  static const columnLocation = 'location';
  static const columnUser = 'user';
  static const columnDate = 'date';
  static const columnLiked = 'liked';

  //hacer la clase un singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //referencia a base de datos
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //abrimos la base de datos y la creamos si no existe
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
  }

  //SQL para crear la tabla
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tablePosts (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnImagePath TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnLocation TEXT NOT NULL,
            $columnUser TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnLiked INTEGER NOT NULL DEFAULT 0
          )
          ''');
  }


  //metodos helper CRUD

  //insertar post
  Future<int> insertPost(Post post) async {
    Database db = await instance.database;
    return await db.insert(tablePosts, post.toMap());
  }

  //obtener todos los post
  Future<List<Post>> getAllPosts() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tablePosts, orderBy: "$columnId DESC");
    return List.generate(maps.length, (i) {
      return Post.fromMap(maps[i]);

    });

  }

  //obtener post de usuario especifico
  Future<List<Post>> getUserPosts(String userName) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tablePosts,
      where: '$columnUser = ?',
      whereArgs: [userName],
      orderBy: "$columnId DESC"
    );
    return List.generate(maps.length, (i) {
      return Post.fromMap(maps[i]);
    });
  }

  // Actualizar un post
  Future<int> updatePost(Post post) async {
    Database db = await instance.database;
    return await db.update(tablePosts, post.toMap(),
        where: '$columnId = ?', whereArgs: [post.id]);
  }

  //eliminar post
  Future<int> deletePost(int id) async {
    Database db = await instance.database;

    return await db.delete(tablePosts, where: '$columnId = ?', whereArgs: [id]);
  }

  //insertar datos inciales
  Future<void> insertInitialDataIfEmpty(List<Map<String, dynamic>> initialPostsData) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> existing = await db.query(tablePosts, limit: 1);

    if (existing.isEmpty) {

      for (var postData in initialPostsData) {
        Post post = Post(
          imagePath: postData['image'],
          name: postData['name'],
          description: postData['description'],
          location: postData['location'],
          user: postData['user'],
          date: postData['date'],
          liked: postData['liked'] ?? false, 
        );
        await db.insert(tablePosts, post.toMap());
      }
      print("DatabaseHelper: insertInitialDataIfEmpty - Initial data inserted."); //debug
    }
  }
}