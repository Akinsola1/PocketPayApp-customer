import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pay_app/screens/analysis/analysis_screen.dart';
import 'package:pocket_pay_app/screens/main/home_screen.dart';
import 'package:pocket_pay_app/screens/profile/profile_screen.dart';
import 'package:pocket_pay_app/screens/wallet/wallet_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';

import '../../constant/export_constant.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // bottom navigation bar
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WalletScreen(),
    AnalysisScreen(),
    ProfileScreen(),

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
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
                      color: kPrimaryColor,
                    ),
                    label: "")
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/home.png",
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
                    ),
                    label: ""),
            _selectedIndex == 1
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/wallet_filled.png",
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
                      color: kPrimaryColor,
                    ),
                    label: "",
                  )
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/wallet.png",
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
                    ),
                    label: ""),
            _selectedIndex == 2
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/analytics_filled.png",
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
                      color: kPrimaryColor,
                      fit: BoxFit.cover,
                    ),
                    label: "",
                  )
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/analysis.png",
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
                    ),
                    label: ""),
            _selectedIndex == 3
                ? BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/account_filled.png",
                      height: SizeConfig.heightOf(2.5),
                      width: SizeConfig.heightOf(2.5),
                      color: kPrimaryColor,
                    ),
                    label: "",
                  )
                : BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/images/user.png",
                      height: SizeConfig.heightOf(2),
                      width: SizeConfig.heightOf(2),
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
