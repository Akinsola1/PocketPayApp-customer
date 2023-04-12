import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_pay_app/api/models/merchant/merchant_business_model.dart';
import 'package:pocket_pay_app/api/responsiveState/responsive_state.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';
import 'package:pocket_pay_app/utils/sizeconfig.dart';
import 'package:pocket_pay_app/utils/utils.dart';
import 'package:pocket_pay_app/widgets/custom_imaga.dart';
import 'package:pocket_pay_app/widgets/export_widget.dart';
import 'package:provider/provider.dart';

import '../../../api/repositories/merchant_repository.dart';
import 'add_staff_screen.dart';

class BusinessStaffScreen extends StatefulWidget {
  final Datum data;

  const BusinessStaffScreen({super.key, required this.data});

  @override
  State<BusinessStaffScreen> createState() => _BusinessStaffScreenState();
}

class _BusinessStaffScreenState extends State<BusinessStaffScreen> {
  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<MerchantProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "${widget.data.businessName}",
      ),
      body: ResponsiveState(
        state: userProv.state,
        busyWidget: SpinKitFadingCircle(color: Colors.black),
        idleWidget: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthOf(5), vertical: 10),
          child: Column(
            children: [
              CustomNetworkImage(
                imageUrl: "${widget.data.businessLogo}",
                radius: 120,
              ),
              vertical30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Staffs",
                    style: txStyle14Bold,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(AddStaffScreen(
                          businessId: "${widget.data.businessId}",
                        ));
                      },
                      icon: Icon(
                        Icons.add,
                        color: appPrimaryColor,
                      ))
                ],
              ),
              vertical20,
              userProv.businessStaffModel.data!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                            "assets/lottie/51382-astronaut-light-theme.json"),
                        vertical20,
                        Text("You are yet to add a staff to this business",
                            style: txStyle14),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: userProv.businessStaffModel.data?.length,
                      itemBuilder: (context, index) {
                        var staff =
                            userProv.businessStaffModel.data?.elementAt(index);
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CustomNetworkImage(
                                  radius: 50,
                                  imageUrl: "${staff?.profilePicture}"),
                              title: Text(
                                capitalizeFirstText(
                                    "${staff?.firstName} ${staff?.lastName}"),
                                style: txStyle14,
                              ),
                              subtitle: Text(
                                "${staff?.staffId}",
                                style: txStyle12.copyWith(color: Colors.grey),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(
                                    "Suspend",
                                    style:
                                        txStyle13.copyWith(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
