import 'package:loginsignspaceorion/ModelsForSubUser/allmodels.dart';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

Database subUserDatabase;

class SubUserDataBase{
  SubUserDataBase._privateConstructor();
  static final SubUserDataBase subUserInstance = SubUserDataBase._privateConstructor();

  static final _subUserPlaceTableName = 'subUserPlaceTable';
  static final subUserColumnPlaceId = 'p_id';
  static final subUserColumnPlaceName = 'p_type';
  static final subUserColumnPlaceUser = 'user';

  static final _subUserFloorTableName = 'subUserFloorTable';
  static final subUserColumnFloorId = 'f_id';
  static final subUserColumnFloorName = 'f_name';
  static final subUserColumnFloorUser = 'user';

  static final _subUserFlatTableName = 'subUserFlatTable';
  static final subUserColumnFlatName = 'flt_name';
  static final subUserColumnFlatId = 'flt_id';
  static final subUserColumnFlatUser = 'user';


  static final _subUserRoomTableName = 'subUserRoomTable';
  static final subUserColumnRoomName = 'r_name';
  static final subUserColumnRoomId = 'r_id';
  static final subUserColumnRoomUser = 'user';

  static final _subUserdeviceTable = 'subUserDeviceTable';
  static final subUserColumnDeviceId = 'd_id';
  static final subUserColumnDeviceUser = 'user';
  static final subUserColumnDeviceRoomId = 'r_id';


  static final _subUserdevicePinNames = 'devicePinNamesValues';
  static final subUserColumnDevicePinId = 'id';
  static final subUserPin1Name = 'pin1Name';
  static final subUserPin2Name = 'pin2Name';
  static final subUserPin3Name = 'pin3Name';
  static final subUserPin4Name = 'pin4Name';
  static final subUserPin5Name = 'pin5Name';
  static final subUserPin6Name = 'pin6Name';
  static final subUserPin7Name = 'pin7Name';
  static final subUserPin8Name = 'pin8Name';
  static final subUserPin9Name = 'pin9Name';
  static final subUserPin10Name = 'pin10Name';
  static final subUserPin11Name = 'pin11Name';
  static final subUserPin12Name = 'pin12Name';
  static final subUserPin13Name = 'pin13Name';
  static final subUserPin14Name = 'pin14Name';
  static final subUserPin15Name = 'pin15Name';
  static final subUserPin16Name = 'pin16Name';
  static final subUserPin17Name = 'pin17Name';
  static final subUserPin18Name = 'pin18Name';
  static final subUserPin19Name = 'pin19Name';
  static final subUserPin20Name = 'pin20Name';


  static final _subUserDevicePinStatus = 'devicePinStatus';
  static final subUserColumnDevicePinStatusId = 'id';
  static final subUserPin1Status = 'pin1Status';
  static final subUserPin2Status = 'pin2Status';
  static final subUserPin3Status = 'pin3Status';
  static final subUserPin4Status = 'pin4Status';
  static final subUserPin5Status = 'pin5Status';
  static final subUserPin6Status = 'pin6Status';
  static final subUserPin7Status = 'pin7Status';
  static final subUserPin8Status = 'pin8Status';
  static final subUserPin9Status = 'pin9Status';
  static final subUserPin10Status = 'pin10Status';
  static final subUserPin11Status = 'pin11Status';
  static final subUserPin12Status = 'pin12Status';
  static final subUserPin13Status = 'pin13Status';
  static final subUserPin14Status = 'pin14Status';
  static final subUserPin15Status = 'pin15Status';
  static final subUserPin16Status = 'pin16Status';
  static final subUserPin17Status = 'pin17Status';
  static final subUserPin18Status = 'pin18Status';
  static final subUserPin19Status = 'pin19Status';
  static final subUserPin20Status = 'pin20Status';


  static final _subUserSensorTable = 'sensorTable';
  static final subUserSensorId = 'id';
  static final subUserSensor1 = 'sensor1';
  static final subUserSensor2 = 'sensor2';
  static final subUserSensor3 = 'sensor3';
  static final subUserSensor4 = 'sensor4';
  static final subUserSensor5 = 'sensor5';
  static final subUserSensor6 = 'sensor6';
  static final subUserSensor7 = 'sensor7';
  static final subUserSensor8 = 'sensor8';
  static final subUserSensor9 = 'sensor9';
  static final subUserSensor10 = 'sensor10';
  Directory directory;



  Future<Database> get database async {
    if (subUserDatabase != null) {
      return subUserDatabase;
    } else {
      subUserDatabase = await initiateDatabase();
      return subUserDatabase;
    }
  }

