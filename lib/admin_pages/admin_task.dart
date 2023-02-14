import 'package:app/admin_pages/add_task.dart';
import 'package:app/admin_pages/admin_subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Custom/colors.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/themes.dart';
import '../m/QuizPage.dart';
import 'ListQuestionPage.dart';
import 'addSubject.dart';
import 'admin_classes.dart';

class admin_tasks extends StatefulWidget {
  admin_tasks({Key? key,
    required this.Clsid,
    required this.Sid,
  this.cls}) : super(key: key);
  String Clsid,Sid;

  final cls;
  @override
  State<admin_tasks> createState() => _admin_tasksState();
}

class _admin_tasksState extends State<admin_tasks> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:   Text('Tasks', style:GoogleFonts.stylish(textStyle: TextStyle(
          fontSize: 34,
        ))),
        automaticallyImplyLeading: false,
        actions: [ Padding(
          padding:  EdgeInsets.only(right: 8.0),
          child: SizedBox(
            width: 50,height: 30,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Add_task(Clsid:'${widget.Clsid}', Sid: '${widget.Sid}',)
                  ),
                );
              },
              icon: const Icon(
                Icons.add_circle_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),],
      ),
      body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('classes')
              .doc('${widget.Clsid}').collection('S')
              .doc("${widget.Sid}").collection('T').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Something went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding:  EdgeInsets.only(
                  top:size.height*0.04,
                  left: size.width*0.04,
                  right: size.width*0.04),
              child: Container(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var documentSnapshot = snapshot.data?.docs;
                    return
                    Container(width: double.infinity,
                    child:   SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0).w,
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r)),
                            tileColor: Colors.white30,
                            title:
                            Text("${documentSnapshot![index]['task']}",
                                style:GoogleFonts.stylish(textStyle: TextStyle(
                                  fontSize: 24,
                                ))),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // print('  Loginemail:${widget.Loginemail},Clsid:${widget.Clsid},Sid: ${widget.Sid},id:${documentSnapshot[index].id}');
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 600),
                                  alignment: Alignment.bottomCenter,
                                  child: ListQuestionPage(
                                   Clsid: '${widget.Clsid}', Sid: '${widget.Sid}', tid: '${documentSnapshot[index].id}', ),
                                ),);

                            }),
                      ),


                    ),);


                    //   SingleChildScrollView(
                    //   scrollDirection: Axis.vertical,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(2.0),
                    //     child: ListTile(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(16)),
                    //         tileColor: Colors.white30,
                    //         title:
                    //         Text("${documentSnapshot![index]['task']}",
                    //             style: TextStyle(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w600,
                    //             )),
                    //         // subtitle: Text(""),
                    //         trailing: Icon(Icons.arrow_forward_ios),
                    //         onTap: () {
                    //           // print(  'className: ${widget.className}-${documentSnapshot![index]['task']} cls: ${widget.className}');
                    //           // Navigator.push(
                    //           //   context,
                    //           //   PageTransition(
                    //           //     type: PageTransitionType.fade,
                    //           //     duration: Duration(milliseconds: 600),
                    //           //     alignment: Alignment.bottomCenter,
                    //           //     child: ListQuestionPage(
                    //           //       className: '${widget.className}-${documentSnapshot![index]['task']}', cls: '${widget.className}',),
                    //           //   ),);
                    //
                    //         }),
                    //   ),
                    //
                    //
                    // );

                  },
                ),
              ),
            );
          }),


    );
  }
}
