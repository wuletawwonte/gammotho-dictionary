import 'dart:async';
import 'dart:io'as io;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'word.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String WORD = 'name';
  static const String TABLE = 'words';
  static const String DB_NAME = 'Word.db';

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb(); 
    return _db;
  } 

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);


    ByteData data = await rootBundle.load(join("assets", "dict_db.sql"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);

    var db = await openDatabase(path, version: 1, onCreate: null);

    return db;
  }

  // _onCreate(Database db, int version) async{
  //   await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $WORD TEXT)");

  //   Map<String, dynamic> row1 = {
  //     // ID : null,
  //     WORD : "Wongela"
  //   };

  //   Map<String, dynamic> row2 = {
  //     WORD: "Wuletaw"
  //   };

  //   // do the insert and get the id of the inserted row
  //   await db.insert(TABLE, row1);
  //   await db.insert(TABLE, row2);
  // }

  Future<Word> save(Word word) async {
    var dbClient = await db;
    word.id = await dbClient.insert(TABLE, word.toMap());
    return word;
  }

  Future<List<Word>> getWords() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, WORD]);
    List<Word> words = [];
    if(maps.length > 0) {
      for(int i = 0;i < maps.length; i++) {
        words.add(Word.fromMap(maps[i]));
      }
    }
    return words;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
} 