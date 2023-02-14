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
class mobile extends StatefulWidget {
   mobile( {Key? key, required this.LoginEmail}) : super(key: key);
String LoginEmail;
  @override
  State<mobile> createState() => _mobileState();
}
var count;
class _mobileState extends State<mobile> {
  final FirebaseAuth auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Scaffold(
           drawer: NavDrawer(LoginEmail: '${widget.LoginEmail}',),
    body:
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar( shape:   const RoundedRectangleBorder(borderRadius: BorderRadius.only(
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
                  title: Text("What do you want to improve today?",
                      style: GoogleFonts.stylish(textStyle: TextStyle(
                        color: Colors.white,
                        fontSize:30.0,
                      ) ,)
                  ), //Text
                  background:   ColorFiltered(
                    colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
                    child: Image.asset(
                      "images/alexandre-van-thuan-mr9FouttLGY-unsplash.jpg",
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
                                     stream: FirebaseFirestore.instance.collection('classes').snapshots(),
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
                                                 onTap: (){
                                                   print("${widget.LoginEmail}");
                                                   print('${documentSnapshot![index].id}');
                                                   print('${documentSnapshot![index]['image']}');
                                                   Navigator.push(context,
                                                       PageTransition(
                                                           type: PageTransitionType.fade,
                                                           duration: Duration(milliseconds: 600),
                                                           alignment: Alignment.bottomCenter,
                                                           child: Subject_List(
                                                             Loginemail: '${widget.LoginEmail}',
                                                             classno: '${documentSnapshot![index]['class']}',
                                                             img: '${documentSnapshot![index]['image']}',
                                                           Clsid:'${documentSnapshot![index].id}',
                                                           )
                                                       ));
                                                 },
                                                 child:Container(
                                                   decoration: BoxDecoration(  borderRadius: BorderRadius.circular(16),  boxShadow: [
                                                     BoxShadow(
                                                       color: theme.shadowColor.withOpacity(0.5),
                                                       spreadRadius: 2,
                                                       blurRadius: 7,
                                                       offset: Offset(0, 2),// changes position of shadow
                                                     ),]),

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

                                                           Text('${documentSnapshot[index]['description']}',
                                                             style: GoogleFonts.actor(
                                                                 textStyle:TextStyle(fontWeight: FontWeight.w600,
                                                                     fontSize: 16,color: Colors.white)),),],)),
                                                 ]),),



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
        ) //CustonScrollView

    );
  }

    void signOut(BuildContext context) async {
      await auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => F_screen()));
    }
}
