import 'package:app/Custom/GradientText.dart';
import 'package:app/Desktop/FD_screen.dart';
import 'package:app/Desktop/d_SignIn.dart';
import 'package:app/m/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


import '../Custom/colors.dart';
import '../Custom/themes.dart';
import '../admin_pages/admin_classes.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class F_screen extends StatefulWidget {
  F_screen({Key? key}) : super(key: key);
  @override
  State<F_screen> createState() => _F_screenState();
}

class _F_screenState extends State<F_screen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme =Theme.of(context);
    return    LayoutBuilder( builder: (context, Constraints) {
      if(Constraints.maxWidth<768)
      { return
        Scaffold(
          // backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      top: size.height*0.295,
                      left: size.width*-0.033,
                      child:ColorFiltered(
                        colorFilter:  ColorFilter.mode(
                          Colors.white30,
                          BlendMode.modulate,
                        ),
                        child: Lottie.asset("images/ReadingBoy.json",fit: BoxFit.cover),
                      ),),//ReadingBoy animation

                  Padding(
                    padding: EdgeInsets.only(top: size.height*0.13,
                      left: size.width*0.03,
                      right: size.width*0.03,
                    ),
                    child:       Lottie.asset('images/welcome.json'),

                  ), //welcome animation

                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height*0.36,
                      left: size.width*0.18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.acme(textStyle:TextStyle( fontSize: 40,fontWeight: FontWeight.w600,letterSpacing: 1),),
                            children: const <TextSpan>[
                              TextSpan(text: 'Learn \n', style: TextStyle(fontSize:64,fontWeight: FontWeight.w900,letterSpacing: 2)),
                              TextSpan(text: 'and \n'),
                              TextSpan(text: 'Test \n', style: TextStyle(fontSize:64,fontWeight: FontWeight.w900,letterSpacing: 2)),
                              TextSpan(text: 'your knowledge\n'),
                            ],
                          ),
                          textScaleFactor: 0.5,
                        ),



                      ],
                    ),
                  ),//texts

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.7, left: size.width*0.080),
                          child: Row(
                            children: [
                              AnimatedButton(
                                borderWidth: 1.2,
                                width: 183,
                                backgroundColor: Palette.honey_yellow.withOpacity(0.6),
                                gradient: LinearGradient(
                                  colors: [
                                    Palette.skyblue,
                                    Palette.honey_yellow.withOpacity(0.6)
                                  ],
                                ),
                                text: " Let's Start ",
                                selectedTextColor: Colors.black38,
                                transitionType: TransitionType.LEFT_TOP_ROUNDER,
                                animationDuration: Duration(milliseconds: 600),
                                textStyle: TextStyle(
                                    fontSize: 34,
                                    letterSpacing: 1,
                                    color:theme.shadowColor,
                                    fontFamily: 'DancingScript',
                                    fontWeight: FontWeight.bold),
                                borderRadius: 24,
                                borderColor: Colors.black38,
                                onPress: () {

                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    showGeneralDialog(
                                      barrierDismissible: true,
                                      transitionDuration: const Duration(
                                          milliseconds: 600),
                                      barrierLabel: 'sign in',
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
                                        return
                                          LayoutBuilder( builder: (context, Constraints) {
                                            if(Constraints.maxWidth<768)
                                            { return SignIn(); }

                                            else
                                            {
                                              return d_SignIn();
                                              // return Text("hi ",style: TextStyle(fontSize: 50),);
                                            }
                                          }
                                          );
                                      },
                                    );
                                  });

                                },
                              ),
                              SizedBox(width: 3,),
                              Lottie.asset("images/arrow.json"),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ),  //lets start animation button
                ]),


          ),

        );

      }

      else
      {
        return FD_screen();
        // return Text("hi ",style: TextStyle(fontSize: 50),);
      }
    }
    );





  }





}
