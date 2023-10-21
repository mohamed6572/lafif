import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../home.dart';
import '../main.dart';

class Add_Plant extends StatefulWidget {


  @override
  State<Add_Plant> createState() => _Add_PlantState();
}

class _Add_PlantState extends State<Add_Plant> {
  var controlerName =TextEditingController();
  var controler1 =TextEditingController();
  var controler2 =TextEditingController();
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }



  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);
    setState(() {
      lat=position.latitude;
      lan=position.longitude;
    });
    return position;
  }
  double? lan;
  double? lat;
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
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child:
                  image==null?  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Container(
                            child: Center(
                              child: Icon(Icons.photo_library_outlined,color: Colors.white,size: 80,),
                            ),
                          )),
                      InkWell(
                        onTap: (){
                          chooseImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              )),
                          height: 70,
                          child: Center(
                            child: Text(
                             'اضف صورة النبته',
                              style: TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ):    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.file(
                        image!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      )),

                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: double.infinity,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 100,
                          margin: EdgeInsets.only(top: 12),

                          decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(
                                  40
                              )),
                          child:Padding(
                              padding: const EdgeInsets.all(20.0),
                              child:TextFormField(
                                controller: controlerName,
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                ),
                              )
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
                            'الاسم',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),)
                      ),

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
                            child:TextFormField(
                              controller: controler1,
                               minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                              ),
                            )
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
                      InkWell(
                        child: Container(
                            width: double.infinity,
                            height: 140,
                            margin: EdgeInsets.only(top: 12),

                            decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(
                                    40
                                )),
                          child:lat!=null? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Lan : $lan",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),Text(
                                "Lat : $lat",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ):Text(''),
                            
                        ),
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
                            child:TextFormField(
                              controller: controler2,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent
                                    )
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent
                                    )
                                ),
                              ),
                            )
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
                      await uploadPlant(
                        image!.path
                      );
                      setState(() {
                        getPlant();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                      });
                    },
                    child: Text('اضف النبتة',style: TextStyle(color: Colors.white),),
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

// Function to choose an image and upload it to Firebase
  Future<void> chooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image =File(pickedFile.path);
      });
      print(pickedFile);
    } else {
      print('No image selected.');
    }
  }
File? image;
  Future<void> uploadPlant( String imagePath) async {
    setState(() {
      loading =false;
    });
    try {
      final storageRef = FirebaseStorage.instance.ref().child('images/uid/${DateTime.now().toString()}');
      UploadTask uploadTask = storageRef.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      if (taskSnapshot.state == TaskState.success) {
        final imageUrl = await storageRef.getDownloadURL();

        // Now you can save the image URL to Firestore
        DocumentReference docRef = await  FirebaseFirestore.instance.collection('plant').add({
          'image': imageUrl,
          'name': controlerName.text,
          'active': false,
          'description': controler1.text,
          'accest': controler2.text,
          'location': {
            'Lan':'$lan',
            'Lat':'$lat',
          },
        });
        docRef.update({'docID': docRef.id});
        setState(() {
          loading =true;
        });
        print('Succses');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

}
