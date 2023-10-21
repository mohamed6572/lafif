import 'package:flutter/material.dart';
import 'package:lafif_fyp_cs/home.dart';

import 'admin_view.dart';

class AdminList extends StatelessWidget {
  const AdminList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xff6B8457),
        ),
        body: SafeArea(
            child: list_admin!=null ?ListView.builder(itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminView(index: index,),));
                },
                child: Container(
                  height: 120,
                  width: double .infinity,
                   child: Stack(
                     alignment: Alignment.centerRight,
                     children: [

                       Image.network('${list_admin![index].image}',width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                       Padding(padding: EdgeInsets.all(30),child: Text(list_admin![index].name.toString(),style: TextStyle(
                         fontSize: 25,color: Colors.white
                       ),),), ],
                   ),
                ),
              );

            },
            itemCount: list_admin?.length,
            ) : Center(child: Text('NO Plant For Review',style: TextStyle(color: Colors.black),),)
        ),
      ),
    );
  }
}
