import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/merchant/business/business_home_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/merchant_complete_profile_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:provider/provider.dart';

import '../../../api/models/merchant/merchant_qr_code_histoty_model.dart';
import '../../../api/repositories/merchant_repository.dart';
import '../../../widgets/bottomSheetDrag.dart';
import '../../../widgets/custom_button.dart';
import '../../customer/main/home_screen.dart';
import '../../customer/main/view_qrcode_screen.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({super.key});

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: ResponsiveState(
          state: userProv.state,
          busyWidget: SpinKitFadingCircle(color: Colors.black),
          idleWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
            child: RefreshIndicator(
              color: appPrimaryColor,
              onRefresh: () async {
                userProv.fetchMerchantProfile();
                userProv.fetchMerchantBusiness();
                userProv.fetchMerchantQrCodeTransaction();
                userProv.fetchMerchantFlwTransactions();
              },
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl:
                            "${userProv.merchantProfileModel.data?.profilePicture}",
                        radius: 50,
                      ),
                      horizontalx10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello ${capitalizeFirstText(userProv.merchantProfileModel.data!.firstName!)} 👋",
                            style: txStyle14,
                          ),
                          vertical5,
                          Text(
                            "${userProv.merchantProfileModel.data?.email}",
                            style: txStyle12.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  vertical20,
                  Text(
                    "Todo",
                    style: txStyle14Bold,
                  ),
                  vertical10,
                  todoWidget(
                      completed: userProv.merchantProfileModel.data!.addBank! &&
                          userProv.merchantProfileModel.data!.kycVerified! &&
                          userProv
                              .merchantProfileModel.data!.contactPersonAdded!,
                      onpressed: () {
                        Get.to(MerchantCompleteProfileScreen());
                      },
                      title: "Complete Profile Setup",
                      subtitle:
                          "Complete profile setup by provide necessary information"),
                  vertical10,
                  Divider(),
                  vertical20,
                  Text(
                    "Select business account to perform transaction",
                    style: txStyle14Bold,
                  ),
                  vertical20,
                  SizedBox(
                    height: 150,
                    width: SizeConfig.screenWidth,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
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
                  ),
                  Divider(),
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
                  userProv.merchantQrcodeHistory.data!.isEmpty
                      ? Column(
                          children: [
                            vertical30,
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
                              (userProv.merchantQrcodeHistory.data!.length < 5)
                                  ? userProv.merchantQrcodeHistory.data!.length
                                  : 5,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var transaction = userProv
                                .merchantQrcodeHistory.data?.reversed
                                .elementAt(index);
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
                                    builder: (context) => TransactionDetails(
                                          transaction: transaction!,
                                        ));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: CustomNetworkImage(
                                        radius: 50,
                                        imageUrl: transaction?.status ==
                                                "pending"
                                            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlHMlGaIm-FgKBskWObPrJh6jkx9vUXEreyw&usqp=CAU"
                                            : "${transaction?.merchantBusinessLogo}"),
                                    title: Text(
                                      transaction?.status == "pending"
                                          ? "Qr code not used"
                                          : transaction?.status == "expired"
                                              ? "Qr code expired"
                                              : "${transaction?.merchantBusinessName}",
                                      style: txStyle14Bold,
                                    ),
                                    subtitle: Text(
                                      DateFormat.MMMMd().format(
                                          transaction?.dateCreated ??
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
                                              "${transaction?.amount}"),
                                          style: txStyle14,
                                        ),
                                        vertical5,
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(transactionStatus(
                                                  "${transaction?.status}"))),
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
      ),
    );
  }
}

class TransactionDetails extends StatefulWidget {
  final Datum transaction;
  const TransactionDetails({super.key, required this.transaction});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
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
              Text(
                widget.transaction.status == "pending"
                    ? "------"
                    : "${widget.transaction.customerName}",
                style: txStyle14,
              ),
              Text(
                "Customer Name",
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
