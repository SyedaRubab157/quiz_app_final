import 'package:app/admin_pages/admin_subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/colors.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/themes.dart';
import '../Mobile/F-screen.dart';
import 'AddClasses.dart';
import 'ListQuestionPage.dart';
import 'UpdateClass.dart';

class classes extends StatefulWidget {
  const classes({
    Key? key,
  }) : super(key: key);

  @override
  State<classes> createState() => _classesState();
}

class _classesState extends State<classes> {
  final FirebaseAuth auth = FirebaseAuth.instance;


  deleteClass(String id) async {
    // print("User Deleted $id");
    await FirebaseFirestore.instance
        .collection('classes')
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  //signout function
  signOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => F_screen()));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: Text('No',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // <-- SEE HERE
                child: Text('Yes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    var size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Classes",     style: GoogleFonts.stylish(
              textStyle:TextStyle(
                  fontSize: 34,)),),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    signOut(context);
                  },
                  icon: Icon(Icons.logout_rounded, size: 32,)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),

                width: double.infinity,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:  StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('classes').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print('Something went Wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return  Column(
                            children:[

                              SizedBox(
                              width: 50,height: 50,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                                color: Colors.orange,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddClasses(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                              ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                var documentSnapshot = snapshot.data?.docs;
                                return

                                  GestureDetector(
                                    onTap: (){
                                      print('${documentSnapshot![index].id}');
                                      print('${documentSnapshot![index]['image']}');
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            duration: Duration(milliseconds: 600),
                                            alignment: Alignment.bottomCenter,
                                            child:subjects(className: '${documentSnapshot[index]['class']}',
                                              Clsid: '${documentSnapshot[index].id}',),
                                          ));

                                    },
                                    child:Container(
                                      decoration: BoxDecoration(  borderRadius: BorderRadius.circular(16),  boxShadow: [
                                        BoxShadow(
                                          color: theme.shadowColor.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),// changes position of shadow
                                        ),
                                        ]),

                                      height: 150,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Stack(children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.network(
                                            '${documentSnapshot![index]['image']}',width: size.width -48,
                                            fit: BoxFit.cover,),
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                Text("${documentSnapshot![index]['class']}",
                                                  style: GoogleFonts.stylish(
                                                      textStyle:TextStyle(fontWeight: FontWeight.w600,
                                                          fontSize: 45,color: Colors.white)),
                                                ),

                                                Text('${documentSnapshot![index]['description']}',
                                                  style: GoogleFonts.actor(
                                                    textStyle:TextStyle(fontWeight: FontWeight.w600,
                                                        fontSize: 16,color: Colors.white)),),
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [


                                                      SizedBox(width: 50,height: 50,
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10.0),
                                                          ),
                                                          color: Colors.blue,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        UpdateClass(  id: documentSnapshot[index].id,),
                                                                  ),
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons.edit, color: Colors.white,size: 20,
                                                              )),
                                                        ),
                                                      ), //  Edit Button
                                                      SizedBox(
                                                        width: 50,height: 50,
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10.0),
                                                          ),
                                                          color: Colors.redAccent,
                                                          child: GestureDetector(onDoubleTap: () {
                                                            deleteClass(documentSnapshot[index].id);
                                                          },
                                                            child:Icon(Icons.delete_forever),
                                                          ),
                                                        ),
                                                      ), //Delete Button
                                                    ]),

                                              ],

                                            )),
                                      ]),),
                                  );


                                  // GestureDetector(
                                  //   onTap: (){
                                  //    Navigator.push(
                                  //         context,
                                  //         PageTransition(
                                  //             type: PageTransitionType.fade,
                                  //             duration: Duration(milliseconds: 600),
                                  //             alignment: Alignment.bottomCenter,
                                  //             child:subjects(className: '${documentSnapshot[index]['class']}'),
                                  //         ));
                                  //   },
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //         color: theme.backgroundColor,
                                  //         borderRadius: BorderRadius.circular(23)),
                                  //     child:  Column(
                                  //       mainAxisAlignment: MainAxisAlignment.end,
                                  //       children: [
                                  //         Center(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(10.0),
                                  //             child: Text(
                                  //               '${documentSnapshot![index]['class']}, Class ${index + 1}/${documentSnapshot?.length}',
                                  //               style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,
                                  //                 color:theme.shadowColor,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         Row(
                                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //             children: [
                                  //
                                  //
                                  //               SizedBox(width: 50,height: 50,
                                  //                   child: Card(
                                  //               shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                 BorderRadius.circular(10.0),
                                  //               ),
                                  //               color: Colors.blue,
                                  //               child: IconButton(
                                  //                   onPressed: () {
                                  //                     Navigator.push(
                                  //                       context,
                                  //                       MaterialPageRoute(
                                  //                         builder: (context) =>
                                  //                             UpdateClass(className: "",  id: documentSnapshot[index].id,),
                                  //                       ),
                                  //                     );
                                  //                   },
                                  //                   icon: const Icon(
                                  //                     Icons.edit, color: Colors.white,size: 20,
                                  //                   )),
                                  //             ),
                                  //           ), //  Edit Button
                                  //               SizedBox(
                                  //                 width: 50,height: 50,
                                  //                 child: Card(
                                  //                   shape: RoundedRectangleBorder(
                                  //                     borderRadius:
                                  //                     BorderRadius.circular(10.0),
                                  //                   ),
                                  //                   color: Colors.redAccent,
                                  //                   child: GestureDetector(onDoubleTap: () {
                                  //                     deleteClass(documentSnapshot[index].id);
                                  //                   },
                                  //                     child:Icon(Icons.delete_forever),
                                  //                   ),
                                  //                 ),
                                  //               ), //Delete Button
                                  //         ]),
                                  //       ],
                                  //     ),
                                  //
                                  //   ),
                                  // );

                              },
                            ),]
                          );

                        }
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void DeleteClassDialog(String id) {
    AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('this is a demo alert diolog'),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            deleteClass(id);
            Navigator.of(context).pop();
            _showToast(context,'Class Deleted!');

          },
        ),
      ],
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
