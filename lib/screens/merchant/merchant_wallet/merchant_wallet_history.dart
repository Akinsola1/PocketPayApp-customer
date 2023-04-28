import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/api/models/customer/flw_transaction_model.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/export_constant.dart';
import '../../../widgets/bottomSheetDrag.dart';
import '../../../widgets/custom_imaga.dart';

class MerchantWalletHistory extends StatefulWidget {
  const MerchantWalletHistory({super.key});

  @override
  State<MerchantWalletHistory> createState() => _MerchantWalletHistoryState();
}

class _MerchantWalletHistoryState extends State<MerchantWalletHistory> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await userProv.fetchMerchantQrCodeTransaction();
        await userProv.fetchMerchantFlwTransactions();
        await userProv.fetchMerchantBank();
        await userProv.fetchMerchantProfile();
      },
      child: userProv.flwTransactionModel.data == null
          ? SizedBox.shrink()
          : userProv.flwTransactionModel.data!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                          "assets/lottie/51382-astronaut-light-theme.json"),
                      vertical20,
                      Text("You are yet to perform a transaction",
                          style: txStyle14),
                      vertical5,
                      Text(
                          "Transactions like withdrawals will be displayed here",
                          style: txStyle12.copyWith(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: userProv.flwTransactionModel.data!.length,
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
                            builder: (context) => FlwTransactionDetails(
                                  transaction: userProv
                                      .flwTransactionModel.data!
                                      .elementAt(index),
                                ));
                      },
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: appPrimaryColor)),
                              child: Center(
                                child: Icon(
                                  Icons.trending_up_sharp,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            title: Text(
                              "Withdrawal",
                              style: txStyle14Bold,
                            ),
                            subtitle: Text(
                              DateFormat.MMMMd().format(userProv
                                      .flwTransactionModel.data
                                      ?.elementAt(index)
                                      .dateCreated ??
                                  DateTime.now()),
                              style: txStyle12,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  convertStringToCurrency(
                                      "${userProv.flwTransactionModel.data?.elementAt(index).amount}"),
                                  style: txStyle14,
                                ),
                                vertical5,
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(transactionStatus(
                                          "${userProv.flwTransactionModel.data?.elementAt(index).status?.toLowerCase()}"))),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  }),
    );
  }
}

class FlwTransactionDetails extends StatelessWidget {
  final Datum transaction;
  const FlwTransactionDetails({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          bottomSheetDrag(),
          vertical30,
          Text(
            convertStringToCurrency("${transaction.amount}"),
            style: txStyle25,
          ),
          vertical30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.widthOf(60),
                child: Text(
                  "${transaction.bankName}",
                  overflow: TextOverflow.ellipsis,
                  style: txStyle14,
                ),
              ),
              Text(
                "Bank Name",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Divider(),
          vertical20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.widthOf(60),
                child: Text(
                  transaction.status == "pending"
                      ? "------"
                      : "${transaction.bankOwner}",
                  overflow: TextOverflow.ellipsis,
                  style: txStyle14,
                ),
              ),
              Text(
                "Account owner",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Divider(),
          vertical20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(capitalizeFirstText("${transaction.status}"),
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
              Text("${transaction.txRef}", style: txStyle14),
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
              SizedBox(
                width: SizeConfig.widthOf(60),
                child: Text(
                    DateFormat.yMd()
                        .add_jm()
                        .format(transaction.dateCreated ?? DateTime.now()),
                    overflow: TextOverflow.ellipsis,
                    style: txStyle14),
              ),
              Text(
                "Date Created",
                style: txStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          vertical50
        ],
      ),
    );
  }
}
