import "package:flutter/material.dart";


class Bar extends StatelessWidget implements PreferredSizeWidget{
  const Bar({Key? key}) : super(key: key);  
   @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Edit Existing Todo"),
      centerTitle: true,
    );
  }

}