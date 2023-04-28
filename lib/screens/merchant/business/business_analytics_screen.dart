import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/constant/colors.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../api/repositories/merchant_repository.dart';
import '../../../constant/text_Style.dart';

class BusinessAnalytics extends StatefulWidget {
  const BusinessAnalytics({super.key});

  @override
  State<BusinessAnalytics> createState() => _BusinessAnalyticsState();
}

class _BusinessAnalyticsState extends State<BusinessAnalytics> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Business",
                style: txStyle25Bold.copyWith(color: appPrimaryColor),
              ),
              SizedBox(
                height: 300,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //Initialize the spark charts widget
                    child: Container(
                        child: SfCartesianChart(
                            primaryXAxis: DateTimeAxis(),
                            series: <ChartSeries>[
                          // Renders radial bar chart
                          LineSeries<BusinessSalesData, DateTime>(
                            dataSource: userProv.individualBusinessData,
                            xValueMapper: (BusinessSalesData data, _) =>
                                data.time,
                            yValueMapper: (BusinessSalesData data, _) =>
                                data.amount,
                            // dataLabelSettings: DataLabelSettings(isVisible: true),
                          )
                        ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessSalesData {
  BusinessSalesData(this.time, this.amount);

  final DateTime time;
  final double amount;
}
