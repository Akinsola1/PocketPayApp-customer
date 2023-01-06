import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/screens/scan_to_pay/pin_screen.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';

class ConfirmTransactionScreen extends StatelessWidget {
  
  const ConfirmTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final TextEditingController descriptionController= TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Confirm Transaction",
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthOf(4)),
          child: Column(
            children: [
             const  CustomNetworkImage(
                  radius: 60,
                  imageUrl:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMjHCjAx96ezsVKdwBY3W7Qkwbs1S7pIKyOA&usqp=CAU"),
              vertical10,
              Text(
                "Business Name",
                style: txStyle14Bold,
              ),
              Text(
                "Businessemail@gmail.com",
                style: txStyle12,
              ),
              vertical50,
              Text(
                "You are paying",
                style: txStyle12,
              ),
              Text(
                "₦ 2,000",
                style: txStyle27Bold.copyWith(color: kPrimaryColor),
              ),
              vertical20,
              CustomTextField(
                labelText: "Description",
                hintText: "e.g Car maintenance",
                controller: descriptionController,
              ),
              vertical20,
              CustomButton(onTap: () {
                Get.to(PinScreen(amount: "amount", description: descriptionController.text));
              }, label: "Proceed")
            ],
          ),
        ),
      ),
    );
  }
}
