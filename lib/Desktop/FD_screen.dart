import 'package:app/Custom/GradientText.dart';
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
import '../Mobile/sign_in.dart';

class FD_screen extends StatefulWidget {
  FD_screen({Key? key}) : super(key: key);
  @override
  State<FD_screen> createState() => _FD_screenState();
}

class _FD_screenState extends State<FD_screen> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: [

                      Container(
              //           child: ColorFiltered(
              //             colorFilter:  ColorFilter.mode(
              //               Colors.white30,
              //               BlendMode.modulate,
              //             ),
              //             child: Lottie.asset("images/pencil.json",fit: BoxFit.cover),
              // ),
                       child: Lottie.asset("images/pencil.json",fit: BoxFit.cover),
                        height: double.infinity,
                        width: double.infinity,
                      ),
              Padding(
                padding: EdgeInsets.only(top: size.height*0.19,
                  left: size.width*0.03,
                  right: size.width*0.03,
                ),
                child:       Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:[ Lottie.asset('images/welcome.json')]),

              ), //welcome animation

              Padding(
                padding: EdgeInsets.only(
                  top: size.height*0.47,
                  // left: size.width*0.08,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.acme(textStyle:TextStyle( fontSize: 50,fontWeight: FontWeight.w600,letterSpacing: 1),),
                        children: <TextSpan>[
                          TextSpan(text: 'Learn ', style: TextStyle(fontSize:74,fontWeight: FontWeight.w900,letterSpacing: 2)),
                          TextSpan(text: 'and '),
                          TextSpan(text: 'Test ', style: TextStyle(fontSize:74,fontWeight: FontWeight.w900,letterSpacing: 2)),
                          TextSpan(text: 'your knowledge'),
                        ],
                      ),
                      textScaleFactor: 0.5,
                    ),
                  ],
                ),
              ),//texts



                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.9, left: size.width*0.080),
                          child: Padding(
                            padding:  EdgeInsets.only(right: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                        Duration(milliseconds: 10), () {
                                      showGeneralDialog(
                                        barrierDismissible: true,
                                        transitionDuration: Duration(
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
                              ],
                            ),
                          ),
                        ),


             //lets start animation button
            ]),


      ),

    );
  }





}
