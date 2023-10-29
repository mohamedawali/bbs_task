
import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/DocumentModel.dart';
import '../constant/dbConstant.dart';

class DbHelper {
 static final DbHelper dbHelper= DbHelper._getInstance();
  factory  DbHelper(){

    return dbHelper;
  }
 DbHelper._getInstance(){

 }
  Future getMyDatabasePath() async {
    String path = await getDatabasesPath();

    return join(path, dbName);
  }

  Future<Database> getMyDatabaseInstance() async {
    print('111');
    String filepath = await getMyDatabasePath();
    return openDatabase(
      filepath,
      version: dbVersion,
      onCreate: (db, version) => onCreate(db),
      onUpgrade: (db, oldVersion, newVersion) => onUpgrade(db),
    );
  }

  onCreate(Database db) async {
    print('22');
    String itemTable =
        ' create table $itemTableName ( $columId integer primary key autoincrement, $columName text, $columBareCode text, $columPrice integer, $columQuantity integer )';

    String stockTable =
        ' create table $stockTableName ( $columId INTEGER REFERENCES $itemTableName($columId), $columDocumentNo integer DEFAULT 1 , $columTime integer,$columQuantity integer )';
    await db.execute(itemTable);
    await db.execute(stockTable);
  }

  Future<List> barcodeQuery(String text) async {
    var database = await getMyDatabaseInstance();
  final result = await database.rawQuery(
  'SELECT * FROM $itemTableName WHERE $columBareCode = ?', [text]);

  return result;
}

  Future<List<Map<String,dynamic>>> documentQuery() async {
    var database = await getMyDatabaseInstance();
    final result = await database.rawQuery(
        'SELECT $columDocumentNo FROM $stockTableName ORDER BY $columTime DESC LIMIT 1');
    return result;
  }

  onUpgrade(Database db) {
    var upgrade = 'drop table IF EXISTS $itemTableName';
    db.execute(upgrade);

    onCreate(db);
  }

  Future insertInTables(List<Map<String, dynamic>> itemsMapList,
      int documentNo, String time) async {
    Database db = await getMyDatabaseInstance();

    try {
      itemsMapList.forEach((element) async {
        int idItem = await db.insert(itemTableName, element);
        var itemQuantity = ItemModel.getItem(element).itemQuantity;
        Map<String,dynamic> data = StockModel(documentNo: documentNo,time: time,itemId: idItem,itemQuantity: itemQuantity).saveStockRecord();
        db.insert(stockTableName,data);
      });


    } on DatabaseException catch (e) {
      print('err${e}');
    }
  }



  Future<List<Map<String,dynamic>>> queryByBarcode(String number) async{

    var database = await getMyDatabaseInstance();
    final result = await database.query(
        itemTableName ,    where: '$columBareCode = ?',whereArgs: [number]);

return result;

  }


}
