import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lafif_fyp_cs/details.dart';
import 'package:lafif_fyp_cs/sqflie_helper.dart';


class SQFLITE2 extends StatefulWidget {
  const SQFLITE2({super.key});

  @override
  State<SQFLITE2> createState() => _SQFLITE2State();
}

class _SQFLITE2State extends State<SQFLITE2> {
  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = SqfliteHelper();
    dbHelper.printtedData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff6B8457),
            ),
        body: ListView.separated(
            itemBuilder: (context, index) => Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            name: dbHelper.pllantss[index]['name'],
                            description:
                            dbHelper.pllantss[index]['description'],
                            needs: dbHelper.pllantss[index]['needs'],
                            image: dbHelper.pllantss[index]['images'],
                            plantImage: dbHelper.pllantss[index]['plantImage'],
                            flowerImage: dbHelper.pllantss[index]['flowerImage'],
                            locationImage:
                            dbHelper.pllantss[index]['locationImage'],
                          )));
                },
                child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Row(children: [
                      ContainerTitle(text: dbHelper.pllantss[index]['name']),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            dbHelper.deleteItem(id: dbHelper.pllantss[index]['id']).then((value){
                              setState(() {
                                dbHelper.pllantss.removeWhere((element) => element['id']==dbHelper.pllantss[index]['id']);
                              });
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ))
                    ])
                  //1<<9
                  //0<<8
                ),
              ),
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[500],
            ),
            itemCount: dbHelper.pllantss.length),
      ),
    );
  }
}

Widget ContainerTitle({required String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 100,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    ),
  );
}
