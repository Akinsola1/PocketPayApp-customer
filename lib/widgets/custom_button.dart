// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/constant/text_Style.dart';
import 'package:provider/provider.dart';





class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.textColor = Colors.white,
      this.buttonColor,
      this.borderColor,
      this.loading = false, })
      : super(key: key);

  final String label;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final bool loading;
  

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: widget.buttonColor ?? appPrimaryColor,
          border: Border.all(color:widget.borderColor ?? appPrimaryColor ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: widget.loading ? CircularProgressIndicator(color: Colors.white): Text(
            widget.label,
            textAlign: TextAlign.center,
            style: txStyle14.copyWith(color: widget.textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}
