import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

Database subUserDatabase;

class SubUserDataBase{
  SubUserDataBase._privateConstructor();
  static final SubUserDataBase instance = SubUserDataBase._privateConstructor();

  static final _subUserPlaceTableName = 'subUserPlaceTable';
  static final subUserColumnPlaceId = 'subUser_p_id';
  static final subUserColumnPlaceName = 'subUser_p_type';
  static final subUserColumnPlaceUser = 'subUser_user';

  static final _subUserFloorTableName = 'subUser_floorTable';
  static final subUserColumnFloorId = 'subUser_f_id';
  static final subUserColumnFloorName = 'subUser_f_name';
  static final subUserColumnFloorUser = 'subUser_user';

  static final _subUserFlatTableName = 'subUser_flatTable';
  static final subUserColumnFlatName = 'subUser_flt_name';
  static final subUserColumnFlatId = 'subUser_flt_id';
  static final subUserColumnFlatUser = 'subUser_user';


  static final _subUserRoomTableName = 'subUser_roomTable';
  static final subUserColumnRoomName = 'subUser_r_name';
  static final subUserColumnRoomId = 'subUser_r_id';
  static final subUserColumnRoomUser = 'subUser_user';

  static final _subUserdeviceTable = 'subUser_deviceTable';
  static final subUserColumnDeviceId = 'subUser_d_id';
  static final subUserColumnDeviceUser = 'subUser_user';
  static final subUserColumnDeviceRoomId = 'subUser_r_id';


  static final _subUserdevicePinNames = 'devicePinNamesValues';
  static final subUserColumnDevicePinId = 'id';
  static final subUserPin1Name = 'subUserPin1Name';
  static final subUserPin2Name = 'subUserPin2Name';
  static final subUserPin3Name = 'subUserPin3Name';
  static final subUserPin4Name = 'subUserPin4Name';
  static final subUserPin5Name = 'subUserPin5Name';
  static final subUserPin6Name = 'subUserPin6Name';
  static final subUserPin7Name = 'subUserPin7Name';
  static final subUserPin8Name = 'subUserPin8Name';
  static final subUserPin9Name = 'subUserPin9Name';
  static final subUserPin10Name = 'subUserPin10Name';
  static final subUserPin11Name = 'subUserPin11Name';
  static final subUserPin12Name = 'subUserPin12Name';
  static final subUserPin13Name = 'subUserPin13Name';
  static final subUserPin14Name = 'subUserPin14Name';
  static final subUserPin15Name = 'subUserPin15Name';
  static final subUserPin16Name = 'subUserPin16Name';
  static final subUserPin17Name = 'subUserPin17Name';
  static final subUserPin18Name = 'subUserPin18Name';
  static final subUserPin19Name = 'subUserPin19Name';
  static final subUserPin20Name = 'subUserPin20Name';


  static final _subUserDevicePinStatus = 'devicePinStatus';
  static final subUserColumnDevicePinStatusId = 'id';
  static final subUserPin1Status = 'subUserPin1Status';
  static final subUserPin2Status = 'subUserPin2Status';
  static final subUserPin3Status = 'subUserPin3Status';
  static final subUserPin4Status = 'subUserPin4Status';
  static final subUserPin5Status = 'subUserPin5Status';
  static final subUserPin6Status = 'subUserPin6Status';
  static final subUserPin7Status = 'subUserPin7Status';
  static final subUserPin8Status = 'subUserPin8Status';
  static final subUserPin9Status = 'subUserPin9Status';
  static final subUserPin10Status = 'subUserPin10Status';
  static final subUserPin11Status = 'subUserPin11Status';
  static final subUserPin12Status = 'subUserPin12Status';
  static final subUserPin13Status = 'subUserPin13Status';
  static final subUserPin14Status = 'subUserPin14Status';
  static final subUserPin15Status = 'subUserPin15Status';
  static final subUserPin16Status = 'subUserPin16Status';
  static final subUserPin17Status = 'subUserPin17Status';
  static final subUserPin18Status = 'subUserPin18Status';
  static final subUserPin19Status = 'subUserPin19Status';
  static final subUserPin20Status = 'subUserPin20Status';


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
  }

}