import 'dart:convert';

import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final String needs;
  final String description;
  final String image;
  final String flowerImage;
  final String plantImage;
  final String locationImage;

  const DetailsPage(
      {super.key,
        required this.name,
        required this.description,
        required this.needs,
        required this.image,
        required this.plantImage,
        required this.flowerImage,
        required this.locationImage});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Color(0xff6B8457),),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(25)),
                          image: DecorationImage(
                              image: Image.memory(base64Decode(widget.plantImage))
                                  .image,
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(25),
                              bottomEnd: Radius.circular(25)),
                          color: Colors.black.withOpacity(0.6)),
                      child: Center(
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:const  EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const   SizedBox(
                      height: 30,
                    ),
                    ContainerText(title: "الوصف", subTitle: widget.description),
                    const  SizedBox(height: 20,),
                    ContainerImage(title: "الموقع", image: widget.locationImage),
                    const  SizedBox(height: 20,),
                    ContainerImage(title: "النبتة", image: widget.plantImage),
                    const  SizedBox(height: 20,),
                    ContainerImage(title: "الزهرة", image: widget.flowerImage),
                    const  SizedBox(height: 20,),
                    ContainerImage(title: "الورقة", image: widget.image),
                    const  SizedBox(height: 20,),
                    ContainerText(title: "الإستعمالات", subTitle: widget.needs),
                    const  SizedBox(height: 20,),
                  ],
                ),
              )
            ]),
          )),
    );
  }
}

Widget DefaultText({required String text}) {
  return Padding(
    padding:const  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}


Widget ContainerText({required String title ,required String subTitle}){
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
          width:double.infinity,
          decoration: BoxDecoration(
            color: Color(0x67718a70),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 5),
            child: DefaultText(text: subTitle),
          )),
      Positioned(
        top: -15,
        right: 40,
        child: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child:  Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
            ),
          ),
        ),
      )
    ],
  );
}

Widget ContainerImage({required String title,required String image}){
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
              image: Image.memory(base64Decode(image)).image, fit: BoxFit.cover),
        ),
      ),
      Positioned(
        top: -15,
        right: 40,
        child: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child:  Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
            ),
          ),
        ),
      )
    ],
  );
}