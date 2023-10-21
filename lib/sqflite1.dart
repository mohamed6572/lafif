import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lafif_fyp_cs/sqflie_helper.dart';
import 'package:lafif_fyp_cs/sqflite2.dart';


class SQFLITE1 extends StatefulWidget {
  const SQFLITE1({super.key});

  @override
  State<SQFLITE1> createState() => _SQFLITE1State();
}

class _SQFLITE1State extends State<SQFLITE1> {
  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = SqfliteHelper();
  }

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var needsController = TextEditingController();
  late ImageSource imagesource;
  File? image;
  File? loctaionImage;
  File? flowerImage;
  File? plantImage;
  final imagePicker = ImagePicker();
  var bytes;
  String? img;
  String? locationImg;
  String? Flowerimg;
  String? PlantImg;

  Future uploadImage(
      {required BuildContext context,
        required ImageSource source,
        required String selectedImage}) async {
    var pickedImage = await imagePicker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    if (pickedImage != null && selectedImage == "location") {
      loctaionImage = File(pickedImage.path);
      bytes = await loctaionImage!.readAsBytes();
      setState(() {
        locationImg = base64Encode(bytes);
        print("img" + locationImg!);
      });
    }
    if (pickedImage != null && selectedImage == "image") {
      image = File(pickedImage.path);
      bytes = await image!.readAsBytes();
      setState(() {
        img = base64Encode(bytes);
        print("img" + locationImg!);
      });
    }
    if (pickedImage != null && selectedImage == "flower") {
      flowerImage = File(pickedImage.path);
      bytes = await flowerImage!.readAsBytes();
      setState(() {
        Flowerimg = base64Encode(bytes);
        print("img" + Flowerimg!);
      });
    }
    if (pickedImage != null && selectedImage == "plant") {
      plantImage = File(pickedImage.path);
      bytes = await plantImage!.readAsBytes();
      setState(() {
        PlantImg = base64Encode(bytes);
        print("img" + PlantImg!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff6B8457),
            ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              defaultTextFormField(
                  type: TextInputType.text,
                  validate: (value) {},
                  label: "اسم النبتة",
                  controller: nameController),
              defaultTextFormField(
                  type: TextInputType.text,
                  validate: (value) {},
                  label: "وصف النبتة",
                  controller: descriptionController),
              defaultTextFormField(
                  type: TextInputType.text,
                  validate: (value) {},
                  label: "استعمالات النبتة",
                  controller: needsController),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (loctaionImage == null)
                    ContainerImage(
                        text: "الموقع",
                        onClick: () {
                          uploadImage(
                              context: context,
                              source: ImageSource.gallery,
                              selectedImage: "location");
                        }),
                  if (loctaionImage != null)
                    Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.file(loctaionImage!).image,
                            fit: BoxFit.cover),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (plantImage == null)
                    ContainerImage(
                        text: "صورة النبتة",
                        onClick: () {
                          uploadImage(
                              context: context,
                              source: ImageSource.gallery,
                              selectedImage: "plant");
                        }),
                  if (plantImage != null)
                    Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.file(plantImage!).image,
                            fit: BoxFit.cover),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (flowerImage == null)
                    ContainerImage(
                        text: "صورة الزهرة",
                        onClick: () {
                          uploadImage(
                              context: context,
                              source: ImageSource.gallery,
                              selectedImage: "flower");
                        }),
                  if (flowerImage != null)
                    Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.file(flowerImage!).image,
                            fit: BoxFit.cover),
                      ),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (image == null)
                    ContainerImage(
                        text: "صورة الورقة",
                        onClick: () {
                          uploadImage(
                              context: context,
                              source: ImageSource.gallery,
                              selectedImage: "image");
                        }),
                  if (image != null)
                    Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.file(image!).image, fit: BoxFit.cover),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                      text: "إدخال ",
                      onClick: () {
                        SqfliteHelper()
                            .insert(
                            plantName: nameController.text,
                            plantImage: img!,
                            flowerImage: Flowerimg!,
                            locationImage: locationImg!,
                            image: img!,
                            plantdescription: descriptionController.text,
                            plantNeeds: needsController.text)
                            .then((value) {
                          loctaionImage=null;
                          flowerImage=null;
                          needsController.text="";
                          descriptionController.text="";
                          plantImage=null;
                          nameController.text="";
                          image=null;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("تم اضافة المعلومات بنجاح"),
                            duration: Duration(seconds: 5),
                          ));

                        })
                            .catchError((error) {
                          print(error.toString());
                          ScaffoldMessenger.of(context)
                              .showSnackBar( SnackBar(
                            content:
                            Text(error),
                            duration: const Duration(seconds: 5),
                          ));
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(text: "استرجاع ", onClick: ()async  {
                    await Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    const  SQFLITE2()));
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget defaultTextFormField({
  String? labelText,
  TextEditingController? controller,
  required TextInputType type,
  required String? Function(String? val)? validate,
  required String label,
  Function? onClick,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    autocorrect: true,
    validator: validate,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
        isDense: true,

        // Added this
        contentPadding:
        const EdgeInsetsDirectional.only(bottom: 12, top: 12, start: 10)),
  );
}

Widget ContainerImage({required String text, required Function onClick}) {
  return InkWell(
    onTap: () {
      onClick();
    },
    child: Container(
      height: 120,
      width: 250,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "Assets/gallery.png",
            height: 50,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          )
        ],
      ),
    ),
  );
}

Widget Button({required String text, required Function onClick}) {
  return InkWell(
    onTap: () {
      onClick();
    },
    child: Container(
        height: 40,
        width: 160,
        decoration: BoxDecoration(
            color: const Color(0xFF5A895D),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ))),
  );
}

