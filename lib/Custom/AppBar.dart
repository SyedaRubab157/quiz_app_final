import 'package:app/Custom/themes.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CAppBar extends StatelessWidget {
  const CAppBar({
    Key? key,
    this.paddingAll,
    this.appbarBgColor,
    required this.title,
    this.titleSpacing,
    this.fontSize,
    this.elevation,
    this.leadingWidget,
    this.actionWidget,
    this.onTapActionWidget,
    this.onTapActionLeading,
  }) : super(key: key);

  final String title;
  final String? appbarBgColor;
  final double? titleSpacing, fontSize, elevation, paddingAll;
  final Widget? leadingWidget, actionWidget;
  final VoidCallback? onTapActionWidget;
  final VoidCallback? onTapActionLeading;

  @override
  Widget build(BuildContext context) {
    return  AppBar( toolbarHeight: 80,
        automaticallyImplyLeading: true,
        backgroundColor: Palette.darkblue,
          title: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  wordSpacing: titleSpacing ?? 1.5,
                  fontSize: fontSize ?? 36,
                  fontWeight: FontWeight.bold),),
                  centerTitle: true,
                  elevation: elevation ?? 10,

       leading: leadingWidget ??
              IconButton(
                onPressed: () {
                  onTapActionLeading!();    //function to be defined where we gonna use it
                },
                icon: const Icon(Icons.arrow_back, color: Colors.transparent, size: 26),
              ) ,


        actions: [
              actionWidget ??
                IconButton( onPressed: () { onTapActionWidget!();},
                    icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon( Icons.logout,  color: Colors.transparent, size: 26, ),
                  ),
                ),
              ],
                // shape: OutlineInputBorder(borderRadius: BorderRadius.circular(7),),
      );
  }
}


