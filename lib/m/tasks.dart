import 'package:app/admin_pages/add_task.dart';
import 'package:app/admin_pages/admin_subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Custom/colors.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/themes.dart';
import '../Mobile/F-screen.dart';
import '../admin_pages/ListQuestionPage.dart';
import 'NavDrawer.dart';
import 'QuizPage.dart';

class tasks extends StatefulWidget {
  tasks({Key? key,
    required this.Loginemail,required this.Sid,required this.Clsid}) : super(key: key);

  String Loginemail;
  String Sid;
  String Clsid;
  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_4_rounded),
              onPressed: () {
                currentTheme.toggleTheme();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26.r),
                  bottomRight: Radius.circular(26.r))),
        ),
        drawer: NavDrawer(
          LoginEmail: '${widget.Loginemail}',
        ),
        body:  StreamBuilder(
            stream: FirebaseFirestore.instance.collection('classes')
                .doc('${widget.Clsid}').collection('S').doc("${widget.Sid}").collection('T').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Something went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                child:

                ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var documentSnapshot = snapshot.data?.docs;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:      Wrap(
                        // space between chips
                        // spacing: 10,
                        // list of chips
                          children:  [
                            GestureDetector(
                              child: Chip(
                                label: Text('${documentSnapshot![index]['task']}'),
                                avatar: Icon(
                                  Icons.task,
                                  color: theme.canvasColor,
                                ),
                                backgroundColor: theme.primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              ),
                              onTap: (){
         print("Loginemail: '${widget.Loginemail}',Clsid:' ${widget.Clsid}', Sid: '${widget.Sid}', tid: '${documentSnapshot![index].id}',");
                                Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 600),
                                  alignment: Alignment.bottomCenter,
                                  child:
                               QuizPage(Loginemail: '${widget.Loginemail}',Clsid:' ${widget.Clsid}',
                                 Sid: '${widget.Sid}', tid: '${documentSnapshot![index].id}',),


                                ),);},
                            ),
                          ]),

                    );
                  },
                ),
              );

            }),

    );
  }

  void signOut(BuildContext context) async {
    await auth.signOut();
    PageTransition(
      type: PageTransitionType.fade,
      duration: Duration(milliseconds: 600),
      alignment: Alignment.bottomCenter,
      child: F_screen(),
    );
  }
}

