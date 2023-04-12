import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/api/models/customer/qr_code_transaction_model.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/constant/size.dart';
import 'package:pocket_pay_app/screens/customer/generate_to_pay/generate_to_pay.dart';
import 'package:pocket_pay_app/screens/customer/main/complete_profile_setup_screen.dart';
import 'package:pocket_pay_app/screens/customer/fund/fund_wallet_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/view_qrcode_screen.dart';
import 'package:pocket_pay_app/screens/customer/scan_to_pay/confirm_transaction_screen.dart';
import 'package:pocket_pay_app/screens/customer/scan_to_pay/scan_to_pay_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../widgets/bottomSheetDrag.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    return Scaffold(
        body: SafeArea(
      child: ResponsiveState(
        state: userProv.state,
        busyWidget: SpinKitFadingCircle(color: Colors.black),
        idleWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: RefreshIndicator(
            color: appPrimaryColor,
            onRefresh: () async {
              final userProv =
                  Provider.of<UserProvider>(context, listen: false);
              await userProv.fetchCustomerProfile();
              await userProv.fetchQrCodeTransactions();
              await userProv.fetchFlwTransactions();
            },
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomNetworkImage(
                            imageUrl:
                                "${userProv.userProfile.data?.profilePicture}",
                            radius: 45),
                        horizontalx5,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalizeFirstText(
                                  "${userProv.userProfile.data?.firstName}"
                                  " ${userProv.userProfile.data?.lastName}"),
                              style: txStyle14Bold,
                            ),
                            vertical5,
                            Text(
                              "${userProv.userProfile.data?.email}",
                              style: txStyle12.copyWith(color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    Icon(
                      UniconsLine.bell,
                      size: 25,
                    )
                  ],
                ),
                vertical30,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (userProv.userProfile.data?.walletBalance == "0.00")
                          ? "₦0"
                          : convertStringToCurrency(
                              "${userProv.userProfile.data?.walletBalance}"),
                      style: txStyle27,
                    ),
                    Text(
                      "Balance",
                      style: txStyle14,
                    ),
                    vertical20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appOptions(
                          icon: Icons.wallet,
                          title: "Fund",
                          onpressed: () {
                            Get.to(FundWalletScreen());
                          },
                        ),
                        appOptions(
                          icon: Icons.history,
                          title: "History",
                          onpressed: () {},
                        ),
                        appOptions(
                          icon: Icons.qr_code_scanner,
                          title: "Scan",
                          onpressed: () {
                            Get.to(ScanQrCodeScreen());

                            // Get.to(ConfirmTransactionScreen());
                          },
                        ),
                        appOptions(
                          icon: Icons.qr_code_2,
                          title: "Pay",
                          onpressed: () {
                            Get.to(GenerateToPayScreen());

                            // Get.to(ConfirmTransactionScreen());
                          },
                        ),
                      ],
                    )
                  ],
                ),
                vertical20,
                Text(
                  "Todo",
                  style: txStyle14Bold,
                ),
                vertical10,
                todoWidget(
                    onpressed: () {
                      Get.to(CompleteProfileScreen());
                    },
                    title: "Complete Profile Setup",
                    subtitle:
                        "Complete profile setup by provide necessary information"),
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
                vertical10,
                userProv.qrCodeTransaction.data == null
                    ? Text("Loading")
                    : userProv.qrCodeTransaction.data!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              vertical30,
                              LottieBuilder.asset(
                                  "assets/lottie/51382-astronaut-light-theme.json"),
                              vertical20,
                              Center(
                                child: Text(
                                  "You are yet to perform a transaction. Transactions carried out with QR code will be displayed here.",
                                  textAlign: TextAlign.center,
                                  style: txStyle12.copyWith(color: Colors.grey),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                (userProv.qrCodeTransaction.data!.length < 5)
                                    ? userProv.qrCodeTransaction.data!.length
                                    : 5,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          TransactionDetailsSheet(
                                            transaction: userProv
                                                .qrCodeTransaction.data!
                                                .elementAt(index),
                                          ));
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: CustomNetworkImage(
                                          radius: 50,
                                          imageUrl: userProv
                                                      .qrCodeTransaction.data
                                                      ?.elementAt(index)
                                                      .status ==
                                                  "Pending"
                                              ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlHMlGaIm-FgKBskWObPrJh6jkx9vUXEreyw&usqp=CAU"
                                              : "${userProv.qrCodeTransaction.data?.elementAt(index).merchantBusinessLogo}"),
                                      title: Text(
                                        userProv.qrCodeTransaction.data
                                                    ?.elementAt(index)
                                                    .status ==
                                                "pending"
                                            ? "Qr code not used"
                                            : userProv.qrCodeTransaction.data
                                                        ?.elementAt(index)
                                                        .status ==
                                                    "expired"
                                                ? "Qr code expired"
                                                : "${userProv.qrCodeTransaction.data?.elementAt(index).merchantBusinessName}",
                                        style: txStyle14Bold,
                                      ),
                                      subtitle: Text(
                                        DateFormat.MMMMd().format(userProv
                                                .qrCodeTransaction.data
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
                                                "${userProv.qrCodeTransaction.data?.elementAt(index).amount}"),
                                            style: txStyle14,
                                          ),
                                          vertical5,
                                          Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(transactionStatus(
                                                    "${userProv.qrCodeTransaction.data?.elementAt(index).status}"))),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            })
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class TransactionDetailsSheet extends StatefulWidget {
  final Datum transaction;
  const TransactionDetailsSheet({super.key, required this.transaction});

  @override
  State<TransactionDetailsSheet> createState() =>
      _TransactionDetailsSheetState();
}

