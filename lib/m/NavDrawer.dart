
import 'package:app/Mobile/F-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/colors.dart';
import '../Custom/feedback.dart';
import 'HomePage.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer({Key? key, this.LoginEmail}) : super(key: key);
  final LoginEmail;
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //signout function
  signOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => F_screen()));
  }
  late String title;
  late String icon;
  late String page;
  // late String context;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var theme=Theme.of(context);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.8),
      width: 240,
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:
                  Column(
                    children: [
                      CircleAvatar(radius: 56, backgroundColor: theme.hintColor,
                        child: CircleAvatar(
                          radius: 52,
                          backgroundImage: AssetImage('images/bg.jpg'),
                        ),),
                      SizedBox(height: 8,),
                      Text(
                        '${widget.LoginEmail}',
                        style: TextStyle( color: theme.shadowColor,fontWeight: FontWeight.bold, fontSize: 15),
                      ),

                    ],
                  ),

            ),
            decoration: BoxDecoration(
                color: theme.backgroundColor.withOpacity(0.2),
                  ),
          ),
          ListTile(
            leading: Icon(Icons.login_rounded,color: Colors.white),
            title: Text('Login',style: TextStyle(color: theme.shadowColor,fontWeight: FontWeight.bold)),
            onTap: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 100),
                      alignment: Alignment.bottomCenter,
                      // childCurrent: this,
                      child: F_screen()))
            },
          ),//login
          d(),
          ListTile(
            leading: Icon(Icons.home_rounded,color: Colors.white),
            title: Text('Home',style: TextStyle(color: theme.shadowColor,fontWeight: FontWeight.bold)),
            onTap: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 100),
                      alignment: Alignment.bottomCenter,
                      // childCurrent: this,
                      child: HomePage(Loginemail: '', )))
            },
          ),//home
          d(),
          ListTile(
            leading: Icon(Icons.border_color,color: Colors.white),
            title: Text('Feedback',style: TextStyle(color: theme.shadowColor,fontWeight: FontWeight.bold)),
            onTap: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                      alignment: Alignment.bottomCenter,
                      child: FeedbackDialog(),))

            },
          ),//feedback
          d(),
          ListTile(
            leading: Icon(Icons.logout_rounded,color: Colors.white),
            title: Text('Logout',style: TextStyle(color: theme.shadowColor,fontWeight: FontWeight.bold)),
            onTap: () => {
            signOut(context),
            },
          ),
          //logout
        ],
      ),
      
    );
  }

  d() {
   return  Divider(
     thickness: 0.1,
     indent: 20,
     endIndent: 20,
     color: Colors.white,
     height: 1,
   );
  }
}
