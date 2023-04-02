import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';

import '../constant/export_constant.dart';

class SwitchToggle extends StatefulWidget {
  bool serviceToggle;
  final String service;
  final Function(bool value) function;

  SwitchToggle(
      {super.key,
      required this.serviceToggle,
      required this.service,
      required this.function});

  @override
  State<SwitchToggle> createState() => _SwitchToggleState();
}

class _SwitchToggleState extends State<SwitchToggle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.service,
              style: txStyle14,
            ),
            FlutterSwitch(
                width: 43,
                height: 25,
                toggleSize: 20.0,
                valueFontSize: 12,
                value: widget.serviceToggle,
                borderRadius: 30.0,
                activeColor: appPrimaryColor,
                onToggle: widget.function

                // (val) {
                //   widget.function;

                //   setState(() {
                //     widget.serviceToggle = val;
                //   });
                // },
                ),
          ],
        ),
        Divider()
      ],
    );
  }
}
