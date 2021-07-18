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



  static final _deviceTable='deviceTable';
  static final columnDeviceId='d_id';
  static final columnDeviceUser='user';
  static final columnDeviceRoomId='r_id';




  static final _devicePinStatus='devicePinValues';

  static final columnDevicePin1='pin1Status';
  static final columnDevicePin2='pin2Status';
  static final columnDevicePin3='pin3Status';
  static final columnDevicePin4='pin4Status';
  static final columnDevicePin5='pin5Status';
  static final columnDevicePin6='pin6Status';
  static final columnDevicePin7='pin7Status';
  static final columnDevicePin8='pin8Status';
  static final columnDevicePin9='pin9Status';
  static final columnDevicePin10='pin10Status';
  static final columnDevicePin11='pin11Status';
  static final columnDevicePin12='pin12Status';

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
     await db.execute('''
        CREATE TABLE $_floorTableName($columnFloorId INTEGER NOT NULL PRIMARY KEY , $columnFloorName TEXT NOT NULL ,$columnPlaceId INTEGER,$columnFloorUser INTEGER,FOREIGN KEY($columnFloorId) REFERENCES $_tableName ($columnPlaceId ));
        ''');

     await db.execute('''
        CREATE TABLE $_roomTableName(   $columnRoomId INTEGER NOT NULL PRIMARY KEY , $columnRoomName TEXT NOT NULL ,$columnFloorId INTEGER,$columnRoomUser INTEGER,FOREIGN KEY($columnRoomId) REFERENCES $_floorTableName ($columnFloorId ))
        ''');


     await db.execute('''
        CREATE TABLE $_deviceTable( $columnDeviceUser INTEGER , $columnRoomId INTEGER NOT NULL , $columnDeviceId TINYTEXT PRIMARY KEY ,FOREIGN KEY($columnDeviceId) REFERENCES $_roomTableName($columnRoomId))
        ''');


     await db.execute('''
        CREATE TABLE $_devicePinStatus( 
        $columnDevicePin1 INTEGER  , 
        $columnDevicePin2 INTEGER ,
         $columnDevicePin3 INTEGER ,
         $columnDevicePin4 INTEGER ,
         $columnDevicePin5 INTEGER ,
         $columnDevicePin6 INTEGER ,
         $columnDevicePin7 INTEGER ,
         $columnDevicePin8 INTEGER ,
         $columnDevicePin9 INTEGER ,
         $columnDevicePin10 INTEGER ,
         $columnDevicePin11 INTEGER ,
         $columnDevicePin12 INTEGER )
        ''');


    });
    return database;
  }


var qq;



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


  Future<void> insertRoomModelData(RoomType roomType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_roomTableName',
      roomType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  Future<void> insertDeviceModelData(Device device) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_deviceTable',
      device.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('_deviceTable  ${_deviceTable}');
  }


  Future<void> insertDevicePin(DevicePin devicePin)async{
    final db= await database;
    await db.insert('$_devicePinStatus',
      devicePin.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace);
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









  // Future<int> insertRoomData(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   print('row $row');
  //   return await db.insert(_roomTableName, row,conflictAlgorithm: ConflictAlgorithm.replace);
  //   // return ff;
  // }



  queryAll() async {
    Database db = await instance.database;
    // tableOfPlace=db.query(_tableName);
    // print(tableOfPlace)
    print(db.query(_tableName).toString());
    return await db.query(_tableName);
  }
  queryFloor() async {
    Database db = await instance.database;

    return await db.query(_floorTableName);
  }

   queryRoom() async {
     Database db = await instance.database;

     return await db.query(_roomTableName);
   }

   queryDevice() async {
     Database db = await instance.database;

     return await db.query(_deviceTable);
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

   Future getRoomById(String id) async {
     final db = await database;
     var result = await db.query("roomTable", where: "f_id = ? ", whereArgs: [id]);
     print('FlooronCHangesresult $result');
     // return result.isNotEmpty?result.first:Null;
     return result;
     return result.isNotEmpty ? FloorType.fromJson(result.first): Null;

     // fromMap(result.first) : Null;
     // return result;
   }





   Future getDeviceByRId(String id) async {
     final db = await database;
     var result = await db.query("deviceTable", where: "r_id = ? ", whereArgs: [id]);
     print('roomchanges $result');
     // return result.isNotEmpty?result.first:Null;
     return result;
     return result.isNotEmpty ? FloorType.fromJson(result.first): Null;

     // fromMap(result.first) : Null;
     // return result;
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


}