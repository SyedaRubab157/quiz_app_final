import 'package:app/admin_pages/admin_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Custom/colors.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/themes.dart';
import '../m/tasks.dart';
import 'ListQuestionPage.dart';
import 'addSubject.dart';
import 'admin_classes.dart';

class subjects extends StatefulWidget {
   subjects({Key? key,  required this.className,required this.Clsid}) : super(key: key);
    String className;
    String Clsid;

  @override
  State<subjects> createState() => _subjectsState();
}

class _subjectsState extends State<subjects> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:   Text(
           'subjects', style:GoogleFonts.stylish(textStyle: TextStyle(
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
                    builder: (context) => Add_Subject( Clsid: '${widget.Clsid}',),
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
              stream: FirebaseFirestore.instance.collection('classes')
              .doc('${widget.Clsid}').collection('S').snapshots(),
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

                          GestureDetector(
                              child:    Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r)),
                                  tileColor: Colors.white30,
                                  leading:  Container(width: 50,
                                    child: ClipRRect(borderRadius: BorderRadius.circular(6.r),
                                        child: Image.network("${documentSnapshot![index]['image']}",fit: BoxFit.cover,)),
                                  ),
                                  title:
                                  Text("${documentSnapshot![index]['subject']}",
                                      style:GoogleFonts.stylish(textStyle: TextStyle(
                                        fontSize: 24,
                                      ))
                                  ),
                                  subtitle: Text(""),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 600),
                                    alignment: Alignment.bottomCenter,

                                    child:  admin_tasks(
                                      cls: '${widget.className}', Clsid: '${widget.Clsid}', Sid: '${documentSnapshot[index].id}',


                                    ),
                                    //
                                    // ListQuestionPage(
                                    //   subjectName: '${documentSnapshot![index]['subject']}',
                                    //   className: '${widget.className}',),
                                  ),);


                              }



                          );




                      },
                    ),
                  ),
                );
              }),


    );
  }
}
