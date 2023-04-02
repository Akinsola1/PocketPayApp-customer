import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/merchant/merchant_wallet/merchant_qr_code_history.dart';
import 'package:pocket_pay_app/screens/merchant/merchant_wallet/merchant_wallet_history.dart';
import 'package:pocket_pay_app/screens/merchant/merchant_wallet/merchant_withdraw_funds_screen.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/merchant_repository.dart';
import '../../../utils/sizeconfig.dart';
import '../../../utils/utils.dart';

class MerchantWallet extends StatefulWidget {
  const MerchantWallet({super.key});

  @override
  State<MerchantWallet> createState() => _MerchantWalletState();
}

class _MerchantWalletState extends State<MerchantWallet> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(5)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Wallet",
              style: txStyle25Bold.copyWith(color: appPrimaryColor),
            ),
            vertical30,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appPrimaryColor, appPrimaryColor.withOpacity(0.7)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightOf(4),
                    horizontal: SizeConfig.widthOf(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (userProv.merchantProfileModel.data?.walletBalance ==
                                  "0.00")
                              ? "₦0"
                              : convertStringToCurrency(
                                  "${userProv.merchantProfileModel.data?.walletBalance}"),
                          style: txStyle27wt,
                        ),
                        Text(
                          "Balance",
                          style: txStyle14wt,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(MerchantWithdrawFundsScreen());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Center(child: Text("Withdraw")),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            vertical20,
            DefaultTabController(
                length: 2,
                child: Builder(builder: (BuildContext context) {
                  final TabController? tabController =
                      DefaultTabController.of(context);
                  tabController?.addListener(
                    () {
                      if (!tabController.indexIsChanging) {}
                    },
                  );
                  return Expanded(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: SizeConfig.heightOf(6),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TabBar(
                                  enableFeedback: true,
                                  indicator: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  labelColor: Colors.black,
                                  unselectedLabelColor:
                                      Colors.black.withOpacity(0.5),
                                  tabs: const [
                                    Tab(
                                      text: 'Wallet',
                                    ),
                                    Tab(
                                      text: 'Qr code',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            vertical20,
                            Flexible(
                                child: TabBarView(
                              children: [
                                MerchantWalletHistory(),
                                MerchantQrCodeHistory()
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                }))
          ]),
        ),
      ),
    );
  }
}
