import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pay_app/constant/export_constant.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.radius = 60,
  }) : super(key: key);

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                Border.all(width: 2, color: kPrimaryColor)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius - 10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container(
              height: radius,
              width: radius,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/face.png'), fit: BoxFit.cover)),
            ),
          ),
        ));
  }
}

class CustomPNG extends StatelessWidget {
  final String imagePath;
  final double size;
  const CustomPNG({super.key, required this.imagePath, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Image.asset(
        imagePath,
        height: size,
        width: size,
      ),
    );
  }
}
