import 'package:app/Mobile/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/GradientText.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import '../admin_pages/admin_classes.dart';
import '../Mobile/ForgotPasswordPage.dart';
import '../m/HomePage.dart';
import 'd_ForgotPasswordPage.dart';
import 'd_SignUp.dart';

class d_SignIn extends StatefulWidget {
  const d_SignIn({Key? key}) : super(key: key);

  @override
  State<d_SignIn> createState() => _d_SignInState();
}

class _d_SignInState extends State<d_SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme= Theme.of(context);
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
                child: Lottie.asset("images/signIn.json",fit: BoxFit.contain),),
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
                      Text('sign in',
                          style: GoogleFonts.acme(textStyle:TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold,))),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text('signin to continue to app with'
                            ' different quizes and evaluate ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16,)),
                      ),
                      SizedBox(height: 40,),

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
                            color: theme.shadowColor,
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
                              // _togglePasswordView,
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
                              color: theme.shadowColor,
                            ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0.8,
                              ),
                            ),
                            onPressed: () {

                              Future.delayed(
                                  Duration(milliseconds: 0), () {
                                showGeneralDialog(
                                  barrierDismissible: true,
                                  transitionDuration: Duration(
                                      milliseconds: 600),
                                  barrierLabel: 'sign up',
                                  context: context,
                                  transitionBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    final tween = Tween(
                                        begin: Offset(0, -1),
                                        end: Offset.zero);
                                    return SlideTransition(
                                      position: tween.animate(
                                          CurvedAnimation(
                                              parent: animation,
                                              curve: Curves.easeInOut)),
                                      child: child,
                                    );
                                  },

                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<
                                          double> secondaryAnimation) {
                                    return  LayoutBuilder( builder: (context, Constraints) {
                                      if(Constraints.maxWidth<768)
                                      { return ForgotPasswordPage(); }

                                      else
                                      {
                                        return d_ForgotPasswordPage();
                                        // return Text("hi ",style: TextStyle(fontSize: 50),);
                                      }
                                    }
                                    );
                                  },
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 78),
                      //login button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          animationDuration: Duration(seconds: 08),
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
                          login(email, password);
                          Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          );
                        },
                        icon: Icon(Icons.navigate_next_outlined,
                            color: Palette.shade7, size: 30),
                        label:GradientText('Sign In', style: GoogleFonts.scopeOne(textStyle: TextStyle(
    fontWeight: FontWeight.bold,  fontSize: 28,  letterSpacing: 0.8),),
                          gradient: LinearGradient(colors: [Palette.shade5,Palette.shade9],begin: FractionalOffset(-1, 0)),),
                      ),
                      //signup button
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //dont hv acc
                            Text(" Don't have account!",
                              style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 1),
                            ),
                            //signup
                            TextButton(

                              child: Text('Sign up',
                                style: TextStyle(fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),),
                              onPressed: () {
                                Future.delayed(
                                    Duration(milliseconds: 0), () {
                                  showGeneralDialog(
                                    barrierDismissible: true,
                                    transitionDuration: Duration(
                                        milliseconds: 600),
                                    barrierLabel: 'sign up',
                                    context: context,
                                    transitionBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      final tween = Tween(
                                          begin: Offset(0, -1),
                                          end: Offset.zero);
                                      return SlideTransition(
                                        position: tween.animate(
                                            CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.easeInOut)),
                                        child: child,
                                      );
                                    },

                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<
                                            double> secondaryAnimation) {
                                      return  LayoutBuilder( builder: (context, Constraints) {
                                        if(Constraints.maxWidth<768)
                                        { return SignUp(); }

                                        else
                                        {
                                          return d_SignUp();
                                          // return Text("hi ",style: TextStyle(fontSize: 50),);
                                        }
                                      }
                                      );
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),


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
    );

  }



  String? validateEmail(String? formEmail) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (formEmail == null || formEmail.isEmpty) {
      return 'E-mail address is required.';
    }
    if (!regex.hasMatch(formEmail)) {
      return 'Enter valid Email';
    } else {
      return null;
    }
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Password is required.';
    } else {
      return null;
    }
  }

  Future<void> login(TextEditingController email,
      TextEditingController password) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);

        // Navigator.push(context, MaterialPageRoute(builder: HomePage(),));
        setState(() {
          // errorMessage = "${user.user?.email}";
          _showToast('login successfully!');
          Future.delayed(Duration(milliseconds: 200));
          Navigator.pop(context);
          if (email.text == "syeda.fatima3865@gmail.com") {
            Navigator.push(context,
                PageTransition(
                    type: PageTransitionType.fade, child: classes()));
          }
          else {
            Navigator.push(context,
                PageTransition(
                    type: PageTransitionType.fade, child: HomePage( Loginemail: '',)));
          }
        });

        // errorMessage='';
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          setState(() {
            // errorMessage = "Wrong password.";
            _showToast('wrong password!');
          });
        } else {
          if (e.code != 'has-email') {
            setState(() {
              // errorMessage = "Wrong credentials.";
              _showToast('email not registered!');
            });
          }
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
      print("_isHidden $_isHidden");
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


  showLoaderDialog(BuildContext context,text){
    AlertDialog alert=AlertDialog(
      content:
      Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text(text)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


}
