import 'package:loginsignspaceorion/SQLITE_database/database_helper.dart';
import 'package:loginsignspaceorion/dropdown2.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
 Database dataBase;
List tableOfPlace;
 class NewDbProvider {

  NewDbProvider._privateConstructor();
  PlaceType placeType;
  static final NewDbProvider instance = NewDbProvider._privateConstructor();

  static final _tableName = 'placeTable';
  static final columnPlaceId = 'p_id';
  static final columnPlaceName = 'p_type';
  static final columnPlaceUser = 'user';


  static final  _floorTableName = 'floorTable';
  static final columnFloorId = 'f_id';
  static final columnFloorName = 'f_name';
  static final columnFloorUser = 'user';


  static final _roomTableName='roomTable';
  static final columnRoomName='r_name';
  static final columnRoomId='r_id';
  static final columnRoomUser = 'user';



  static final _placeFloorTable='placeFloorTable';
  static final columnPlaceFloorId='f_id';
  static final columnPlaceFloorPid='p_id';
  static final columnPlaceFloorName='f_name';
  static final columnPlaceFloorUser='user';


  Database db;


  // static final columnId = 'id';

  Future<Database> get database async {
    if (dataBase != null) {
      return dataBase;
    } else {
      dataBase = await initiateDatabase();
      return dataBase;
    }
  }
  Directory directory;
  initiateDatabase() async {
     directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "placeTable.db");
    var database = await openDatabase(
        path, version: 1, onCreate:

        (db, version) async{
     await db.execute('''
         CREATE TABLE $_tableName (  $columnPlaceId INTEGER PRIMARY KEY,
         $columnPlaceName TEXT NOT NULL,$columnPlaceUser INTEGER )
         ''');

     // await db.execute('''
     //     CREATE TABLE $_floorTableName ($columnFloorId  NOT NULL PRIMARY KEY,
     //     $columnFloorName TEXT NOT NULL   )
     //     ''');
     await db.execute('''
        CREATE TABLE $_floorTableName($columnFloorId NOT NULL PRIMARY KEY , $columnFloorName TEXT NOT NULL ,$columnPlaceId INTEGER,$columnFloorUser INTEGER,FOREIGN KEY($columnPlaceId) REFERENCES $_tableName ($columnPlaceId ));
        ''');

     await db.execute('''
        CREATE TABLE $_roomTableName(   $columnRoomId NOT NULL PRIMARY KEY , $columnRoomName TEXT NOT NULL ,$columnFloorId INTEGER,$columnRoomUser INTEGER,FOREIGN KEY($columnFloorId) REFERENCES $_tableName ($columnFloorId ))
        ''');

     // await db.execute('''CREATE TABLE $_placeFloorTable ($columnPlaceFloorId NOT NULL PRIMARY KEY , $columnPlaceFloorPid INTEGER ,$columnPlaceFloorName TEXT, $columnPlaceFloorUser INTEGER )
     // ''');

     await db.execute('''
        CREATE TABLE $_placeFloorTable(   $columnPlaceFloorId NOT NULL PRIMARY KEY , $columnPlaceFloorName TEXT NOT NULL ,$columnPlaceFloorPid INTEGER,$columnPlaceFloorUser INTEGER)
        ''');

      // await db.execute(''' CREATE $_floorTableName ($columnFloorId INTEGER NOT NULL PRIMARY KEY, $columnFloorName TEXT NOT NULL ,$columnFloorPlaceId INTEGER NOT NULL,
      //  FOREIGN KEY ($columnFloorId) REFERENCES $_tableName($columnPlaceId)
      //  )
      // ''');
    });
    return database;
  }


