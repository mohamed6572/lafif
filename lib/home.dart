import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add/add_plant.dart';
import 'admin/admin_list.dart';
import 'main.dart';
import 'models/plant_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
List <Plant_Model>? list_user = [];
List <Plant_Model>? list_admin = [];
class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff6B8457),

        actions: [
          if(FirebaseAuth.instance.currentUser?.email == 'admin@gmail.com')
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>  AdminList(),));
            
          }, icon: Icon(Icons.person_outline)),
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) =>  Add_Plant(),));

          }, icon: Icon(Icons.add)),
        ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                Container(
                  height: 350,
                  child: Stack(children: [
                    Container(
                      height: 325,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          image: DecorationImage(
                              image: AssetImage('Assets/mainphoto.jpeg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 290, right: 50),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Color(0xff6B8457)),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30)))),
                        child: Text(
                          "إلتقط صورة أو اختر صورة من المعرض",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: 342,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          color: Color(0xffDDE3DB),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 40,
                            left: 20,
                            right: 20,
                          ),
                          child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              children: [
                                InkWell(
                                  onTap: () {
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'Assets/ranf.jpeg'),
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("clicked mee!!");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image:  DecorationImage(
                                          image:
                                          AssetImage('Assets/samr.jpeg'),
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("clicked mee!!");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'Assets/shath.jpeg'),
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("clicked mee!!");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'Assets/juniper.jpeg'),
                                        )),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 300,
                        margin: EdgeInsets.only(left: 50, right: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50)),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Text(
                              "اكتشف أشهر نباتات المنطقة",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}