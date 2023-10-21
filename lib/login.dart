import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lafif_fyp_cs/sqflite2.dart';

import 'home.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var loginKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

          appBar: AppBar(
              backgroundColor: Colors.green[800],
              leading: const Icon(Icons.menu, size: 30, color: Colors.white)),
          body: Form(
            key: loginKey,
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("Assets/wallpaper.jpeg"),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Column(
                          children: const [
                            Center(
                              child: Text(
                                "مرحباً",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 35),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "ادخل حسابك في لفيف",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 37),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 260,
                      ),
                      Container(

                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40))),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                          child: Column(
                            children: [

                              defaultTextFormField(
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if(value!.isEmpty){
                                      return 'من فضلك ادخل البريد الالكتروني';
                                    }
                                    if(!value.contains("@")){
                                      return 'من فضلك ادخل البريد الالكتروني بشكل صحيح';
                                    }
                                    if(!value.contains(".com")){
                                      return 'من فضلك ادخل البريد الالكتروني بشكل صحيح';
                                    }
                                  },
                                  label: "البريد الالكتروني",
                                  controller: emailController),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultTextFormField(
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if(value!.isEmpty){
                                      return 'من فضلك ادخل كلمة المرور';
                                    }
                                  },
                                  label: "كلمة المرور",
                                  controller: passwordController),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: InkWell(
                                        onTap: () async{
                                          if(loginKey.currentState!.validate()) {
                                            await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) async{

                                            print(FirebaseAuth.instance.currentUser?.email);
                                            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                            const  Home()));
                                            setState(() {});
                                            });

                                            }},
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.black.withOpacity(0.5)),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                "تسجيل الدخول",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}

Widget defaultTextFormField({
  String? labelText,
  TextEditingController? controller,
  required TextInputType type,
  String? Function(String? val)? onsubmit,
  String? Function(String val)? onchange,
  required String? Function(String? val)? validate,
  required String label,
  Function? onClick,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onsubmit,
    onChanged: onchange,
    autocorrect: true,
    validator: validate,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        //labelText: labelText != null ? labelText : null,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.transparent),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.transparent),
          // borderRadius: BorderRadius.circular(50.0),
        ),
        isDense: true,

        // Added this
        contentPadding:
        const EdgeInsetsDirectional.only(bottom: 12, top: 12, start: 10)),
  );
}
