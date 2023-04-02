import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/export_constant.dart';
import '../../../widgets/custom_imaga.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({super.key});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

    return userProv.flwTransactionModel.data!.isEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/51382-astronaut-light-theme.json"),
              vertical20,
              Text("You are yet to perform any transaction", style: txStyle14),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: (userProv.flwTransactionModel.data!.length < 5)
                ? userProv.flwTransactionModel.data!.length
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
                            Icons.trending_down_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      title: Text(
                        "Wallet funding",
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
            });
  }
}
