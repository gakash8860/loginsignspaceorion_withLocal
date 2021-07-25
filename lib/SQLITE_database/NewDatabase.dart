






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

  static final _floorTableName = 'floorTable';
  static final columnFloorId = 'f_id';
  static final columnFloorName = 'f_name';
  static final columnFloorUser = 'user';

  static final _roomTableName = 'roomTable';
  static final columnRoomName = 'r_name';
  static final columnRoomId = 'r_id';
  static final columnRoomUser = 'user';

  static final _deviceTable = 'deviceTable';
  static final columnDeviceId = 'd_id';
  static final columnDeviceUser = 'user';
  static final columnDeviceRoomId = 'r_id';

  static final _devicePinNames = 'devicePinNamesValues';
  static final columnDevicePinId = 'id';
  static final pin1Name = 'pin1Name';
  static final pin2Name = 'pin2Name';
  static final pin3Name = 'pin3Name';
  static final pin4Name = 'pin4Name';
  static final pin5Name = 'pin5Name';
  static final pin6Name = 'pin6Name';
  static final pin7Name = 'pin7Name';
  static final pin8Name = 'pin8Name';
  static final pin9Name = 'pin9Name';
  static final pin10Name = 'pin10Name';
  static final pin11Name = 'pin11Name';
  static final pin12Name = 'pin12Name';
  static final pin13Name = 'pin13Name';
  static final pin14Name = 'pin14Name';
  static final pin15Name = 'pin15Name';
  static final pin16Name = 'pin16Name';
  static final pin17Name = 'pin17Name';
  static final pin18Name = 'pin18Name';
  static final pin19Name = 'pin19Name';
  static final pin20Name = 'pin20Name';




  static final _devicePinStatus = 'devicePinStatus';
  static final columnDevicePinStatusId = 'id';
  static final pin1Status = 'pin1Status';
  static final pin2Status = 'pin2Status';
  static final pin3Status = 'pin3Status';
  static final pin4Status = 'pin4Status';
  static final pin5Status = 'pin5Status';
  static final pin6Status = 'pin6Status';
  static final pin7Status = 'pin7Status';
  static final pin8Status = 'pin8Status';
  static final pin9Status = 'pin9Status';
  static final pin10Status = 'pin10Status';
  static final pin11Status = 'pin11Status';
  static final pin12Status = 'pin12Status';
  static final pin13Status = 'pin13Status';
  static final pin14Status = 'pin14Status';
  static final pin15Status = 'pin15Status';
  static final pin16Status = 'pin16Status';
  static final pin17Status = 'pin17Status';
  static final pin18Status = 'pin18Status';
  static final pin19Status = 'pin19Status';
  static final pin20Status = 'pin20Status';



  static final _sensorTable = 'sensorTable';
  static final sensorId = 'id';
  static final sensor1 = 'sensor1';
  static final sensor2 = 'sensor2';
  static final sensor3 = 'sensor3';
  static final sensor4 = 'sensor4';
  static final sensor5 = 'sensor5';
  static final sensor6 = 'sensor6';
  static final sensor7 = 'sensor7';
  static final sensor8 = 'sensor8';
  static final sensor9 = 'sensor9';
  static final sensor10 = 'sensor10';



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
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
         CREATE TABLE $_tableName (  $columnPlaceId INTEGER PRIMARY KEY,
         $columnPlaceName TEXT NOT NULL,$columnPlaceUser INTEGER )
         ''');
      // await db.execute('''
      //    CREATE TABLE $_tableName (  ${placeType.pId} INTEGER PRIMARY KEY,
      //    ${placeType.pType} TEXT NOT NULL,${placeType.user} INTEGER )
      //    ''');
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
        CREATE TABLE $_devicePinNames( $columnDeviceId TINYTEXT, $columnDevicePinId INTEGER , $pin1Name TEXT , $pin2Name TEXT NOT NULL , $pin3Name TEXT  ,$pin4Name TEXT,$pin5Name TEXT,$pin6Name TEXT,$pin7Name TEXT,$pin8Name TEXT,$pin9Name TEXT,$pin10Name TEXT,$pin11Name TEXT,$pin12Name TEXT,$pin13Name TEXT,$pin14Name TEXT,$pin15Name TEXT,$pin16Name TEXT,$pin17Name TEXT,$pin18Name TEXT,$pin19Name TEXT,$pin20Name TEXT,FOREIGN KEY($pin1Name) REFERENCES $_deviceTable($columnDeviceId))
        ''');
      await db.execute('''
        CREATE TABLE $_devicePinStatus( $columnDeviceId TINYTEXT, $columnDevicePinStatusId INTEGER , $pin1Status INTEGER , $pin2Status INTEGER NOT NULL , $pin3Status INTEGER  ,$pin4Status INTEGER,$pin5Status INTEGER,$pin6Status INTEGER,$pin7Status INTEGER,$pin8Status INTEGER,$pin9Status INTEGER,$pin10Status INTEGER,$pin11Status INTEGER,$pin12Status INTEGER,$pin13Status INTEGER,$pin14Status INTEGER,$pin15Status INTEGER,$pin16Status INTEGER,$pin17Status INTEGER,$pin18Status INTEGER,$pin19Status INTEGER,$pin20Status INTEGER,FOREIGN KEY($pin1Status) REFERENCES $_deviceTable($columnDeviceId))
        ''');
      await db.execute('''
        CREATE TABLE $_sensorTable( $columnDeviceId TINYTEXT,$sensor1 FLOAT ,$sensorId INTEGER , $sensor2 FLOAT ,$sensor3 FLOAT,$sensor4 FLOAT,$sensor5 FLOAT ,$sensor6 FLOAT ,$sensor7 FLOAT,$sensor8 FLOAT,$sensor9 FLOAT,$sensor10 FLOAT,FOREIGN KEY($columnDeviceId) REFERENCES $_deviceTable($columnDeviceId))
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

  }

  Future<void> insertFloorModelData(FloorType floorType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_floorTableName',
      floorType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

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

    print('_deviceTable  $_deviceTable');
  }

  Future<void> insertDevicePinNames(DevicePin devicePin) async {
    final db = await database;
    await db.insert('$_devicePinNames', devicePin.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertPinStatusData(PinStatus pinStatus) async {
    final db = await database;
    await db.insert('$_devicePinStatus', pinStatus.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertSensorData(SensorData sensorData) async {
    final db = await database;
    await db.insert('$_sensorTable', sensorData.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  queryPlace() async {
    Database db = await instance.database;

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
  queryPinNames() async {
    Database db = await instance.database;
    return await db.query(_devicePinNames);
  }
  queryDevice() async {
    Database db = await instance.database;

    return await db.query(_deviceTable);
  }
  querySensor() async {
    Database db = await instance.database;

    return await db.query(_sensorTable);
  }

  queryPinStatus() async {
    Database db = await instance.database;

    return await db.query(_devicePinStatus);
  }

  Future getFloorById(String id) async {
    final db = await database;
    var result =
        await db.query("floorTable", where: "p_id = ? ", whereArgs: [id]);
    print('result $result');

    return result;
  }

  Future getRoomById(String id) async {
    final db = await database;
    var result =
        await db.query("roomTable", where: "f_id = ? ", whereArgs: [id]);
    print('FlooronChangesResult $result');
    return result;
  }

  Future getDeviceByRId(String id) async {
    final db = await database;
    var result =
        await db.query("deviceTable", where: "r_id = ? ", whereArgs: [id]);
    print('DeviceChanges $result');

    return result;
  }



  Future getPinNamesByDeviceId(String id) async {
    final db = await database;
    var result =
    await db.query("devicePinNamesValues", where: "d_id = ? ", whereArgs: [id]);
    print('PinNameResult $result');
    // return result.isNotEmpty?result.first:Null;
    return result;}



  Future getPinStatusByDeviceId(String id) async {
    final db = await database;
    var result =
    await db.query("devicePinStatus", where: "d_id = ? ", whereArgs: [id]);
    print('PinStatusResult $result');
    // return result.isNotEmpty?result.first:Null;
    return result;}


  Future getSensorByDeviceId(String id) async {
    final db = await database;
    var result =
    await db.query("sensorTable", where: "d_id = ? ", whereArgs: [id]);
    print('PinNameResult $result');
    // return result.isNotEmpty?result.first:Null;
    return result;
  }
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var id = row[columnPlaceId];
    return await db
        .update(_tableName, row, where: '$columnPlaceId=?', whereArgs: [id]);
  }
  Future close()async{
    final db= await instance.database;
    db.close();
  }

}
