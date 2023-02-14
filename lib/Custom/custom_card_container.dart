import 'package:app/Custom/themes.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../m/HomePage.dart';
import '../admin_pages/admin_classes.dart';
import 'colors.dart';

class CustomCardContainer extends StatelessWidget {
   const CustomCardContainer(
      {Key? key,
      required this.listTileTitle,
      this.listTileSubtitle,
      this.width,
      this.height,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.goto})
      : super(key: key);

  final String listTileTitle;
  final String? listTileSubtitle;
  final double? width, height, left, top, right, bottom;
  final Widget? goto;
  final String subtitle = '';

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Container(
        padding:
            EdgeInsets.fromLTRB(left ?? size.width*0.03, top ?? size.height*0.01, right ?? size.width*0.03, bottom ?? size.height*0.01),
            width: width ?? size.width*10,   height: height ?? size.height*10,

        child: Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),),
            color: Palette.honey_yellowO,
          child: Center(
            child: ListTile(
              onTap: () {

                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 600),
                        alignment: Alignment.bottomCenter,
                        childCurrent: this,
                        child: goto?? classes()));

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => goto??  classes(), //goto is a widget
                //     ));
              },
              title: Center(
                child: Padding(
                  padding: EdgeInsets.only(top:9),
                  child: Text(listTileTitle,
                      style:  TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Katibeh',
                          letterSpacing: 2,
                          color:Palette.shade9)),
                ),
              ),
              subtitle: listTileSubtitle == null
                  ? Text(subtitle)
                  : Text(listTileSubtitle!,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xff023047))),
            ),
          ),
        ),

    );
  }
}
