import 'package:app/admin_pages/admin_subjects.dart';
import 'package:app/admin_pages/admin_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Custom/AppBar.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import '../m/HomePage.dart';
import 'AddQuestion.dart';
import 'UpdateQuestion.dart';
import 'admin_classes.dart';

class ListQuestionPage extends StatefulWidget {
  ListQuestionPage({
    Key? key,

    required this.Clsid,
    required this.Sid,
    required this.tid,
  }) : super(key: key);
  String Clsid,Sid,tid;

  @override
  State<ListQuestionPage> createState() => _ListQuestionPageState();
}

class _ListQuestionPageState extends State<ListQuestionPage> {
  var id = '';

  deleteUser(String id) async {
    _showToast(context,'Question Deleted!');
    print("User Deleted $id");
    await
    FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
        .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}').collection('QNA')
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context,)
  {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddQuestion(
                    tid: '${widget.tid}',
                    Clsid: '${widget.Clsid}', Sid: '${widget.Sid}',

                  ),
                ),
              );
            },
            child: Text(
              'Add ',  style:GoogleFonts.stylish(textStyle: TextStyle(
              fontSize: 24,
            ))
            ),
          ),
        ],
        title: Text(
            'Question',
            style:GoogleFonts.stylish(textStyle: TextStyle(
              fontSize: 34,
            ))),

      automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
              .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}').collection('QNA')
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              print('Something went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(
                child: CircularProgressIndicator(),
              );
            }
            print("length ${snapshot.data?.docs.length}");
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

                              //False Option 1
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        ':F',
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
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              '${documentSnapshot[index]['w_ans1']}',
                                              style:GoogleFonts.stylish(textStyle: TextStyle(
                                                fontSize: 24,
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //False Option 2
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        ':F',
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
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              '${documentSnapshot[index]['w_ans2']}',
                                              style:GoogleFonts.stylish(textStyle: TextStyle(
                                                fontSize: 24,
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //False Option 3
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        ':F',
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
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              '${documentSnapshot[index]['w_ans3']}',
                                              style:GoogleFonts.stylish(textStyle: TextStyle(
                                                fontSize: 24,
                                              ))),
                                        ),
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

                              Container(
                                child: Row(
                                  children: [

                                    const SizedBox(width: 280,),

                                  //  Edit Button
                                    SizedBox(width: 50,height: 50,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        color: Colors.blue,
                                        child: IconButton(
                                            onPressed: () {
                                              print('   id: ${documentSnapshot[index].id}');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateQuestion(
                                                        tid: '${widget.tid}',
                                                        Clsid: '${widget.Clsid}', Sid: '${widget.Sid}',
                                                        qid: '${documentSnapshot[index].id}',
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit, color: Colors.white,size: 20,
                                            )),
                                      ),
                                    ),

                                    const SizedBox(width: 5,),

                                    //Delete Button
                                    SizedBox(
                                      width: 50,height: 50,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        color: Colors.redAccent,
                                        child: IconButton(
                                          onPressed: () {
                                            deleteUser(documentSnapshot[index].id);
                                            // _showToast(context,'Question Deleted!');
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
          }),
    );
  }
}
void _showToast(BuildContext context,title) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18,fontFamily: 'Comfortaa')),
        ],
      ),
    ),
  );
}
