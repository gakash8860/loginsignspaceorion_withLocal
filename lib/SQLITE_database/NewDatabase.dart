import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../main.dart';

Database dataBase;
List tableOfPlace;

class NewDbProvider {
  NewDbProvider._privateConstructor();

  PlaceType placeType;
  static final NewDbProvider instance = NewDbProvider._privateConstructor();

  static final _userDetails = 'userDetails';
  static final email = 'email';
  static final first_name = 'first_name';
  static final last_name = 'last_name';
  static final columnUserName = 'username';
  static final columnUserPassword = 'password1';
  static final columnUserPassword2 = 'password2';
  static final columnUserPhoneNumber = 'phone_no';

  static final _tableName = 'placeTable';
  static final columnPlaceId = 'p_id';
  static final columnPlaceName = 'p_type';
  static final columnPlaceUser = 'user';

  static final _floorTableName = 'floorTable';
  static final columnFloorId = 'f_id';
  static final columnFloorName = 'f_name';
  static final columnFloorUser = 'user';

  static final _flatTableName = 'flatTable';
  static final columnFlatName = 'flt_name';
  static final columnFlatId = 'flt_id';
  static final columnFlatUser = 'user';


  static final _roomTableName = 'roomTable';
  static final columnRoomName = 'r_name';
  static final columnRoomId = 'r_id';
  static final columnRoomUser = 'user';

  static final _deviceTable = 'deviceTable';
  static final columnDeviceId = 'd_id';
  static final columnDeviceUser = 'user';
  static final columnDeviceRoomId = 'r_id';

  static final _tempUserTable = 'tempUserTable';
  static final columnTempUserMobile = 'mobile';
  static final columnTempUserEmail = 'email';
  static final columnTempUserName = 'name';
  static final columnTempUserDate = 'date';
  static final columnTempUserTiming = 'timing';
  static final columnTempUserPlaceId = 'p_id';
  static final columnTempUserFloorId = 'f_id';
  static final columnTempUserFlatId = 'flt_id';
  static final columnTempUserRoomId = 'r_id';
  static final columnTempUserDeviceId = 'd_id';


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
         CREATE TABLE $_tableName (  $columnPlaceId INTEGER PRIMARY KEY,
         $columnPlaceName TEXT NOT NULL,$columnPlaceUser INTEGER )
         ''');
        await db.execute('''
        CREATE TABLE $_floorTableName($columnFloorId INTEGER NOT NULL PRIMARY KEY , $columnFloorName TEXT NOT NULL ,$columnPlaceId INTEGER,$columnFloorUser INTEGER,FOREIGN KEY($columnFloorId) REFERENCES $_tableName ($columnPlaceId ));
        ''');
          await db.execute('''
        CREATE TABLE $_flatTableName($columnFlatId INTEGER NOT NULL PRIMARY KEY , $columnFlatName TEXT NOT NULL ,$columnFloorId INTEGER,$columnFlatUser INTEGER,FOREIGN KEY($columnFlatId) REFERENCES $_tableName ($columnFloorId ));
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
    if(_userDetails==null){

    }else{
      return;
    }



  }

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

  userQuery() async {
    Database db = await instance.database;

    return await db.query(_userDetails);
  }
  queryPlace() async {
    Database db = await instance.database;

    return await db.query(_tableName);
  }
  queryTempUser() async {
    Database db = await instance.database;

    return await db.query(_tempUserTable);
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
  Future<List<Device>> getDeviceByRoomId(String id) async {
    final db = await database;
    List result =
    await db.query("deviceTable", where: "r_id = ? ", whereArgs: [id]);
    print('DeviceChanges $result');
    dvdata=List.generate(result.length, (index) =>Device(
      dId: result[index]['d_id'].toString(),
      rId: result[index]['r_id'].toString(),
      user: result[index]['user'],
    ));
    print('DeviceChanges12 $dvdata');
    // dvdata = result.map((data) => Device.fromJson(data)).toList();


    return dvdata;
  }
  Future updatePLaceNameLocal(PlaceType placeType) async {
    final db = await database;
     var result = await db.update('$_tableName', placeType.toJson(),
      where: 'p_id = ?',
      whereArgs: [placeType.pType],
    );
  return result;
  }

  Future updatePinStatusData(PinStatus pinStatus)async{
    var db = await database;
    return db.update('$_devicePinStatus', pinStatus.toJson());
  }

  Future updateRoom(RoomType roomType)async{
    var db = await database;
    return db.update('$_roomTableName', roomType.toJson());
  }
  Future updateSensorData(SensorData sensorData)async{
    var db = await database;
    return db.update('$_sensorTable', sensorData.toJson());
  }
  Future updatePinName(DevicePin devicePin)async{
    var db = await database;
    return db.update('$_devicePinNames', devicePin.toJson());
  }
  Future getPinNamesByDeviceId(String id) async {
    final db = await database;
    var result =
    await db.query("devicePinNamesValues", where: "d_id = ? ", whereArgs: [id]);
    print('PinNameResultName $result');
    // return result.isNotEmpty?result.first:Null;
    return result;}



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

  Future close()async{
    final db= await instance.database;
    db.close();
  }
  Future delete()async{
    var db= await instance.database;
    int result = await db.rawDelete('DELETE FROM $_devicePinStatus WHERE $pin1Status,$pin2Status,$pin3Status,$pin4Status,$pin5Status,$pin6Status,$pin7Status,$pin8Status,$pin9Status,$pin10Status,$pin11Status,$pin12Status,$pin13Status,$pin14Status,$pin15Status,$pin16Status,$pin17Status,$pin18Status,$pin19Status,$pin20Status');
    print('delete $result');
    return result;
  }

}
