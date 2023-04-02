import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pay_app/screens/customer/analytics/analytics_screen.dart';
import 'package:pocket_pay_app/screens/customer/main/home_screen.dart';
import 'package:pocket_pay_app/screens/customer/profile/profile_screen.dart';
import 'package:pocket_pay_app/screens/customer/wallet/wallet_screen.dart';
import 'package:pocket_pay_app/screens/merchant/business/merchant_business_screen.dart';
import 'package:pocket_pay_app/screens/merchant/home/merchant_home_screen.dart';
import 'package:pocket_pay_app/screens/merchant/merchant_profile/merchant_profile_screen.dart';
import 'package:pocket_pay_app/screens/merchant/merchant_wallet/merchant_wallet_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/user_repository.dart';
import '../../../constant/export_constant.dart';

class MerchantBottomNav extends StatefulWidget {
  const MerchantBottomNav({Key? key}) : super(key: key);

  @override
  _MerchantBottomNavState createState() => _MerchantBottomNavState();
}

class _MerchantBottomNavState extends State<MerchantBottomNav> {
  @override
  void initState() {
    super.initState();
    final userProv = Provider.of<UserProvider>(context, listen: false);
    userProv.checkBiometric();
  }

  // bottom navigation bar
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MerchantHomeScreen(),
    MerchantWallet(),
    MerchantBusinessScreen(),
    MerchantProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: [
            _selectedIndex == 0
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/home_filled.png",
                      height: 20,
                      width: 20,
                      color: appPrimaryColor,
                    ),
                    label: "")
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/home.png",
                      height: 20,
                      width: 20,
                    ),
                    label: ""),
            _selectedIndex == 1
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/wallet_filled.png",
                      height: 20,
                      width: 20,
                      color: appPrimaryColor,
                    ),
                    label: "",
                  )
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/wallet.png",
                      height: 20,
                      width: 20,
                    ),
                    label: ""),
            _selectedIndex == 2
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/business.png",
                      height: 25,
                      width: 25,
                      color: appPrimaryColor,
                      fit: BoxFit.cover,
                    ),
                    label: "",
                  )
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/business.png",
                      height: 25,
                      width: 25,
                    ),
                    label: ""),
            _selectedIndex == 3
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/account_filled.png",
                      height: 25,
                      width: 25,
                      color: appPrimaryColor,
                    ),
                    label: "",
                  )
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/user.png",
                      height: 20,
                      width: 20,
                    ),
                    label: ""),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