var qq;


  Future <void> insertAnotherTableData(FloorType floorType)async{
    final db= await database;
    await db.insert('$_placeFloorTable', floorType.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Define a function that inserts dogs into the database
  Future<void> insertPlaceModelData(PlaceType placeType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_tableName',
      placeType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // print('row  ${placeType.pType} ||  ${placeType.pId}');
  }
  Future<void> insertFloorModelData(FloorType floorType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_floorTableName',
      floorType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // print('floorRow  ${floorType.fName} || ${floorType.fId} ');
  }


  Future<void> insertRomModelData(RoomType roomType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_roomTableName',
      roomType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// A method that retrieves all the dogs from the dogs table.
   Future<List<PlaceType>> retrievesPlaces() async {
     final db = await database;

     // Query the table for all The Dogs.
     final List<Map<String, dynamic>> maps = await db.query('placeTable');

     // Convert the List<Map<String, dynamic> into a List<Dog>.
     return List.generate(maps.length, (i) {
       return PlaceType(
         pId: maps[i]['p_id'].toString(),
         pType: maps[i]['p_type'].toString(),
         user: maps[i]['user'],
       );
     });
   }









   Future<int> insertPlaceData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    Database db2 = await instance.database;

    // var ff=await db.insert(_tableName, row);
    // ff=await db.insert(_floorTableName, row);
    // db2.insert(_floorTableName, row,conflictAlgorithm: ConflictAlgorithm.replace);

    return await db.insert(_tableName, row,conflictAlgorithm: ConflictAlgorithm.replace);
    // return ff;
  }

  Future<int> insertFloorData(Map<String, dynamic> row) async {
    Database db = await instance.database;
// print('row $row');
    return await db.insert(_floorTableName, row,conflictAlgorithm: ConflictAlgorithm.replace);
    // return ff;
  }

  Future<int> insertRoomData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    print('row $row');
    return await db.insert(_roomTableName, row,conflictAlgorithm: ConflictAlgorithm.replace);
    // return ff;
  }



  queryAll() async {
    Database db = await instance.database;
    // tableOfPlace=db.query(_tableName);
    // print(tableOfPlace)
    print(db.query(_tableName).toString());
    return await db.query(_tableName);
  }


   queryAnotherFloor() async {
     Database db = await instance.database;
     // tableOfPlace=db.query(_tableName);
     // print(tableOfPlace)
     print(db.query(_placeFloorTable).toString());
     return await db.query(_placeFloorTable);
   }


  queryFloor() async {
    Database db = await instance.database;

    return await db.query(_floorTableName);
  }

  selectTable()async{

    // final productList = await queryFloor().select().toList();
    //
    // for (int i = 0; i < productList.length; i++) {
    //   print(productList[i].toMap());
    // }

   var aa= await db.rawQuery('SELECT * FROM $_floorTableName WHERE $columnPlaceId =? ',['p_id']);
    print(aa);
  }

   Future getFloorById(String id) async {
     final db = await database;
     var result = await db.query("floorTable", where: "p_id = ? ", whereArgs: [id]);
     print('result $result');
     // return result.isNotEmpty?result.first:Null;
     return result;
     return result.isNotEmpty ? FloorType.fromJson(result.first): Null;

     // fromMap(result.first) : Null;
     // return result;
   }

   queryRoom() async {
    Database db = await instance.database;
    return await db.query(_roomTableName);
  }
  // Future update(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   int id = row[columnPlaceId];
  //   String name = row[columnPlaceName];
  //   return await db.update(_tableName, row, where: '$id=? ',
  //       whereArgs: [id]
  //   );
  // }

  Future <int> update(Map<String,dynamic> row)async{
    Database db= await instance.database;
    var id=row[columnPlaceId];
    return await db.update(_tableName,row, where: '$columnPlaceId=?',whereArgs: [id]);
  }

  Future<int> delete(int id)async{
    Database db= await instance.database;
    // await db.transaction((txn) async{
    // var batch=txn.batch();
    //   batch.delete(id.pId);
    //   batch.delete(id.fName);
    //   batch.delete(id.fId);
    //   batch.delete(id.user.toString());
    //   await batch.commit();
    // });
    return await db.delete(_placeFloorTable,where: "$columnPlaceFloorPid=?",whereArgs: [id]);
  }
}