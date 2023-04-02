import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/merchant_create_business_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../api/repositories/merchant_repository.dart';
import '../../../widgets/custom_imaga.dart';
import 'business_home_screen.dart';

class MerchantBusinessScreen extends StatefulWidget {
  const MerchantBusinessScreen({super.key});

  @override
  State<MerchantBusinessScreen> createState() => _MerchantBusinessScreenState();
}

class _MerchantBusinessScreenState extends State<MerchantBusinessScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Business",
                style: txStyle25Bold.copyWith(color: appPrimaryColor),
              ),
              vertical30,
              SizedBox(
                height: 150,
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  Get.to(MerchantCreateBusinessProfileScreen(
                                    isSignup: false,
                                  ));
                                },
                                icon: Icon(Icons.add)),
                          ),
                        ),
                        vertical10,
                        Text(
                          "Add Business",
                          style: txStyle14Bold,
                        ),
                        Spacer()
                      ],
                    ),
                    horizontalx20,
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return horizontalx10;
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              userProv.merchantBusinessModel.data!.length,
                          itemBuilder: (context, index) {
                            var business = userProv.merchantBusinessModel.data
                                ?.elementAt(index);
                            return InkWell(
                              onTap: () {
                                userProv.fetchBusinessQrCodeTransaction(
                                    "${business?.businessId}");
                                Get.to(BusinessScreen(
                                    data: userProv.merchantBusinessModel.data!
                                        .elementAt(index)));
                              },
                              child: Column(
                                children: [
                                  CustomNetworkImage(
                                    imageUrl: "${business?.businessLogo}",
                                    radius: 80,
                                  ),
                                  vertical10,
                                  Text(
                                    "${business?.businessName}",
                                    style: txStyle14Bold,
                                  ),
                                  vertical5,
                                  Text(
                                    "${business?.businessId}",
                                    style:
                                        txStyle12.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Divider(),
              vertical20,
              Text(
                "Business analytics",
                style: txStyle14Bold,
              ),
              vertical20,
              SizedBox(
                height: 400,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //Initialize the spark charts widget
                    child: Container(
                        child: SfCircularChart(
                            legend: Legend(isVisible: true),
                            series: <CircularSeries>[
                          // Renders radial bar chart
                          RadialBarSeries<BusinessData, String>(
                            dataSource: userProv.businessDataList,
                            xValueMapper: (BusinessData data, _) =>
                                data.business,
                            yValueMapper: (BusinessData data, _) => data.amount,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          )
                        ]))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessData {
  BusinessData(this.business, this.amount);

  final String business;
  final double amount;
}
