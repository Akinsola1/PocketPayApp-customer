// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/user_repository.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/api/responsiveState/view_state.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/constant/text_Style.dart';
import 'package:provider/provider.dart';

class CustomButtonLoad1 extends StatefulWidget {
  const CustomButtonLoad1({
    Key? key,
    required this.onTap,
    required this.label,
    this.textColor = Colors.white,
    this.buttonColor,
    this.borderColor,
    required this.userProv,
  }) : super(key: key);

  final String label;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final ViewState userProv;

  @override
  _CustomButtonLoad1State createState() => _CustomButtonLoad1State();
}

class _CustomButtonLoad1State extends State<CustomButtonLoad1> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: widget.buttonColor ?? appPrimaryColor,
          border: Border.all(color: widget.borderColor ?? appPrimaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ResponsiveState(
            state: widget.userProv,
            idleWidget: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: txStyle14.copyWith(color: widget.textColor ?? Colors.black),
            ),
            busyWidget:
                CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
