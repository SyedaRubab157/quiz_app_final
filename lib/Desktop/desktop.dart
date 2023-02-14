import 'dart:ui';

import 'package:app/m/settings.dart';
import 'package:app/Mobile/F-screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/colors.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/feedback.dart';
import '../Custom/themes.dart';
import '../m/Subject_List.dart';
class desktop extends StatefulWidget {
   desktop({Key? key, required this. LoginEmail}) : super(key: key);
String LoginEmail;
  @override
  State<desktop> createState() => _desktopState();
}

class _desktopState extends State<desktop> {
  final FirebaseAuth auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0).w,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(16).w,
                    child:  StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('classes').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print('Something went Wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return  GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              var documentSnapshot = snapshot.data?.docs;
                              return
                                GestureDetector(
                                  onTap: (){
                                    print("${widget.LoginEmail}");
                                    Navigator.push(context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            duration: Duration(milliseconds: 600),
                                            alignment: Alignment.bottomCenter,
                                            child: Subject_List(Loginemail: '${widget.LoginEmail}',classno: '${documentSnapshot![index]['class']}', img: '${documentSnapshot![index]['image']}', Clsid: '',)
                                        ));
                                  },
                                  // '${documentSnapshot![index]['image']}',

                                  child:Container(
                                    height: 400.h,
                                    width: 400.w,
                                    child: Card(
                                      elevation: 7,
                                      semanticContainer: true,
                                      shadowColor: theme.shadowColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                                      child:ClipRRect(
                                        borderRadius:BorderRadius.circular(18.r),
                                        child: Image.network(
                                          '${documentSnapshot![index]['image']}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                            },
                          );

                        }
                    )
                ),
              ),

            ),
          ],
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
