import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/GradientText.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import '../admin_pages/admin_classes.dart';
class d_SignUp extends StatefulWidget {
  const d_SignUp({Key? key}) : super(key: key);

  @override
  State<d_SignUp> createState() => _d_SignUpState();
}

class _d_SignUpState extends State<d_SignUp> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errorMessage = "";
  bool _isHidden = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width*0.036, vertical:  size.height*0.081),
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(40)
          )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              child: ColorFiltered(
                colorFilter:  ColorFilter.mode(
                  Colors.white30,
                  BlendMode.modulate,
                ),
                child: Lottie.asset("images/GwC.json",fit: BoxFit.contain),),
              height: double.infinity,
              width: double.infinity,
            ),

            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14, vertical: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text('sign up',
                          style: GoogleFonts.acme(textStyle:TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold,))),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text('signup to continue to app with'
                            ' different quizes and evaluate ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16,)),
                      ),
                      SizedBox(height: 60,),
                      // Email TextFormField
                      TextFormField(
                        validator: validateEmail,
                        style: TextStyle(
                          color: theme.shadowColor,
                            fontWeight: FontWeight.w800,
                            wordSpacing: 0.5),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () { },
                            // _togglePasswordView,
                            child: Icon(
                              Icons.visibility,
                              color: Colors.transparent,
                            ),
                          ),
                          prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Colors.amber),
                          labelText: " email",
                          labelStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color:theme.shadowColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black26, width: 1.8),
                            borderRadius: BorderRadius.all(
                                Radius.circular(28.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.amber, width: 1.8),
                            borderRadius: BorderRadius.all(
                                Radius.circular(28.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      //   Password TextFormField
                      TextFormField(
                        validator: validatePassword,
                        style: TextStyle(
                          color: theme.shadowColor,
                            fontWeight: FontWeight.w800,
                            wordSpacing: 0.5),
                        controller: password,
                        obscureText: _isHidden,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                _togglePasswordView();
                              },
                              child: Icon(
                                Icons.visibility,
                                color: Palette.honey_yellowO,
                              ),
                            ),
                            prefixIcon: Icon(Icons.password_rounded,
                                color: Colors.amber),
                            labelText: " password",
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: theme.shadowColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black26, width: 1.8),
                              borderRadius:
                              BorderRadius.all(Radius.circular(28.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.amber, width: 1.8),
                                borderRadius:
                                BorderRadius.all(Radius.circular(28.0)))),
                      ),
                      //ForgotPassword
                      SizedBox(height: 78),
                      //login button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.honey_yellowO,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(26)),
                          ),
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 15),
                        ),
                        onPressed: () {
                          sign_up(email, password);
                          // showLoaderDialog(context);
                          Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          );
                        },
                        icon: Icon(Icons.navigate_next_outlined,
                            color: Palette.shade7, size: 30),
                        label:GradientText('Sign Up',
                          style: GoogleFonts.scopeOne(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, letterSpacing: 0.8),),
                          gradient: LinearGradient(colors: [Palette.shade5,Palette.shade9],begin: FractionalOffset(-1, 0)),),
                      ),
                      //signup button
                      SizedBox(height: 40),


                    ],
                  ),
                ),
              ),
            ),

            // Text(errorMessage, style: const TextStyle(color: Colors.red),),
            Positioned(
                left: 0,
                right: 0,
                bottom: -20,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ))

          ],


        ),


      ),

    ) ;


  }
  String? validateEmail(String? formEmail) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (formEmail == null || formEmail.isEmpty) {
      return 'E-mail address is required.';
    }
    if (!formEmail.contains('@gmail.com')) {
      return 'Enter valid Email format';
    } else {
      if (!regex.hasMatch(formEmail)) {
        return 'Enter valid Email';
      } else {
        return null;
      }
    }
  }
  String? validatePassword(String? formPassword) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (formPassword == null || formPassword.isEmpty) {
      return 'Password is required.';
    }
    if (!regex.hasMatch(formPassword)) {
      return ' 6 charcters long including uppercase, digits and sepcial character';

    } else {
      return null;
    }
  }
  Future<void> sign_up(
      TextEditingController email, TextEditingController password) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        print("user signup ${user.user?.email}");
        setState(() {
          // errorMessage = "${user.user?.email}";
          _showToast('signed up successfully!');
          Future.delayed(Duration(milliseconds: 200));
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            _showToast('email you entered is already registered!');
            // errorMessage = "Email you entered is already registered.";
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "$e";
        });
      }
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _showToast(String s) {
    Fluttertoast.showToast(
        msg: "$s",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


}
