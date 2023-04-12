import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/customer/profile/profile_screen.dart';
import 'package:pocket_pay_app/screens/customer/wallet/qr_code_history.dart';
import 'package:pocket_pay_app/screens/customer/wallet/wallet_history.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../utils/utils.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallet",
                style: txStyle27Bold.copyWith(color: appPrimaryColor),
              ),
              vertical20,
              Container(
                decoration: BoxDecoration(
                    color: appPrimaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.heightOf(4),
                      horizontal: SizeConfig.widthOf(3)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          (userProv.userProfile.data?.walletBalance == "0.00")
                              ? "₦0"
                              : convertStringToCurrency(
                                  "${userProv.userProfile.data?.walletBalance}"),
                          style: txStyle27wt,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Balance",
                          style: txStyle14wt,
                        ),
                      ),
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
                                        text: 'Qr Code',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              vertical20,
                              const Flexible(
                                  child: TabBarView(
                                children: [WalletHistory(), QrCodeHistory()],
                              ))
                            ],
                          ),
                        ),
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
