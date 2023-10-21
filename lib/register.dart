import 'package:flutter/material.dart';
import 'package:lafif_fyp_cs/login.dart';


class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var registerKey=GlobalKey<FormState>();
  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.green[800],
              leading: const Icon(Icons.menu, size: 30, color: Colors.white)),
          body: Form(
            key: registerKey,
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/wallpaper.jpeg"),
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
                              "أنشئ حسابك في لفيف",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 37),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 250,
                      ),
                      Container(
                        // height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 50),
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
                                height: 10,
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
                                height: 10,
                              ),
                              defaultTextFormField(
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if(value!.isEmpty){
                                      return 'من فضلك ادخل اعادة كلمة المرور';
                                    }
                                    if(passwordController.text!=confirmPasswordController.text){
                                      return 'كلمة المرور و اعادة كلمة المرور غير متشابهان';
                                    }
                                  },
                                  label: "اعادة كلمة المرور",
                                  controller: confirmPasswordController),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen()));
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5)),
                                    child: const Center(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    if(registerKey.currentState!.validate()){}
                                    },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5)),
                                    child: const Center(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                          "انشاء حساب ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              const SizedBox(
                                height: 2,
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
  bool isPassword = false,
  bool isFunction = false,
  Function? onEdition,
  required String? Function(String? val)? validate,
  required String label,
  IconData? prefixIcon,
  Function? prefixPressed,
  dynamic? suffix,
  Function? suffixPressed,
  bool isImage = false,
  Function? onClick,
  // Function? ontap,
  // bool ?autofocus,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
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
