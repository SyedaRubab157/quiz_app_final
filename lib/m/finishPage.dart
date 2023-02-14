import 'package:app/Custom/colors.dart';
import 'package:app/admin_pages/admin_subjects.dart';
import 'package:app/m/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/GradientText.dart';
import '../Custom/themes.dart';
import '../reviewSolution.dart';
class finishPage extends StatelessWidget {
   finishPage({Key? key,required this.score,required this.Loginemail,
     required this.Sid,required this.Clsid,required this.tid}) : super(key: key);
 String score;
   String Clsid,Sid,tid;
 String Loginemail;
  @override
  Widget build(BuildContext context) {
    // var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 80.h,),

              SizedBox(height: 20),
             Text('Total Score',
                  style:GoogleFonts.stylish(
                    textStyle: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold),

                  )
              ),
              SizedBox(height: 50.h,),

              Stack(children: [
                Center(child:   Lottie.asset('images/win.json'),
                ),
                Positioned(
                  top: 90.h,
                  left: 50.w,
                  right: 50.w,
                  child: Center(
                    child: GradientText('$score',
                        gradient: LinearGradient(colors: [Colors.orange,Colors.teal]),
                        style: GoogleFonts.acme(textStyle: TextStyle(fontSize: 80.sp,),)),
                  ),
                )

              ]),

             SizedBox(height: 100.h,),


              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ElevatedButton(onPressed: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            reviewSolution(Sid: '${Sid}', Clsid: '${Clsid}', tid: '${tid}',),));},
                        child: Text('Review Solutions',
                            style: GoogleFonts.stylish(textStyle: TextStyle(fontSize: 24.sp,),))),

                    ElevatedButton(onPressed: (){
                  Navigator.push(
                      context, PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 600),
                    alignment: Alignment.bottomCenter,
                    child: HomePage(Loginemail: '${Loginemail}',),
                  ));},
                    child: Text('Continue', style: GoogleFonts.stylish(textStyle: TextStyle(fontSize: 24.sp,),))),


              ]),


            ],
          ),
        ),
      ),);
  }
}
