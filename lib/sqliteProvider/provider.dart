// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Provider {
  Database? db;
  String? _path;

  Future open({ String dbName  = 'roocket.db'}) async {
    var databasesPath = await getDatabasesPath();
    _path = join(databasesPath, dbName);

    db = await openDatabase(_path!, version: 2,
          // اگر دیتابیس وجود نداشته باشه این متد اجرا میشه
          // و در واقع جداول به صورت زیر به وجود میان
          onCreate: (Database db, int version) async {
              await db.execute('''
                  create table products ( 
                      id integer primary key autoincrement, 
                      product_name text not null,
                      shop_name  text  not null,
                      image text not null,
                      price text not null)
                  ''');
          },

        );
  }

  Future close() async => db!.close();
}