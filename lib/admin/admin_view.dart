import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../main.dart';

class AdminView extends StatefulWidget {
  int index;

  AdminView({required this.index});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
 bool loading=true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6B8457),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.network(
                            '${list_admin![widget.index].image}',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          )),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                        height: 70,
                        child: Center(
                          child: Text(
                            list_admin![widget.index].name.toString(),
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: double.infinity,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 140,
                          margin: EdgeInsets.only(top: 12),

                          decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(
                                  40
                              )),
                          child:Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              list_admin![widget.index].description.toString(),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          )
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                             40
                            )),
                        child:Center(child:  Text(
                          'الوصف',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),)
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 140,
                          margin: EdgeInsets.only(top: 12),

                          decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(
                                  40
                              )),
                          child:Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Lan : ${list_admin![widget.index].location!.Lan}",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),Text(
                                  "Lat : ${list_admin![widget.index].location!.Lat}",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          )
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                             40
                            )),
                        child:Center(child:  Text(
                          'الموقع',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),)
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 140,
                          margin: EdgeInsets.only(top: 12),

                          decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(
                                  40
                              )),
                          child:Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              list_admin![widget.index].accest.toString(),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          )
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                             40
                            )),
                        child:Center(child:  Text(
                          'الاستعلامات',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),)
                      ),

                    ],
                  ),
                ),
                if(loading)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      borderRadius: BorderRadius.circular(
                          40
                      )),
                  child:TextButton(
                      onPressed: ()async{
                       await updatePlantStatus(documentId: list_admin![widget.index].docID!);
                        setState(() {

                           Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                           getPlant();
                        });
                      },
                    child: Text('تأكيد',style: TextStyle(color: Colors.white),),
                  ),
                ),
                if(!loading)
                  Center(child: CircularProgressIndicator(),),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> updatePlantStatus({required String documentId}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
setState(() {
  loading=false;
});
    try {
      await firestore.collection('plant').doc(documentId).update({
        'active': true,
      });
      print('Plant updated successfully');
      setState(() {
        loading=true;
      });
    } catch (e) {
      print('Error updating Plant: $e');
    }
  }
}
