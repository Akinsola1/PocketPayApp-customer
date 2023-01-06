// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';


class CustomTextField extends StatefulWidget {
  final bool? hasLeading;
  final bool? isDate;
  final bool isCard;
  final bool isAmount;
  final bool? readOnly;
  final bool? changePhoneNumber;
  final int? maxLines;
  final Widget? prefix;
  final String? hintText;
  final String? labelText;
  final Widget? trailling;
  final bool? hasBorder;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final IconData? suffixData;
  final Function? onTap;
  final String? imgUri;
  final TextInputFormatter? formatters;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final AutovalidateMode? autovalidateMode;

  ///labelText cannot be used when hintText is used
  CustomTextField({
    Key? key,
    this.isAmount = false,
    this.hasLeading = false,
    this.isDate = false,
    this.isCard = false,
    this.readOnly = false,
    this.changePhoneNumber = false,
    this.formatters,
    this.maxLines,
    this.validator,
    this.prefix,
    this.hintText,
    this.labelText,
    this.trailling = const SizedBox(),
    this.hasBorder,
    this.obscureText = false,
    this.suffixData,
    this.onTap,
    this.imgUri,
    this.controller,
    this.textInputAction = TextInputAction.done,
    this.textInputType,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hide = false;
  @override
  void initState() {
    super.initState();
    hide = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.labelText}",
            style: txStyle12Bold,
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: TextFormField(
                    inputFormatters: [
                      widget.formatters ?? FilteringTextInputFormatter.deny(''),
                    ],
                    autovalidateMode: widget.autovalidateMode,
                    keyboardType: widget.textInputType,
                    textInputAction: widget.textInputAction,
                    readOnly: widget.readOnly!,
                    controller: widget.controller,
                    // onTap: widget.onTap,
                    obscureText: hide,
                    obscuringCharacter: '•',
                    maxLines: widget.maxLines ?? 1,
                    validator: widget.validator,
                    decoration: InputDecoration(

                      prefixIcon: widget.prefix,
                      isDense: false,
                      fillColor: Colors.transparent,
                      suffixIcon: widget.obscureText!
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  hide = !hide;
                                });
                              },
                              icon: !hide
                                  ? 
                                  Icon(
                                      Icons.visibility_outlined,
                                      color: Color(0xffD5DDE0),
                                    )
                                  : Icon(
                                      Icons.visibility_off_outlined,
                                      color: Color(0xffD5DDE0),
                                    ),
                            )
                          : widget.suffixData != null
                              ? Icon(
                                  widget.suffixData,
                                )
                              : null,
                      filled: true,
                      prefix: widget.isAmount ? Text("₦") : null,
                      //labelText: widget.labelTex
                      hintText: widget.hintText,
                      hintStyle: txStyle12Bold.copyWith(color: Colors.black.withOpacity(0.5)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffD5DDE0)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kPrimaryColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                      border:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              widget.trailling!,
            ],
          ),
        ],
      ),
    );
  }
}
