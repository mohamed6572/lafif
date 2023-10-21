import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lafif_fyp_cs/snap1.dart';
import 'package:lafif_fyp_cs/snap2.dart';
import 'package:lafif_fyp_cs/sqflite1.dart';

import 'home.dart';
import 'login.dart';
import 'models/plant_model.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 await getPlant();
  runApp(MyApp());
}
Future<void> getPlant()async{
  list_user =[];
  list_admin =[];
await  FirebaseFirestore.instance.collection('plant').get().then((value) {
    value.docs.forEach((element) {
      final data = element.data() as Map<String, dynamic>;
      var Plant_Mode = Plant_Model.fromJson(data);

      if(Plant_Mode.active==false){
        list_admin?.add(Plant_Mode);
      }if(Plant_Mode.active==true){
        list_user?.add(Plant_Mode);
      }

    });
print('get');
  });
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:FirebaseAuth.instance.currentUser!=null ? Home() : LoginScreen(),
    );
  }
}