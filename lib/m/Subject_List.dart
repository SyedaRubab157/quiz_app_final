import 'package:app/m/HomePage.dart';
import 'package:app/m/settings.dart';
import 'package:app/Mobile/F-screen.dart';
import 'package:app/m/tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Custom/colors.dart';
import '../Custom/custom_app_bar.dart';
import '../Custom/custom_card_container.dart';
import '../Custom/feedback.dart';
import '../Custom/themes.dart';
import '../admin_pages/admin_task.dart';
import 'NavDrawer.dart';
import 'QuizPage.dart';
import 'package:animations/animations.dart';

class Subject_List extends StatefulWidget {
  Subject_List({Key? key,required this.Clsid, required this.classno, required this.img,required this.Loginemail})
      : super(key: key);
  String classno;
  String Loginemail;
  String img;
  String Clsid;

  @override
  State<Subject_List> createState() => _Subject_ListState();
}

class _Subject_ListState extends State<Subject_List> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);


    return Scaffold(
        drawer: NavDrawer(
          LoginEmail: '${widget.Loginemail}',
        ),
        body:
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape:   const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              ),
              shadowColor: theme.shadowColor,
              snap: false,
              pinned: false,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('${widget.classno}',
                    style: GoogleFonts.stylish(textStyle: TextStyle(
                      color: Colors.white,
                      fontSize:30.0,
                    ) ,)
                ), //Text

                background:   ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                  child: Image.network(
                    '${widget.img}',
                    fit: BoxFit.cover,
                  ),
                ),//Images.network
              ), //FlexibleSpaceBar
              expandedHeight: 230,
              backgroundColor:theme.primaryColor,
              //IconButton
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_4_rounded),
                  onPressed: () {currentTheme.toggleTheme();},
                ),
              ],//
              // <Widget>[]
            ), //SliverAppBar
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) =>

                    SingleChildScrollView(
                      child:
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
                        child:
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child:  StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('classes')
                                    .doc('${widget.Clsid}').collection('S').snapshots(),
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
                                                    fontWeight: FontWeight.bold,
                                                  ))
                                              ),
                                              subtitle: Text(""),
                                              trailing: Icon(Icons.arrow_forward_ios),
                                            ),
                                          ),
                                          onTap: (){

                                            print("${widget.Loginemail}");
                                            print("    Loginemail: ${widget.Loginemail},Clsid:${widget.Clsid},Sid:${documentSnapshot[index].id},");
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                duration: Duration(milliseconds: 600),
                                                alignment: Alignment.bottomCenter,
                                                child:
                                                tasks(
                                                  Loginemail: '${widget.Loginemail}', Clsid:'${widget.Clsid}',Sid:'${documentSnapshot[index].id}',),

                                              ),
                                            );


                                          }



                                        );

                                    },
                                  );

                                }
                            )
                        ),



                      ),



                    ),
                childCount: 1,
              ), //SliverChildBuildDelegate
            ) //SliverList
          ], //<Widget>[]
        ),



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
