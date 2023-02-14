import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.title ,
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onMenuActionTap})
      : super(key: key);

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25 / 2.5),
      child: Stack(
          children: [
        Positioned.fill(
          child: titleWidget == null
              ? Center(
                  child: Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color:Colors.white,
                      )),
                )
              : Center(child: titleWidget!),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ??
                Transform.translate(
                  offset: const Offset(-14, 0),
                  child: BackButton(color: Colors. transparent),
                ),
            if (showActionIcon)
              Transform.translate(
                offset: const Offset(10, 0),
                child: InkWell(
                  onTap: () {
                    onMenuActionTap!();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.menu,size: 36,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              )
          ],
        )
      ]),
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, 80);
}
