
import 'package:flutter/material.dart';

class bottomSheetDrag extends StatelessWidget {
  const bottomSheetDrag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:5,
      width: 50,
      decoration: BoxDecoration(
          color: Color(0xffEAEAEA),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