  initiateDatabase() async{
    directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "subUserPlaceTable.db");
    var database= await openDatabase(path,version: 1,onCreate: (db,version)async{
      await db.execute('''
         CREATE TABLE $_subUserPlaceTableName (  $subUserColumnPlaceId INTEGER PRIMARY KEY,
         $subUserColumnPlaceName TEXT NOT NULL,$subUserColumnPlaceUser INTEGER )
         ''');

      await db.execute('''
        CREATE TABLE $_subUserFloorTableName($subUserColumnFloorId INTEGER NOT NULL PRIMARY KEY , $subUserColumnFloorName TEXT NOT NULL ,$subUserColumnPlaceId INTEGER,$subUserColumnFloorUser INTEGER,FOREIGN KEY($subUserColumnFloorId) REFERENCES $_subUserPlaceTableName ($subUserColumnPlaceId ));
        ''');

      await db.execute('''
        CREATE TABLE $_subUserFlatTableName($subUserColumnFlatId INTEGER NOT NULL PRIMARY KEY , $subUserColumnFlatName TEXT NOT NULL ,$subUserColumnFloorId INTEGER,$subUserColumnFlatUser INTEGER,FOREIGN KEY($subUserColumnFlatId) REFERENCES $_subUserFloorTableName ($subUserColumnFloorId ));
        ''');


      await db.execute('''
        CREATE TABLE $_subUserRoomTableName( $subUserColumnRoomId INTEGER NOT NULL PRIMARY KEY , $subUserColumnRoomName TEXT NOT NULL ,$subUserColumnFlatId INTEGER,$subUserColumnRoomUser INTEGER,FOREIGN KEY($subUserColumnRoomId) REFERENCES $_subUserFlatTableName ($subUserColumnFlatId ))
        ''');

      await db.execute('''
        CREATE TABLE $_subUserdeviceTable( $subUserColumnDeviceUser INTEGER , $subUserColumnRoomId INTEGER NOT NULL , $subUserColumnDeviceId TINYTEXT PRIMARY KEY ,FOREIGN KEY($subUserColumnDeviceId) REFERENCES $_subUserRoomTableName($subUserColumnRoomId))
        ''');


      await db.execute('''
        CREATE TABLE $_subUserdevicePinNames( $subUserColumnDeviceId TINYTEXT, $subUserColumnDevicePinId INTEGER , $subUserPin1Name TEXT , $subUserPin2Name TEXT NOT NULL , $subUserPin3Name TEXT  ,$subUserPin4Name TEXT,$subUserPin5Name TEXT,$subUserPin6Name TEXT,$subUserPin7Name TEXT,$subUserPin8Name TEXT,$subUserPin9Name TEXT,$subUserPin10Name TEXT,$subUserPin11Name TEXT,$subUserPin12Name TEXT,$subUserPin13Name TEXT,$subUserPin14Name TEXT,$subUserPin15Name TEXT,$subUserPin16Name TEXT,$subUserPin17Name TEXT,$subUserPin18Name TEXT,$subUserPin19Name TEXT,$subUserPin20Name TEXT,FOREIGN KEY($subUserPin1Name) REFERENCES $_subUserdeviceTable($subUserColumnDeviceId))
        ''');

      await db.execute('''
        CREATE TABLE $_subUserDevicePinStatus( $subUserColumnDeviceId TINYTEXT, $subUserColumnDevicePinStatusId INTEGER , $subUserPin1Status INTEGER , $subUserPin2Status INTEGER NOT NULL , $subUserPin3Status INTEGER  ,$subUserPin4Status INTEGER,$subUserPin5Status INTEGER,$subUserPin6Status INTEGER,$subUserPin7Status INTEGER,$subUserPin8Status INTEGER,$subUserPin9Status INTEGER,$subUserPin10Status INTEGER,$subUserPin11Status INTEGER,$subUserPin12Status INTEGER,$subUserPin13Status INTEGER,$subUserPin14Status INTEGER,$subUserPin15Status INTEGER,$subUserPin16Status INTEGER,$subUserPin17Status INTEGER,$subUserPin18Status INTEGER,$subUserPin19Status INTEGER,$subUserPin20Status INTEGER,FOREIGN KEY($subUserPin1Status) REFERENCES $_subUserdeviceTable($subUserColumnDeviceId))
        ''');

      await db.execute('''
        CREATE TABLE $_subUserSensorTable( $subUserColumnDeviceId TINYTEXT,$subUserSensor1 FLOAT ,$subUserSensorId INTEGER , $subUserSensor2 FLOAT ,$subUserSensor3 FLOAT,$subUserSensor4 FLOAT,$subUserSensor5 FLOAT ,$subUserSensor6 FLOAT ,$subUserSensor7 FLOAT,$subUserSensor8 FLOAT,$subUserSensor9 FLOAT,$subUserSensor10 FLOAT,FOREIGN KEY($subUserColumnDeviceId) REFERENCES $_subUserdeviceTable($subUserColumnDeviceId))
        ''');

    });
    return database;
  }
  Future<void> insertPlaceModelData(SubUserPlaceType placeType) async {
    // Get a reference to the database.
    final db = await database;

    await db.insert(
      '$_subUserPlaceTableName',
      placeType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );


  }
  Future allPlaceModelData() async {
    // Get a reference to the database.
    final db = await database;

    await db.query(
      '$_subUserPlaceTableName',
    );

  }

  Future<void> insertSubUserFloorModelData(SubUserFloorType floorType) async {
    // Get a reference to the database.
    final db = await database;

    await db.insert(
      '$_subUserFloorTableName',
      floorType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }
  Future<void> insertSubUserFlatModelData(SubUserFlatType flat) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserFlatTableName',
      flat.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> insertSubUserRoomModelData(SubUserRoomType roomType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserRoomTableName',
      roomType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertSubUserDeviceModelData(SubUserDeviceType subUserDeviceType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserdeviceTable',
      subUserDeviceType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertSubUserDevicePinStatusData(PinStatusSubUser subUserDeviceType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserDevicePinStatus',
      subUserDeviceType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> updateSubUserDevicePinStatusData(PinStatusSubUser subUserDeviceType) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      '$_subUserDevicePinStatus',
      subUserDeviceType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getDeviceByRId(String id) async {
    final db = await database;
    var result =
    await db.query("subUserDeviceTable", where: "r_id = ? ", whereArgs: [id]);
    print('DeviceChanges $result');

    return result;
  }
  Future<void> insertSubUserDevicePinNames(SubUserDevicePinNameType subUserDevicePinNameType) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserdevicePinNames',
      subUserDevicePinNameType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> updateSubUserDevicePinNames(SubUserDevicePinNameType subUserDevicePinNameType) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      '$_subUserdevicePinNames',
      subUserDevicePinNameType.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertSubUserSensor(SubUserSensorData subUserSensorData) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      '$_subUserSensorTable',
      subUserSensorData.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future getSensorByDeviceId(String id) async{
    final db =await database;
    var result= db.query("sensorTable",where: "d_id =? ",whereArgs: [id]);
    print('sensorResult ${result}');
    return result;
  }
  List <SubUserDeviceType>dvdata;
  Future<List<SubUserDeviceType>> getDeviceByRoomId(String id) async {
    final db = await database;
    List result =
    await db.query("subUserDeviceTable", where: "r_id = ? ", whereArgs: [id]);
    print('DeviceChanges $result');
    dvdata=List.generate(result.length, (index) =>SubUserDeviceType(
      dId: result[index]['d_id'].toString(),
      rId: result[index]['r_id'].toString(),
      user: result[index]['user'],
    ));
    print('DeviceChanges12 $dvdata');
    // dvdata = result.map((data) => SubUserDeviceType.fromJson(data)).toList();


    return dvdata;
  }





  Future queryPlaceSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserPlaceTableName);
  }
  queryFloorSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserFloorTableName);
  }
  queryFlatSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserFlatTableName);
  }
  queryRoomSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserRoomTableName);
  }
  queryDeviceSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserdeviceTable);
  }
  queryDevicePinStatusSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserDevicePinStatus);
  }
  queryDevicePinNamesSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserdevicePinNames);
  }
  queryDeviceSensorSubUser() async {
    Database db = await subUserInstance.database;

    return await db.query(_subUserSensorTable);
  }
  Future getFloorById(String id) async {
    final db = await database;
    var result =
    await db.query("subUserFloorTable", where: "p_id = ? ", whereArgs: [id]);
    print('result $result');

    return result;
  }



  Future getFlatById(String id) async {
    final db = await database;
    var result =
    await db.query("subUserFlatTable", where: "f_id = ? ", whereArgs: [id]);
    print('result $result');

    return result;
  }
  Future getRoomById(String id) async {
    final db = await database;
    var result =
    await db.query("subUserRoomTable", where: "flt_id = ? ", whereArgs: [id]);
    print('result $result');

    return result;
  }

}