import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/main/home_screen.dart';
import 'package:pocket_pay_app/screens/onboarding/signup/signup_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

import '../../../api/repositories/auth_reository.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  final loginKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authRepository authRep = Get.put(authRepository());
    return Scaffold(
      body: Form(
        key: loginKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
            child: ListView(
              children: [
                vertical120,
                Text(
                  "Login.",
                  style: txStyle27Bold.copyWith(color: kPrimaryColor),
                ),
                vertical20,
                CustomTextField(
                  labelText: "Phone number",
                  hintText: "+234*********",
                  controller: _phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => authRep.validatePhoneNumber(value!),
                ),
                vertical10,
                CustomTextField(
                  labelText: "Password",
                  hintText: "********",
                  controller: _passwordcontroller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => authRep.validatePassword(value!),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: txStyle12.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightOf(4),
                ),
                Obx(
                  () => CustomButton(
                      loading: authRep.loading.value,
                      onTap: () async {
                        if (!loginKey.currentState!.validate()) return;
                        bool response = await authRep.login(
                            phone: _phoneController.text.trim(),
                            password: _passwordcontroller.text.trim());
                        if (response) {
                          Get.to(() => HomeScreen());
                        }
                      },
                      label: "LOG IN"),
                ),
                vertical10,
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(SignupScreen());
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'New to Pocket Pay? ',
                        style: txStyle14,
                        children: <TextSpan>[
                          TextSpan(text: 'Join us', style: txStyle14Bold.copyWith(color: kPrimaryColor))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
