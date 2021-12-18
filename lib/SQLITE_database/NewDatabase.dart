// ignore_for_file: constant_identifier_names, unnecessary_string_interpolations

import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';


Database dataBase;
List tableOfPlace;

class NewDbProvider {
  NewDbProvider._privateConstructor();

  static final NewDbProvider instance = NewDbProvider._privateConstructor();

  static const _userDetails = 'userDetails';
  static const email = 'email';
  static const first_name = 'first_name';
  static const last_name = 'last_name';
  static const columnUserName = 'username';
  static const columnUserPassword = 'password1';
  static const columnUserPassword2 = 'password2';
  static const columnUserPhoneNumber = 'phone_no';

  static const _placeTableName = 'placeTable';
  static const columnPlaceId = 'p_id';
  static const columnPlaceName = 'p_type';
  static const columnPlaceUser = 'user';

  static const _floorTableName = 'floorTable';
  static const columnFloorId = 'f_id';
  static const columnFloorName = 'f_name';
  static const columnFloorUser = 'user';

  static const _flatTableName = 'flatTable';
  static const columnFlatName = 'flt_name';
  static const columnFlatId = 'flt_id';
  static const columnFlatUser = 'user';

  static const _roomTableName = 'roomTable';
  static const columnRoomName = 'r_name';
  static const columnRoomId = 'r_id';
  static const columnRoomUser = 'user';

  static const _deviceTable = 'deviceTable';
  static const columnDeviceId = 'd_id';
  static const columnDeviceUser = 'user';
  static const columnDeviceRoomId = 'r_id';

  static const _tempUserTable = 'tempUserTable';
  static const columnTempUserMobile = 'mobile';
  static const columnTempUserEmail = 'email';
  static const columnTempUserName = 'name';
  static const columnTempUserDate = 'date';
  static const columnTempUserTiming = 'timing';
  static const columnTempUserPlaceId = 'p_id';
  static const columnTempUserFloorId = 'f_id';
  static const columnTempUserFlatId = 'flt_id';
  static const columnTempUserRoomId = 'r_id';
  static const columnTempUserDeviceId = 'd_id';

  static const _devicePinNames = 'devicePinNamesValues';
  static const columnDevicePinId = 'id';
  static const pin1Name = 'pin1Name';
  static const pin2Name = 'pin2Name';
  static const pin3Name = 'pin3Name';
  static const pin4Name = 'pin4Name';
  static const pin5Name = 'pin5Name';
  static const pin6Name = 'pin6Name';
  static const pin7Name = 'pin7Name';
  static const pin8Name = 'pin8Name';
  static const pin9Name = 'pin9Name';
  static const pin10Name = 'pin10Name';
  static const pin11Name = 'pin11Name';
  static const pin12Name = 'pin12Name';
  static const pin13Name = 'pin13Name';
  static const pin14Name = 'pin14Name';
  static const pin15Name = 'pin15Name';
  static const pin16Name = 'pin16Name';
  static const pin17Name = 'pin17Name';
  static const pin18Name = 'pin18Name';
  static const pin19Name = 'pin19Name';
  static const pin20Name = 'pin20Name';

  static const _devicePinStatus = 'devicePinStatus';
  static const columnDevicePinStatusId = 'id';
  static const pin1Status = 'pin1Status';
  static const pin2Status = 'pin2Status';
  static const pin3Status = 'pin3Status';
  static const pin4Status = 'pin4Status';
  static const pin5Status = 'pin5Status';
  static const pin6Status = 'pin6Status';
  static const pin7Status = 'pin7Status';
  static const pin8Status = 'pin8Status';
  static const pin9Status = 'pin9Status';
  static const pin10Status = 'pin10Status';
  static const pin11Status = 'pin11Status';
  static const pin12Status = 'pin12Status';
  static const pin13Status = 'pin13Status';
  static const pin14Status = 'pin14Status';
  static const pin15Status = 'pin15Status';
  static const pin16Status = 'pin16Status';
  static const pin17Status = 'pin17Status';
  static const pin18Status = 'pin18Status';
  static const pin19Status = 'pin19Status';
  static const pin20Status = 'pin20Status';

  static const _sensorTable = 'sensorTable';
  static const sensorId = 'id';
  static const sensor1 = 'sensor1';
  static const sensor2 = 'sensor2';
  static const sensor3 = 'sensor3';
  static const sensor4 = 'sensor4';
  static const sensor5 = 'sensor5';
  static const sensor6 = 'sensor6';
  static const sensor7 = 'sensor7';
  static const sensor8 = 'sensor8';
  static const sensor9 = 'sensor9';
  static const sensor10 = 'sensor10';

