import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';

import '../utils/sizeconfig.dart';

class PINCodeInput extends StatefulWidget {
  PINCodeInput(
      {Key? key,
       this.error = false,
      required this.controller,
      required this.inputLenght})
      : super(key: key);
  final int inputLenght;
  final bool error;
  final controller;

  @override
  _PINCodeInputState createState() => _PINCodeInputState();
}

class _PINCodeInputState extends State<PINCodeInput> {
//int pinLength = 6;
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autofocus: true,
      controller: widget.controller,
      highlight: true,
      hideCharacter: true,
      highlightColor: kPrimaryColor,
      defaultBorderColor: Colors.black.withOpacity(0.5),
      hasTextBorderColor: kPrimaryColor,
      highlightPinBoxColor: Colors.white,
      maxLength: widget.inputLenght,
      hasError: widget.error,
      
      
      pinBoxWidth: SizeConfig.widthOf(12),
      pinBoxHeight: SizeConfig.heightOf(6),
      wrapAlignment: WrapAlignment.spaceAround,
      pinTextStyle: TextStyle(fontSize: 22.0, color: Colors.black),
      pinBoxBorderWidth: 1,
      pinBoxRadius: 10,
      keyboardType: TextInputType.number,
    );
  }

  String getInput(String text) {
    return text;
  }
}
