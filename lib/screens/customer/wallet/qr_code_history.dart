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
import '../main/home_screen.dart';

class QrCodeHistory extends StatefulWidget {
  const QrCodeHistory({super.key});

  @override
  State<QrCodeHistory> createState() => _QrCodeHistoryState();
}

class _QrCodeHistoryState extends State<QrCodeHistory> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

    return userProv.qrCodeTransaction.data!.isEmpty
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
            itemCount: (userProv.qrCodeTransaction.data!.length < 5)
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
                      builder: (context) => TransactionDetails(
                            transaction: userProv.qrCodeTransaction.data!
                                .elementAt(index),
                          ));
                },
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: CustomNetworkImage(
                          radius: 50,
                          imageUrl: userProv.qrCodeTransaction.data
                                      ?.elementAt(index)
                                      .status ==
                                  "Pending"
                              ? "https://static-00.iconduck.com/assets.00/pending-icon-512x504-9zrlrc78.png"
                              : "${userProv.qrCodeTransaction.data?.elementAt(index).merchantBusinessLogo}"),
                      title: Text(
                        userProv.qrCodeTransaction.data
                                    ?.elementAt(index)
                                    .status ==
                                "Pending"
                            ? "Qr code not used"
                            : userProv.qrCodeTransaction.data
                                        ?.elementAt(index)
                                        .status ==
                                    "Expired"
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
            });
  }
}
