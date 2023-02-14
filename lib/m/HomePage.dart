import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import '../Desktop/desktop.dart';
import '../Mobile/mobile.dart';
import 'NavDrawer.dart';
class HomePage extends StatefulWidget {
   HomePage({Key? key, required this.Loginemail, }) : super(key: key);
String Loginemail;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Are you sure?',style: TextStyle(color: Theme.of(context).hintColor,fontWeight: FontWeight.w500),),
        content: Text('Do you want to exit App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            //<-- SEE HERE
            child: Text('No',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Theme.of(context).hintColor,)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            // <-- SEE HERE
            child: Text('Yes',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Theme.of(context).hintColor)),
          ),
        ],
      ),
    )) ??
        false;
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
      return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,



               body: WillPopScope(
              onWillPop: _onWillPop,
              child:   LayoutBuilder( builder: (context, Constraints) {
                if(Constraints.maxWidth<768)
                { return mobile(LoginEmail: "${widget.Loginemail}",); }

                else
                {
                  return desktop(LoginEmail: "${widget.Loginemail}",);
                  // return Text("hi ",style: TextStyle(fontSize: 50),);
                }
              }
              )



          ),
        );


  }
}


