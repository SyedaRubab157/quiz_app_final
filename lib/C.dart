import 'package:app/m/NavDrawer.dart';
import 'package:app/m/settings.dart';
import 'package:app/Mobile/F-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/GradientText.dart';
import '../Custom/colors.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/feedback.dart';
import '../Custom/themes.dart';
import '../m/HomePage.dart';
import '../m/QuizPage.dart';
import '../m/Subject_List.dart';
class C extends StatefulWidget {
  C( {Key? key,required this.id }) : super(key: key);
String id;
  @override
  State<C> createState() => _CState();
}
var count;
class _CState extends State<C> {
  final FirebaseAuth auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Scaffold(
        body:
        SingleChildScrollView(
          child:
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
            child:
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('C').doc('${widget.id}').collection('QNA').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print('Something went Wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return  ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var documentSnapshot = snapshot.data?.docs;
                          count=documentSnapshot?.length.toInt();
                          return
                            GestureDetector(
                              onTap: (){},
                              // '${documentSnapshot![index]['image']}',

                              child:Container(
                                height: 150,
                                margin: EdgeInsets.only(bottom: 20),
                                child:  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text("${documentSnapshot![index]['SN']}",
                                          style: GoogleFonts.stylish(
                                              textStyle:TextStyle(fontWeight: FontWeight.w600,
                                                  fontSize: 45,color: Colors.white)),
                                        ),

                                        Text('description'),],)),),







                            );

                        },
                      );

                    }
                )
            ),



          ),



        ),
    );
  }

  void signOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => F_screen()));
  }
}
