import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import 'details.dart';

class SqfliteHelper {
  static Database? _db;
  static const DB_Name = "PlantsApp";
  static const String Plants = "Plants";
  static const C_PlantId = 'Plant_id';
  static const C_PlantName = 'Plant_Name';
  static const C_PlantDescription = 'Plant_Description';
  static const C_PlantNeeds = 'Plant_Needs';
  static const C_PlantImage = 'Plant_Image';
  static const C_LocationImage = 'Location_Image';
  static const C_FlowerImage = 'Flower_Image';
  static const C_Image = 'Image';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_Name);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE $Plants '
        '($C_PlantId INTEGER PRIMARY KEY '
        'AUTOINCREMENT,'
        '$C_PlantName TEXT,'
        '$C_PlantDescription TEXT,'
        '$C_PlantNeeds TEXT,'
        '$C_PlantImage TEXT,'
        '$C_FlowerImage TEXT,'
        '$C_LocationImage TEXT,'
        '$C_Image TEXT'
        ')')
        .then((value) => print("created"))
        .catchError((error) {
      print(error.toString());
    });
  }

  insert(
      {required String plantName,
        required String plantdescription,
        required String plantNeeds,
        required String plantImage,
        required String flowerImage,
        required String locationImage,
        required String image}) async {
    var dbClient = await db;
    // row to insert
    Map<String, dynamic> row = {
      C_PlantName:plantName,
      C_PlantDescription:plantdescription,
      C_PlantNeeds:plantNeeds,
      C_LocationImage:locationImage,
      C_FlowerImage:flowerImage,
      C_PlantImage:plantImage,
      C_Image:image
    };

    int id = await dbClient.insert(Plants, row);
    print(id.toString());
  }
  Future select()async{
    var dbClient=await db;
    var res=await dbClient.rawQuery("SELECT * FROM $Plants");
    if (res.isNotEmpty) {
      return res;
    }
    else{
      return res;
    }
  }

  List<Map<String,dynamic>> pllantss=[];

  printtedData()async{
    var data= await select();
    for(var i in data){
      pllantss.add({
        'id':i['Plant_id'],
        'name':i['Plant_Name'],
        'description':i['Plant_Description'],
        'needs':i['Plant_Needs'],
        'flowerImage':i['Flower_Image'],
        'plantImage':i['Plant_Image'],
        'locationImage':i['Location_Image'],
        'images':i['Image']
      });
    }
    print(pllantss);
  }

  deleteItem({required int id})async{
    var dbClient = await db;
    await dbClient.rawDelete('DELETE FROM $Plants WHERE Plant_id = ?',[id],);
  }

  List<Map> oo=[];

  searchItem({required String name,context})async{
    var dbClient = await db;
   oo= await dbClient.rawQuery('SELECT * FROM $Plants WHERE Plant_Name = ?',[name],);
   print(oo.toString());
   if(oo.isNotEmpty){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        DetailsPage(
          name: oo[0]['Plant_Name'],
          description:
         oo[0]['Plant_Description'],
          needs: oo[0]['Plant_Needs'],
          image:oo[0]['Image'],
          plantImage: oo[0]['Plant_Image'],
          flowerImage: oo[0]['Flower_Image'],
          locationImage:
         oo[0]['Location_Image'],
        )
    ));
  }
  }

}