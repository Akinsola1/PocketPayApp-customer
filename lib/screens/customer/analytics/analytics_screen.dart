import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
              Text(
                "Analytics",
                style: txStyle27Bold.copyWith(color: appPrimaryColor),
              ),
              // LineChart(
              //   LineChartData(
              //       // read about it in the LineChartData section
              //       ),
              //   swapAnimationDuration: Duration(milliseconds: 150), // Optional
              //   swapAnimationCurve: Curves.linear, // Optional
              // )
            ],
          ),
        ),
      ),
    );
  }
}
