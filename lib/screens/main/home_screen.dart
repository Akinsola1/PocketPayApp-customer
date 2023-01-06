import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/constant/size.dart';
import 'package:pocket_pay_app/screens/generate_to_pay/generate_to_pay.dart';
import 'package:pocket_pay_app/screens/scan_to_pay/confirm_transaction_screen.dart';
import 'package:pocket_pay_app/screens/scan_to_pay/scan_to_pay_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: SizeConfig.heightOf(10),
                    width: SizeConfig.widthOf(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kPrimaryColor, width: 1),
                    ),
                    child: Center(
                        child: Icon(
                      UniconsLine.user_exclamation,
                      size: SizeConfig.heightOf(3),
                    )),
                  ),
                  horizontalx10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Akinsola Faruq",
                        style: txStyle14Bold,
                      ),
                      Text(
                        "Akinsola1",
                        style: txStyle12,
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                UniconsLine.bell,
                size: SizeConfig.heightOf(3),
              )
            ],
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "₦18,000",
                  style: txStyle27,
                ),
                Text(
                  "Balance",
                  style: txStyle14,
                ),
                vertical20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    appOptions(
                      icon: UniconsLine.wallet,
                      title: "Found",
                      onpressed: () {
                        
                      },
                    ),
                    appOptions(
                      icon: UniconsLine.history,
                      title: "History",
                      onpressed: () {
                        
                      },
                    ),
                    appOptions(
                      icon: UniconsLine.qrcode_scan,
                      title: "Scan",
                      onpressed: () {
                        Get.to(ConfirmTransactionScreen());
                      },
                    ),
                    appOptionsWithImage(
                      image: "assets/images/qr-code.png",
                      title: "Pay",
                      onpressed: () {
                        Get.to(GenerateToPayScreen());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          vertical20,
          Text(
            "Todo",
            style: txStyle14Bold,
          ),
         const todoWidget(title: "Complete KYC", subtitle: "Provide Necessary document to verify your identity"),
          vertical10,
          const todoWidget(title: "Add Credit Card", subtitle: "Link your Credit card with Pocket Pay for quick \nwallet founding"),

          vertical20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "History",
                style: txStyle14Bold,
              ),
              Text(
                "See all >>",
                style: txStyle11.copyWith(color: kPrimaryColor),
              )
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const CustomNetworkImage(
                      radius: 50,
                      imageUrl:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMjHCjAx96ezsVKdwBY3W7Qkwbs1S7pIKyOA&usqp=CAU"),
                  title: Text(
                    "ABUAD CAF 1",
                    style: txStyle12Bold,
                  ),
                  subtitle: Text(
                    "Monday, 25 january",
                    style: txStyle12,
                  ),
                  trailing: Text(
                    "₦1,200",
                    style: txStyle14,
                  ),
                );
              })
        ],
      ),
    ));
  }
}

class todoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const todoWidget({
    Key? key, required this.title, required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightOf(2),
            horizontal: SizeConfig.widthOf(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: txStyle12Bold),
                SizedBox(
                  width: SizeConfig.widthOf(80),
                  child: Text(
                      subtitle,
                      
                      overflow: TextOverflow.ellipsis,
                      style: txStyle12.copyWith(height: 1.5)),
                )
              ],
            ),
            Container(
              height: SizeConfig.heightOf(2),
              width: SizeConfig.heightOf(2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor)),
            )
          ],
        ),
      ),
    );
  }
}

class appOptions extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpressed;
  const appOptions({
    Key? key,
    required this.title,
    required this.icon,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      splashColor: kPrimaryColor,
      child: Container(
        height: SizeConfig.heightOf(10),
        width: SizeConfig.widthOf(20),
        padding: EdgeInsets.all(SizeConfig.heightOf(2)),
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: SizeConfig.heightOf(2),
            ),
            Text(
              title,
              style: txStyle12.copyWith(height: 1.5),
            )
          ],
        ),
      ),
    );
  }
}

class appOptionsWithImage extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onpressed;
  const appOptionsWithImage({
    Key? key,
    required this.title,
    required this.image,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      splashColor: kPrimaryColor,
      child: Container(
        height: SizeConfig.heightOf(10),
        width: SizeConfig.widthOf(20),
        padding: EdgeInsets.all(SizeConfig.heightOf(2)),
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: SizeConfig.heightOf(2),
              width: SizeConfig.heightOf(2),
            ),
            Text(
              title,
              style: txStyle12.copyWith(height: 1.5),
            )
          ],
        ),
      ),
    );
  }
}
