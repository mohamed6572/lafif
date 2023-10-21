import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lafif_fyp_cs/details.dart';
import 'package:lafif_fyp_cs/sqflie_helper.dart';
import 'dart:io';

import 'package:tflite/tflite.dart';

class Snap2 extends StatefulWidget {
  final String type;
  const Snap2({Key? key,required this.type}) : super(key: key);

  @override
  State<Snap2> createState() => _Snap2State();
}

class _Snap2State extends State<Snap2> {

  File? imageSelect;
  final _imagePicker = ImagePicker();
  bool _loading=false;
  List _outputs=[];
  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = SqfliteHelper();
    _loading=true;
    loadModel().then((value){
      setState(() {
        _loading=false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xff6B8457)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageSelect == null
                ? AspectRatio(
              aspectRatio: 0.7,
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [ Icon(Icons.image), Text("No Image selected")],
                ),
              ),
            )
                : AspectRatio(
              aspectRatio: 0.7,
              child: Image.file(
                File(imageSelect!.path),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    pickImageCamera();
                  },
                  style: ElevatedButton.styleFrom(
                      primary:const  Color(0xff6B8457)
                  ),
                  child:const  Text("التقط صورة من الكاميرا"),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImageGallery();
                  },
                  style: ElevatedButton.styleFrom(
                      primary:const  Color(0xff6B8457)
                  ),
                  child:const  Text("اختر صورة من المعرض"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  pickImageCamera() async {
    final XFile? image =
    await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
      classifyImage();
    }
  }

  pickImageGallery() async {
    final XFile? image =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageSelect = File(image.path);
      });
      classifyImage();
    }
  }

  loadModel()async {
    if(widget.type=="flower"){
    await Tflite.loadModel(model: "Assets/model_unquant.tflite",labels: "Assets/labels.txt");}
    if(widget.type=="tree"){
      await Tflite.loadModel(model: "Assets/model_unquant_tree.tflite",labels: "Assets/labels_tree.txt");}
  if(widget.type=="leaf"){
  await Tflite.loadModel(model: "Assets/model_unquant_leaf.tflite",labels: "Assets/labels_leaf.txt");}
}

  classifyImage()async {
    var output=await Tflite.runModelOnImage(path: imageSelect!.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );
    setState(() {
      _loading=false;
      _outputs=output!;
    });
    print(_outputs[0]['label'].toString().substring(2));
    SqfliteHelper().searchItem(name: _outputs[0]['label'].toString().substring(2),context: context);

  }
}