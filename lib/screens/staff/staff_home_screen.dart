import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/screens/authentication/merchant/staff_login_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/staff/generate_qr_code_screen.dart';
import 'package:pocket_pay_app/screens/staff/staff_scan_to_pay_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:provider/provider.dart';

import '../../api/repositories/user_repository.dart';
import '../../constant/export_constant.dart';
import '../../constant/size.dart';
import '../../utils/utils.dart';
import '../../widgets/bottomSheetDrag.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_imaga.dart';
import '../authentication/merchant/staff_qr_transaction_history_model.dart';
import '../customer/main/view_qrcode_screen.dart';
import '../merchant/business/business_home_screen.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
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
              onRefresh: () async {
                final userProv =
                    Provider.of<MerchantProvider>(context, listen: false);
                await userProv.fetchStaffQrCodeHistory();
                await userProv.fetchStaffProfile();
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
                                  "${userProv.staffProfileModel.data?.profilePicture}",
                              radius: 45),
                          horizontalx5,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalizeFirstText(
                                    "${userProv.staffProfileModel.data?.firstName}"
                                    " ${userProv.staffProfileModel.data?.lastName}"),
                                style: txStyle14Bold,
                              ),
                              vertical5,
                              Text(
                                "${userProv.staffProfileModel.data?.email}",
                                style: txStyle12.copyWith(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Get.offAll(StaffLoginScreen());
                          },
                          icon: Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  vertical20,
                  Text(
                    "Quick Actions",
                    style: txStyle14,
                  ),
                  vertical10,
                  businessAction(
                    icon: Icons.qr_code_scanner,
                    title: "Scan",
                    onTap: () {
                      Get.to(StaffScanQrCodeScreen());
                    },
                  ),
                  vertical10,
                  businessAction(
                    icon: Icons.qr_code_2,
                    title: "Pay",
                    onTap: () {
                      Get.to(StaffGenerateQrCodeScreen());

                      // Get.to(ScanQrCodeScreen());

                      // Get.to(ConfirmTransactionScreen());
                    },
                  ),
                  vertical10,
                  businessAction(
                    icon: Icons.history,
                    title: "History",
                    onTap: () {},
                  ),
                  vertical30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions",
                        style: txStyle14,
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.sort))
                    ],
                  ),
                  Center(
                    child: Text(
                      "NB: Unused QR code gets deleted automatically after 3 minutes",
                      style: txStyle12.copyWith(color: Colors.grey),
                    ),
                  ),
                  vertical10,
                  userProv.staffQrCodeTransactionModel.data == null
                      ? const SizedBox.shrink()
                      : ResponsiveState(
                          state: userProv.state,
                          busyWidget: Center(
                            child: CircularProgressIndicator(
                                color: appPrimaryColor),
                          ),
                          idleWidget: userProv
                                  .staffQrCodeTransactionModel.data!.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    vertical30,
                                    LottieBuilder.asset(
                                        "assets/lottie/51382-astronaut-light-theme.json"),
                                    vertical20,
                                    Center(
                                      child: Text(
                                        "You are yet to perform any transaction. Transactions carried out with QR code will be displayed here.",
                                        textAlign: TextAlign.center,
                                        style: txStyle12.copyWith(
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: userProv
                                      .staffQrCodeTransactionModel.data!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var transaction = userProv
                                        .staffQrCodeTransactionModel
                                        .data
                                        ?.reversed
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
                                                  topRight:
                                                      Radius.circular(10)),
                                            ),
                                            context: context,
                                            builder: (context) =>
                                                TransactionDetailsSheet(
                                                  transaction: transaction!,
                                                ));
                                      },
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            leading: CustomNetworkImage(
                                                radius: 50,
                                                imageUrl: transaction?.status ==
                                                        "pending"
                                                    ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlHMlGaIm-FgKBskWObPrJh6jkx9vUXEreyw&usqp=CAU"
                                                    : "${transaction?.merchantBusinessLogo}"),
                                            title: Text(
                                              transaction?.status == "pending"
                                                  ? "Qr code not used"
                                                  : transaction?.status ==
                                                          "expired"
                                                      ? "Qr code expired"
                                                      : "${transaction?.customerName}",
                                              style: txStyle14Bold,
                                            ),
                                            subtitle: Text(
                                              DateFormat.yMd().add_jm().format(
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
                                                      color: Color(
                                                          transactionStatus(
                                                              "${transaction?.status}"))),
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
        ),
      ),
    );
  }
}

class TransactionDetailsSheet extends StatefulWidget {
  final StaffTransactionDetail transaction;
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
                "${widget.transaction.customerName}",
                style: txStyle14,
              ),
              Text(
                "Customer Id",
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