  static const _subUserTable = 'subUserTable';
  static const ownerName = 'owner_name';
  static const name = 'name';
  static const user = 'user';
  static const emailSubUser = 'email';
  static const p_id = 'p_id';
  static const id = 'id';

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
         CREATE TABLE $_userDetails (  $email TEXT NOT NULL,
         $first_name TEXT NOT NULL,$last_name TEXT NOT NULL, $columnUserName TEXT, $columnUserPhoneNumber INTEGER,$columnUserPassword TEXT,
         $columnUserPassword2 TEXT   )
         ''');

      await db.execute('''
         CREATE TABLE $_subUserTable (  $emailSubUser TEXT NOT NULL,
         $ownerName TEXT NOT NULL,$name TEXT NOT NULL, $user INTEGER, $p_id INTEGER,$id INTEGER  )
         ''');

      await db.execute('''
         CREATE TABLE $_placeTableName (  $columnPlaceId INTEGER PRIMARY KEY,
         $columnPlaceName TEXT NOT NULL,$columnPlaceUser INTEGER )
         ''');
      await db.execute('''
        CREATE TABLE $_floorTableName($columnFloorId INTEGER NOT NULL PRIMARY KEY , $columnFloorName TEXT NOT NULL ,$columnPlaceId INTEGER,$columnFloorUser INTEGER,FOREIGN KEY($columnFloorId) REFERENCES $_placeTableName ($columnPlaceId ));
        ''');
      await db.execute('''
        CREATE TABLE $_flatTableName($columnFlatId INTEGER NOT NULL PRIMARY KEY , $columnFlatName TEXT NOT NULL ,$columnFloorId INTEGER,$columnFlatUser INTEGER,FOREIGN KEY($columnFlatId) REFERENCES $_floorTableName ($columnFloorId ));
        ''');
      await db.execute('''
        CREATE TABLE $_roomTableName(   $columnRoomId INTEGER NOT NULL PRIMARY KEY , $columnRoomName TEXT NOT NULL ,$columnFlatId INTEGER,$columnRoomUser INTEGER,FOREIGN KEY($columnRoomId) REFERENCES $_flatTableName ($columnFlatId ))
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
      //   await db.execute('''
      // CREATE TABLE $_tempUserTable(   $columnTempUserMobile TEXT NOT  , $columnTempUserEmail TEXT NOT NULL ,$columnTempUserName TEXT,$columnTempUserDate TEXT,
      //   $columnTempUserTiming TEXT, $columnTempUserPlaceId TEXT,$columnTempUserFloorId TEXT,$columnTempUserFlatId TEXT,$columnTempUserRoomId TEXT,$columnTempUserDeviceId TEXT,)
      // ''');
    });
    return database;
  }

  var qq;

  // Define a function that inserts Data into the database

  Future<void> insertUserDetailsModelData(User user) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_userDetails',
      user.toJson(),
    );
    if (_userDetails == null) {
    } else {
      return;
    }
  }

  Future<void> insertPlaceModelData(PlaceType placeType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_placeTableName',
      placeType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSubUserModelData(SubAccessPage subAccessPage) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserTable',
      subAccessPage.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteSubUserModelData() async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      '$_subUserTable',
    );
  }

  Future<void> updateSubUserModelData(SubAccessPage subAccessPage) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      '$_subUserTable',
      subAccessPage.toJson(),
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

  Future<void> insertFlatModelData(Flat flat) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_flatTableName',
      flat.toJson(),
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

  Future<void> insertTempUserData(TempUser tempUser) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_tempUserTable',
      tempUser.toJson(),
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

  Future<void> deleteDeviceModel() async {
    final db = await database;
    print('delete');
    await db.delete(_deviceTable);
  }

  Future deleteRoomModel() async {
    final db = await database;
    print('delete');
    await db.delete(_roomTableName);
  }

  Future<void> deleteFloorModel() async {
    final db = await database;
    print('delete');
    await db.delete(_floorTableName);
  }

  Future<void> deleteFlatModel() async {
    final db = await database;
    print('delete');
    await db.delete(_flatTableName);
  }

  Future<void> deletePlaceModel() async {
    final db = await database;
    print('delete');
    await db.delete(_placeTableName);
  }

  userQuery() async {
    Database db = await instance.database;

    return await db.query(_userDetails);
  }


  queryTempUser() async {
    Database db = await instance.database;

    return await db.query(_tempUserTable);
  }
  
  queryPlace() async {
    Database db = await instance.database;
    return await db.query(_placeTableName);
  }

  queryFloor() async {
    Database db = await instance.database;

    return await db.query(_floorTableName);
  }

  queryFlat() async {
    Database db = await instance.database;

    return await db.query(_flatTableName);
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

  querySubUser() async {
    Database db = await instance.database;

    return await db.query(_subUserTable);
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

  Future getFlatByFId(String id) async {
    final db = await database;
    var result =
        await db.query("flatTable", where: "f_id = ? ", whereArgs: [id]);
    print('FlatResult $result');

    return result;
  }

  Future getRoomById(String id) async {
    final db = await database;
    var result =
        await db.query("roomTable", where: "flt_id = ? ", whereArgs: [id]);
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

  List<Device> dvdata;
  Future<List<Device>> getDeviceByRoomId(String id) async {
    final db = await database;
    List result =
        await db.query("deviceTable", where: "r_id = ? ", whereArgs: [id]);
    print('DeviceChanges $result');
    dvdata = List.generate(
        result.length,
        (index) => Device(
              dId: result[index]['d_id'].toString(),
              rId: result[index]['r_id'].toString(),
              user: result[index]['user'],
            ));

    // dvdata = result.map((data) => Device.fromJson(data)).toList();

    return dvdata;
  }

  Future updatePLaceNameLocal(PlaceType placeType) async {
    final db = await database;
    var result = await db.update(
      '$_placeTableName',
      placeType.toJson(),
      where: 'p_type = ?',
      whereArgs: [placeType.pType],
    );
    return result;
  }

  Future updatePinStatusData(PinStatus pinStatus) async {
    var db = await database;
    return db.update('$_devicePinStatus', pinStatus.toJson());
  }

  Future updateRoom(RoomType roomType) async {
    var db = await database;
    return db.update('$_roomTableName', roomType.toJson());
  }

  Future updateFloor(FloorType floorType) async {
    var db = await database;
    return db.update('$_floorTableName', floorType.toJson());
  }

  Future updatePlace(PlaceType placeType) async {
    var db = await database;
    return db.update('$_placeTableName', placeType.toJson());
  }

  Future updateFlat(Flat flat) async {
    var db = await database;
    return db.update('$_flatTableName', flat.toJson());
  }

  Future updateDevice(Device device) async {
    var db = await database;
    return db.update('$_deviceTable', device.toJson());
  }

  Future updateSensorData(SensorData sensorData) async {
    var db = await database;
    return db.update('$_sensorTable', sensorData.toJson());
  }

  Future updatePinName(DevicePin devicePin) async {
    var db = await database;
    return db.update('$_devicePinNames', devicePin.toJson());
  }

  Future getPinNamesByDeviceId(String id) async {
    final db = await database;
    var result = await db
        .query("devicePinNamesValues", where: "d_id = ? ", whereArgs: [id]);
    print('PinNameResultName $result');
    // return result.isNotEmpty?result.first:Null;
    return result;
  }

  Future getPinStatusByDeviceId(String id) async {
    final db = await database;
    var result =
        await db.query("devicePinStatus", where: "d_id = ? ", whereArgs: [id]);
    print('PinStatusResult $result');
    // return result.isNotEmpty?result.first:Null;
    return result;
  }

  Future getSensorByDeviceId(String id) async {
    final db = await database;
    var result =
        await db.query("sensorTable", where: "d_id = ? ", whereArgs: [id]);
    print('PinNameResult $result');
    // return result.isNotEmpty?result.first:Null;
    return result;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future delete() async {
    var db = await instance.database;
    int result = await db.rawDelete(
        'DELETE FROM $_devicePinStatus WHERE $pin1Status,$pin2Status,$pin3Status,$pin4Status,$pin5Status,$pin6Status,$pin7Status,$pin8Status,$pin9Status,$pin10Status,$pin11Status,$pin12Status,$pin13Status,$pin14Status,$pin15Status,$pin16Status,$pin17Status,$pin18Status,$pin19Status,$pin20Status');
    print('delete $result');
    return result;
  }

  Future<void> cleanDatabase() async {
    try {
      var db = await instance.database;
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(_userDetails);
        batch.delete(_placeTableName);
        batch.delete(_floorTableName);
        batch.delete(_roomTableName);
        batch.delete(_deviceTable);
        batch.delete(_devicePinNames);
        batch.delete(_sensorTable);
        batch.delete(_subUserTable);
        batch.delete(_devicePinStatus);
        var deleteDataUser = await batch.commit();
        print('deletedataUser $deleteDataUser');
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
}
