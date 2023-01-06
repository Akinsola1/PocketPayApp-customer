import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocket_pay_app/api/repositories/auth_reository.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/main/home_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

import '../../main/bottom_nav_bar.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authRepository authRep = Get.put(authRepository());
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
        child: ListView(
          children: [
            Text(
              "Create Password",
              style: txStyle27Bold.copyWith(color: kPrimaryColor),
            ),
            Text(
              "Create a secure password to access your account",
              style: txStyle14,
            ),
            vertical20,
            CustomTextField(
              labelText: "Password",
              hintText: "********",
              controller: _password,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => authRep.validatePassword(value!),
              obscureText: true,
            ),
            vertical10,
            CustomTextField(
              labelText: "Confirm Password",
              hintText: "********",
              controller: _confirmPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => authRep.confirmPassword(value!),
              obscureText: true,
            ),
            vertical20,
            CustomButton(onTap: () {
              Get.to(BottomNav());
            }, label: "Finish")
          ],
        ),
      ),
    );
  }
}
