import 'package:flutter/material.dart';
import 'package:lafif_fyp_cs/snap2.dart';

class Snap1 extends StatefulWidget {
  const Snap1({Key? key}) : super(key: key);

  @override
  State<Snap1> createState() => _Snap1State();
}
class _Snap1State extends State<Snap1> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(backgroundColor:const  Color(0xff6B8457)),
            body: SafeArea(
              child:
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Stack(
                  children: [
                    Container(
                      height: 692,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('Assets/snap.png'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 690,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         const  SizedBox(
                            width: double.infinity,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                         const  Snap2(
                                           type: "flower",
                                         )));
                            },
                            child: Container(
                              height: 150,
                              width: 300,
                              margin:const  EdgeInsets.only(right: 10, top: 40),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30)),
                              child:const  Center(
                                  child: Text(
                                    "إلتقط صورة للزهرة",
                                    style: TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                        const   Snap2(
                                          type: "leaf",
                                        )));
                            },
                            child: Container(
                              height: 150,
                              width: 300,
                              margin:const  EdgeInsets.only(right: 10, top: 40),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30)),
                              child:const Center(
                                  child: Text(
                                    "التقط صورة للورقة",
                                    style: TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                         const Snap2(
                                           type: "tree",
                                         )));
                            },
                            child: Container(
                              height: 150,
                              width: 300,
                              margin:const  EdgeInsets.only(right: 10, top: 40),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30)),
                              child:const  Center(
                                  child: Text(
                                    "التقط صورة للشجرة",
                                    style: TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]),
            )));
  }
 }