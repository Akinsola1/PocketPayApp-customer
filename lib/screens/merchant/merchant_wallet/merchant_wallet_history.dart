import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/api/repositories/merchant_repository.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/export_constant.dart';
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
      },
      child: userProv.flwTransactionModel.data!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                      "assets/lottie/51382-astronaut-light-theme.json"),
                  vertical20,
                  Text("You are yet to perform any transaction",
                      style: txStyle14),
                  vertical5,
                  Text("Transactions like withdrawals will be displayed here",
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
                    //           transaction:
                    //               userProv.qrCodeTransaction.data!.elementAt(index),
                    //         ));
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
                                  color: Color(0xff00C853)),
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