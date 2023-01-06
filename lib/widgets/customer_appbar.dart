import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Color color;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  const CustomAppBar({
    Key? key,
    this.title = "",
    this.leading,
    this.color = Colors.transparent,
    this.actions,
    this.titleStyle,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: actions,
      backgroundColor: color,
      leadingWidth: 16,
      leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black, size: 25)),

      //BackButton(color: Theme.of(context).primaryColor, onPressed: ()=> Navigator.pop(context),),
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
