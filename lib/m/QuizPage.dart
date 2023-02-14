import 'dart:math';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:page_transition/page_transition.dart';
import '../Custom/colors.dart';
// import 'finishPage.dart';
import '../Mobile/sign_in.dart';
import 'finishPage.dart';

class QuizPage extends StatefulWidget {
  QuizPage({
    Key? key,
    // required this.classNumber,
    required this.Clsid,
    required this.Sid,
    required this.tid,
    required this.Loginemail,
  }) : super(key: key);
  // String classNumber;
  String Loginemail;
  String Clsid,Sid,tid;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  int score = 0;
  List<String> btnString = [];
  String subject = "";
  List _controller = [];

  @override
  Widget build(BuildContext context) {
    print("widget.Clsid=> ${widget.Clsid}");
    print("widget.Sid=> ${widget.Sid}");
    print("widget.tid=> ${widget.tid}");


    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 10,
          centerTitle: true,
          title:
          TweenAnimationBuilder<Duration>(
              duration: Duration(minutes: 1),
              tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
              onEnd: () {
                print('Timer ended');
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 600),
                        alignment: Alignment.bottomCenter,
                        child:finishPage(score: '$score', Loginemail: '${widget.Loginemail}',
                          Sid: '${widget.Sid}', Clsid: '${widget.Clsid}', tid: '${widget.tid}'),
                    ));

              },
              builder: (BuildContext context, Duration value, Widget? child) {
                final minutes = value.inMinutes;
                final seconds = value.inSeconds % 60;
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('$minutes:$seconds',
                        textAlign: TextAlign.center,
                      style: GoogleFonts.stylish(textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 60)),));
              }),

        ),

        body: Padding(
          padding: const EdgeInsets.only(top:9).h,
          child: FutureBuilder(
            future: getdata(),
            builder: (BuildContext context, snapshot) {
              print("snapshot.connectionState ${snapshot.connectionState}");
              if (snapshot.hasError) {
                print('Something went Wrong');
                return Center(child: Text("${snapshot.hasError}"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                // print("length=> ${snapshot.data!.docs.isEmpty}");
                return Center(child: CircularProgressIndicator());
              }
              // print("length=> ${snapshot.data!.docs.isEmpty}");
              return Center(
                child: Text('${snapshot.data?.size }',style:
                  TextStyle(fontSize: 20),),
              );
              // return ListView.builder(
              //   itemCount: snapshot.data?.docs.length,
              //   itemBuilder: (context, index) {
              //     var documentSnapshot = snapshot.data?.docs;
              //     _controller.add(GroupButtonController());
              //     btnString.add("");
              //     print("title=> ${documentSnapshot![index]['ques']}");
              //
              //     return Padding(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 1.w,
              //       ),
              //       child: Container(
              //         child: Column(
              //           children: [
              //             Stack(
              //               children: [
              //                 Card(
              //                   color: theme.primaryColor.withOpacity(0.4),
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(14.r),
              //                   ),
              //                   child: Padding(
              //                     padding: EdgeInsets.all(15).w
              //                     ,
              //                     child: Column(children: [
              //                       Padding(
              //                         padding:EdgeInsets.only(left:25.w,bottom: 10.h),
              //                         child: Container(
              //                           width:double.infinity,
              //                           child:
              //                           Text(
              //                             '${documentSnapshot![index]['ques']}',
              //                             textAlign: TextAlign.justify,
              //                             style:GoogleFonts.stylish(textStyle:TextStyle(
              //                                 color: Colors.white,
              //                                 fontWeight: FontWeight.bold,
              //                                 fontSize: 24)) ,
              //                           ),
              //
              //
              //                         ),
              //                       ),
              //
              //
              //                       GroupButton<String>(
              //                         controller: _controller[ index].shuffle(),
              //                         buttons: [
              //                           "${documentSnapshot[index]['w_ans1']}",
              //                           "${documentSnapshot[index]['w_ans2']}",
              //                           "${documentSnapshot[index]['w_ans3']}",
              //                           "${documentSnapshot[index]['c_ans']}",
              //                         ],
              //                         isRadio: true,
              //                         enableDeselect: false,
              //                         buttonBuilder: (selected, value, context) {
              //                           return btnString[index].toString() == value
              //                               ?  Row(
              //                             crossAxisAlignment: CrossAxisAlignment.start,
              //                             children: [
              //                               SizedBox(
              //                                 width: 240.w,
              //                                 child: ElevatedButton(
              //                                   style: ElevatedButton.styleFrom(
              //                                       backgroundColor: theme.primaryColor,alignment: Alignment.centerLeft
              //                                   ),
              //                                   onPressed: () {
              //                                     selected = true;
              //                                     print(value);
              //                                     print('$selected');
              //                                   },
              //                                   child: Text(value,
              //                                     style: GoogleFonts.stylish(textStyle: TextStyle(
              //                                       fontSize: 19,
              //                                     )),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           )
              //
              //                               : Row(
              //                             crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                             children: [
              //                               SizedBox(
              //                                 width: 240.w,
              //                                 child: ElevatedButton(
              //                                     style: ElevatedButton.styleFrom(
              //                                         backgroundColor: theme.scaffoldBackgroundColor,alignment: Alignment.centerLeft
              //                                     ),
              //                                     onPressed: () {
              //                                       setState(() {
              //                                         btnString[index]=value.toString();
              //                                         if (btnString[index].toString() ==
              //                                             "${documentSnapshot[index]['c_ans']}") {
              //                                           score++;
              //                                         }
              //                                       });
              //                                       print(value);
              //                                     },
              //                                     child: Text(
              //                                       value,
              //                                       style: GoogleFonts.stylish(textStyle: TextStyle(
              //                                           fontSize: 20,color: theme.shadowColor
              //                                       )),
              //                                     )),
              //                               ),
              //                             ],
              //                           );
              //                         },
              //                       ),
              //
              //
              //                     ]),
              //                   ),
              //                 ),
              //                 Positioned(
              //                     left: size.width*0.0012,
              //                     top: 0,
              //                     // left:2.w,
              //                     child: CircleAvatar(
              //                         radius: 18,
              //                         backgroundColor: theme.primaryColor,
              //                         child: Padding(
              //                           padding:  EdgeInsets.only(top:8.0),
              //                           child:
              //                           Text('${index + 1}/${documentSnapshot.length}',
              //                             style:  TextStyle(color:Colors.white,fontSize: 16,
              //                                 fontFamily:'Katibeh',fontWeight: FontWeight.bold),),
              //                         )
              //                     )),
              //               ],
              //
              //             ),
              //           ],
              //         ),
              //       ),);
              //
              //   },
              // );

            },
          ),


          // child: StreamBuilder(
          //       stream:
          //       FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
          //           .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}').collection('QNA')
          //           .snapshots(),
          //       builder: (BuildContext context, snapshot) {
          //         print("snapshot.connectionState ${snapshot.connectionState}");
          //         if (snapshot.hasError) {
          //           print('Something went Wrong');
          //           return Center(child: Text("${snapshot.hasError}"));
          //         }
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           print("length=> ${snapshot.data!.docs.isEmpty}");
          //           return Center(child: CircularProgressIndicator());
          //         }
          //         print("length=> ${snapshot.data!.docs.isEmpty}");
          //         return ListView.builder(
          //           itemCount: snapshot.data?.docs.length,
          //           itemBuilder: (context, index) {
          //             var documentSnapshot = snapshot.data?.docs;
          //             _controller.add(GroupButtonController());
          //             btnString.add("");
          //             print("title=> ${documentSnapshot![index]['ques']}");
          //
          //             return Padding(
          //               padding: EdgeInsets.symmetric(
          //                 horizontal: 1.w,
          //               ),
          //               child: Container(
          //                 child: Column(
          //                   children: [
          //                     Stack(
          //                       children: [
          //                         Card(
          //                           color: theme.primaryColor.withOpacity(0.4),
          //                           shape: RoundedRectangleBorder(
          //                             borderRadius: BorderRadius.circular(14.r),
          //                           ),
          //                           child: Padding(
          //                             padding: EdgeInsets.all(15).w
          //                             ,
          //                             child: Column(children: [
          //                               Padding(
          //                                 padding:EdgeInsets.only(left:25.w,bottom: 10.h),
          //                                 child: Container(
          //                                   width:double.infinity,
          //                                   child:
          //                                   Text(
          //                                     '${documentSnapshot![index]['ques']}',
          //                                     textAlign: TextAlign.justify,
          //                                     style:GoogleFonts.stylish(textStyle:TextStyle(
          //                                         color: Colors.white,
          //                                         fontWeight: FontWeight.bold,
          //                                         fontSize: 24)) ,
          //                                   ),
          //
          //
          //                                 ),
          //                               ),
          //
          //
          //                               GroupButton<String>(
          //                                 controller: _controller[ index].shuffle(),
          //                                 buttons: [
          //                                   "${documentSnapshot[index]['w_ans1']}",
          //                                   "${documentSnapshot[index]['w_ans2']}",
          //                                   "${documentSnapshot[index]['w_ans3']}",
          //                                   "${documentSnapshot[index]['c_ans']}",
          //                                 ],
          //                                 isRadio: true,
          //                                 enableDeselect: false,
          //                                 buttonBuilder: (selected, value, context) {
          //                                   return btnString[index].toString() == value
          //                                       ?  Row(
          //                                     crossAxisAlignment: CrossAxisAlignment.start,
          //                                     children: [
          //                                       SizedBox(
          //                                         width: 240.w,
          //                                         child: ElevatedButton(
          //                                           style: ElevatedButton.styleFrom(
          //                                               backgroundColor: theme.primaryColor,alignment: Alignment.centerLeft
          //                                           ),
          //                                           onPressed: () {
          //                                             selected = true;
          //                                             print(value);
          //                                             print('$selected');
          //                                           },
          //                                           child: Text(value,
          //                                             style: GoogleFonts.stylish(textStyle: TextStyle(
          //                                               fontSize: 19,
          //                                             )),
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   )
          //
          //                                       : Row(
          //                                     crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                     children: [
          //                                       SizedBox(
          //                                         width: 240.w,
          //                                         child: ElevatedButton(
          //                                             style: ElevatedButton.styleFrom(
          //                                                 backgroundColor: theme.scaffoldBackgroundColor,alignment: Alignment.centerLeft
          //                                             ),
          //                                             onPressed: () {
          //                                               setState(() {
          //                                                 btnString[index]=value.toString();
          //                                                 if (btnString[index].toString() ==
          //                                                     "${documentSnapshot[index]['c_ans']}") {
          //                                                   score++;
          //                                                 }
          //                                               });
          //                                               print(value);
          //                                             },
          //                                             child: Text(
          //                                               value,
          //                                               style: GoogleFonts.stylish(textStyle: TextStyle(
          //                                                   fontSize: 20,color: theme.shadowColor
          //                                               )),
          //                                             )),
          //                                       ),
          //                                     ],
          //                                   );
          //                                 },
          //                               ),
          //
          //
          //                             ]),
          //                           ),
          //                         ),
          //                         Positioned(
          //                             left: size.width*0.0012,
          //                             top: 0,
          //                             // left:2.w,
          //                             child: CircleAvatar(
          //                                 radius: 18,
          //                                 backgroundColor: theme.primaryColor,
          //                                 child: Padding(
          //                                   padding:  EdgeInsets.only(top:8.0),
          //                                   child:
          //                                   Text('${index + 1}/${documentSnapshot.length}',
          //                                     style:  TextStyle(color:Colors.white,fontSize: 16,
          //                                         fontFamily:'Katibeh',fontWeight: FontWeight.bold),),
          //                                 )
          //                             )),
          //                       ],
          //
          //                     ),
          //                   ],
          //                 ),
          //               ),);
          //
          //           },
          //         );
          //
          //       },
          //     ),
        ),
      );
  }

  Future getdata() async {
    print("query : ${await FirebaseFirestore.instance.collection('classes').doc('${widget
        .Clsid}')
        .collection('S')
        .doc("${widget.Sid}")
        .collection('T')
        .doc('${widget.tid}')
        .collection('QNA')
        .snapshots().length
    }");
    return Future.delayed(Duration(seconds: 1), () async {
      return await  FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
          .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}').collection('QNA').get();
    });
  }
}
