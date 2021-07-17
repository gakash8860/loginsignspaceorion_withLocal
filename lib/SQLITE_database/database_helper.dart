import 'dart:io';
import 'package:loginsignspaceorion/models/modeldefine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tabeleName = 'myTable';
  static final columnPlaceId = 'PlaceId';
  static final columnPlaceName = 'PlaceName';
  static final columnFloorName = 'FloorName';
  static final columnFloorId = 'FloorId';
  static final columnRoomId = 'RoomId';
  static final columnDeviceId = 'DeviceId';
  static final columnRoomName = 'RoomName';
  static final columnDeviceStatus = 'DeviceStatus';
  static final columnDeviceIpAddress = 'DeviceIpAddress';
  static DatabaseHelper databaseHelper ;
  DatabaseHelper._createInstance();
  static Database _dataBase;
  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper._createInstance();
    }
    return databaseHelper;
  }

  // static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  Future<Database> get database async {
    if (_dataBase != null) {
      return database;
    } else {
      _dataBase = await initiateDatabase();
      return _dataBase;
    }
  }

  Future<Database> initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    var database=   await openDatabase(path, version: _dbVersion, onCreate: (db, version){
      db.execute('''
         CREATE TABLE $_tabeleName(
           $columnPlaceId INTEGER ,
           $columnFloorId INTEGER,
           $columnRoomId INTEGER ,
           $columnDeviceId INTEGER PRIMARY KEY,
         $columnPlaceName TEXT NOT NULL, 
         $columnFloorName TEXT NOT NULL, 
         $columnRoomName TEXT NOT NULL, 
         $columnDeviceStatus TEXT NOT NULL, )
         ''');
    });
    return database;
  }

  // ignore: missing_return
  Future _onCreate(Database db, int version) {
    db.query('''
         CREATE TABLE $_tabeleName(
           $columnPlaceId INTEGER PRIMARY KEY,
           $columnFloorId INTEGER ,
           $columnRoomId INTEGER ,
           $columnDeviceId INTEGER ,
         $columnPlaceName TEXT NOT NULL, 
         $columnFloorName TEXT NOT NULL, 
         $columnRoomName TEXT NOT NULL, 
         $columnDeviceStatus TEXT NOT NULL, 
         ''');
  }

  // ignore: missing_return
  // Future <int> insert(Map<String, dynamic>row) async {
  //   Database db = await instance.database;
  //   await db.insert(_tabeleName, row);
  // }


  insertPlaceData(PlaceType placeType) async {
    var db = await this.database;
    var result = await db.insert(_tabeleName, placeType.toJson());
    return result;
  }

  insertFloorData(FloorType floorType) async {
    var db = await this.database;
    var result = await db.insert(_tabeleName, floorType.toJson());
    return result;
  }

  insertRoomData(RoomType roomType) async {
    var db = await this.database;
    var result = await db.insert(_tabeleName, roomType.toJson());
    return result;
  }

  insertDeviceData(Device device) async {
    var db = await this.database;
    var result = await db.insert(_tabeleName, device.toJson());
    return result;
  }

  Future<List<PlaceType>> getPlaceData() async {
    List<PlaceType> _places = [];
    var db = await this.database;
    var result = await db.query(_tabeleName);
    result.forEach((element) {
      var placeInfo = PlaceType.fromJson(element);
      placeInfo.toString();
    });
    return _places;
  }


  Future<List<FloorType>> getFloorData() async {
    List<FloorType> _floor = [];
    var db = await this.database;
    var result = await db.query(_tabeleName);
    result.forEach((element) {
      var floorInfo = FloorType.fromJson(element);
      floorInfo.toString();
    });
    return _floor;
  }

  Future<List<RoomType>> getRoomData() async {
    List<RoomType> room = [];
    var db = await this.database;
    var result = await db.query(_tabeleName);
    result.forEach((element) {
      var roomInfo = RoomType.fromJson(element);
      roomInfo.toString();
    });
    return room;
  }

  Future<List<Device>> getDeviceData() async {
    List<Device> device = [];
    var db = await this.database;
    var result = await db.query(_tabeleName);
    result.forEach((element) {
      var deviceInfo = Device.fromJson(element);
      deviceInfo.toString();
    });
    return device;
  }
}