class _TransactionDetailsSheetState extends State<TransactionDetailsSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5), vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          bottomSheetDrag(),
          vertical30,
          Text(
            convertStringToCurrency("${widget.transaction.amount}"),
            style: txStyle25,
          ),
          vertical10,
          widget.transaction.status == "pending"
              ? Text(
                  "Qr code generated for this transaction has not been used",
                  textAlign: TextAlign.center,
                  style: txStyle12.copyWith(color: Colors.grey),
                )
              : widget.transaction.status == "expired"
                  ? Text(
                      "Qr code has expired and cannot be used",
                      style: txStyle12.copyWith(color: Colors.grey),
                    )
                  : Text(
                      "Transaction successful",
                      style: txStyle12.copyWith(color: Colors.grey),
                    ),
          vertical30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.transaction.merchantBusinessName}",
                style: txStyle14,
              ),
              Text(
                "Business Name",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Divider(),
          vertical20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(capitalizeFirstText("${widget.transaction.status}" ""),
                  style: txStyle14),
              Text(
                "Status",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Divider(),
          vertical20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.transaction.txRef}", style: txStyle14),
              Text(
                "Reference Number",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Divider(),
          vertical20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  DateFormat.yMMMMd()
                      .format(widget.transaction.dateCreated ?? DateTime.now()),
                  style: txStyle14),
              Text(
                "Date Created",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          vertical30,
          widget.transaction.status == "pending"
              ? CustomButton(
                  onTap: () {
                    Get.to(ViewQrCodeScreen(
                        tx_ref: "${widget.transaction.txRef}"));
                  },
                  label: "View QR code")
              : SizedBox.shrink(),
          vertical30
        ],
      ),
    );
  }
}

class todoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onpressed;
  final bool completed;
  const todoWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onpressed,
    this.completed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
            color: appPrimaryColor.withOpacity(0.1),
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
                    child: Text(subtitle,
                        overflow: TextOverflow.ellipsis,
                        style: txStyle12.copyWith(height: 1.5)),
                  )
                ],
              ),
              Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: appPrimaryColor)),
                  child: completed
                      ? Center(
                          child: Icon(
                            Icons.done,
                            color: appPrimaryColor,
                            size: 10,
                          ),
                        )
                      : SizedBox.shrink())
            ],
          ),
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
      splashColor: appPrimaryColor,
      child: Container(
        height: SizeConfig.heightOf(10),
        width: SizeConfig.widthOf(20),
        padding: EdgeInsets.all(SizeConfig.heightOf(2)),
        decoration: BoxDecoration(
            color: appPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
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
      splashColor: appPrimaryColor,
      child: Container(
        height: 100,
        width: 100,
        padding: EdgeInsets.all(SizeConfig.heightOf(2)),
        decoration: BoxDecoration(
            color: appPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 20,
              width: 20,
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

// 74a6fe0ddc453988b771b407b0f19d9b46e3fddf
