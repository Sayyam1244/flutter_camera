import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';
import 'package:flutter_camera/Src/Presentation/Common/app_text.dart';

// ignore: must_be_immutable
class CustomSmallButton extends StatelessWidget {
  CustomSmallButton({
    super.key,
    required this.btnColor,
    required this.textColor,
    required this.text,
    required this.ontap,
    this.width,
    this.height = 47,
    this.borderRadius,
    this.isloading = false,
  });
  final Color btnColor;
  final Color textColor;
  final String text;
  final VoidCallback ontap;
  double? width;
  double height;
  BorderRadiusGeometry? borderRadius;
  bool isloading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      child: MaterialButton(
        onPressed: ontap,
        child: isloading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              )
            : Center(
                child: Apptext(
                  text: text,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
      ),
    );
  }
}
