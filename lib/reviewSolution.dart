import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'm/finishPage.dart';
class reviewSolution extends StatefulWidget {
   reviewSolution({Key? key,required this.Sid,required this.Clsid,required this.tid}) : super(key: key);
  String Clsid,Sid,tid;
  @override
  State<reviewSolution> createState() => _reviewSolutionState();
}

class _reviewSolutionState extends State<reviewSolution> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return  Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top:9).h,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
              .collection('S').doc('${widget.Sid}').collection('T').doc('${widget.tid}').collection('QNA')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Something went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            //listview builder
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                var documentSnapshot = snapshot.data?.docs;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                  child: Container(

                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        //Question Index No's
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  '${index + 1}/${documentSnapshot?.length} ',
                                  style:GoogleFonts.stylish(textStyle: TextStyle(
                                    fontSize: 24,
                                  ))),
                            ),
                          ],
                        ),
                        Card(
                          color: theme.primaryColor.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 13, 10, 10),
                            child: Column(children: [

                              //Question Here
                              Row(
                                children: [
                                  Text(
                                      'Q:',
                                      style:GoogleFonts.stylish(textStyle: TextStyle(
                                        fontSize: 24,
                                      ))
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 400,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 22, vertical: 10),
                                        child: Text(
                                            '${documentSnapshot![index]['ques']}',
                                            style:GoogleFonts.stylish(textStyle: TextStyle(
                                              fontSize: 24,
                                            ))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //True Option
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          ':T',
                                          textDirection: TextDirection.rtl,
                                          style:GoogleFonts.stylish(textStyle: TextStyle(
                                            fontSize: 24,
                                          ))
                                      )),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: 300,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(14.0),
                                        ),
                                        color: Colors.green,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              '${documentSnapshot[index]['c_ans']}',
                                              style:GoogleFonts.stylish(textStyle: TextStyle(
                                                fontSize: 24,
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
