import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_business_model.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/merchant/business/merchant_generate_qr_code_screen.dart';
import 'package:pocket_pay_app/screens/merchant/business/merchant_scan_to_pay_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../utils/utils.dart';
import '../../../widgets/custom_imaga.dart';
import '../../customer/main/home_screen.dart';

class BusinessScreen extends StatefulWidget {
  final Datum data;
  const BusinessScreen({super.key, required this.data});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "${widget.data.businessName}",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
        child: RefreshIndicator(
          color: appPrimaryColor,
          onRefresh: () async {
            await userProv
                .fetchBusinessQrCodeTransaction("${widget.data.businessId}");
          },
          child: ListView(
            children: [
              vertical20,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: appPrimaryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            (widget.data.businessWalletBalance == "0.00")
                                ? "₦0"
                                : convertStringToCurrency(
                                    "${widget.data.businessWalletBalance}"),
                            style: txStyle27,
                          ),
                          Text(
                            "Balance",
                            style: txStyle14,
                          ),
                        ],
                      ),
                      Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: appPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: txStyle14wt,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              vertical20,
              businessAction(
                title: "Generate Qr code",
                icon: Icons.qr_code,
                onTap: () {
                  Get.to(MerchantGenerateQrCodeScreen(
                    businessId: widget.data.businessId!,
                  ));
                },
              ),
              vertical10,
              businessAction(
                title: "Scan Qr code",
                icon: UniconsLine.qrcode_scan,
                onTap: () {
                  Get.to(MerchantScanQrCodeScreen(businessId: widget.data.businessId!,));
                },
              ),
              vertical10,
              businessAction(
                title: "History",
                icon: UniconsLine.history,
                onTap: () {},
              ),
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
                    style: txStyle11.copyWith(color: appPrimaryColor),
                  )
                ],
              ),
              vertical20,
              ResponsiveState(
                  state: userProv.state,
                  busyWidget: Center(
                    child: CircularProgressIndicator(color: appPrimaryColor),
                  ),
                  idleWidget: userProv.merchantQrcodeHistory.data!.isEmpty
                      ? Column(
                          children: [
                            vertical30,
                            Center(
                              child: Text(
                                "You are yet to perform any transaction. Transactions carried out with QR code will be displayed here.",
                                textAlign: TextAlign.center,
                                style: txStyle12.copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              (userProv.businessQrCodeHistory.data!.length < 5)
                                  ? userProv.businessQrCodeHistory.data!.length
                                  : 5,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // showModalBottomSheet(
                                //     backgroundColor: Colors.white,
                                //     isScrollControlled: true,
                                //     isDismissible: true,
                                //     shape: const RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.only(
                                //           topLeft: Radius.circular(10),
                                //           topRight: Radius.circular(10)),
                                //     ),
                                //     context: context,
                                //     builder: (context) => TransactionDetails(
                                //           transaction: userProv
                                //               .businessQrCodeHistory.data!
                                //               .elementAt(index),
                                //         ));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CustomNetworkImage(
                                        radius: 50,
                                        imageUrl: userProv
                                                    .businessQrCodeHistory.data
                                                    ?.elementAt(index)
                                                    .status ==
                                                "Pending"
                                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlHMlGaIm-FgKBskWObPrJh6jkx9vUXEreyw&usqp=CAU"
                                            : "${userProv.businessQrCodeHistory.data?.elementAt(index).merchantBusinessLogo}"),
                                    title: Text(
                                      userProv.businessQrCodeHistory.data
                                                  ?.elementAt(index)
                                                  .status ==
                                              "Pending"
                                          ? "Qr code not used"
                                          : userProv.businessQrCodeHistory.data
                                                      ?.elementAt(index)
                                                      .status ==
                                                  "Expired"
                                              ? "Qr code expired"
                                              : "${userProv.businessQrCodeHistory.data?.elementAt(index).merchantBusinessName}",
                                      style: txStyle14Bold,
                                    ),
                                    subtitle: Text(
                                      DateFormat.MMMMd().format(userProv
                                              .businessQrCodeHistory.data
                                              ?.elementAt(index)
                                              .dateCreated ??
                                          DateTime.now()),
                                      style: txStyle12,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          convertStringToCurrency(
                                              "${userProv.businessQrCodeHistory.data?.elementAt(index).amount}"),
                                          style: txStyle14,
                                        ),
                                        vertical5,
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(transactionStatus(
                                                  "${userProv.businessQrCodeHistory.data?.elementAt(index).status}"))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          }))
            ],
          ),
        ),
      ),
    );
  }
}

class businessAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const businessAction({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: appPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Icon(icon),
            horizontalx10,
            Text(
              title,
              style: txStyle14,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ]),
        ),
      ),
    );
  }
}
