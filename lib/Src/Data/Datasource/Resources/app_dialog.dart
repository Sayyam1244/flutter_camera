import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';
import 'package:flutter_camera/Src/Presentation/Common/app_text.dart';
import 'package:flutter_camera/Src/Presentation/Common/custom_small_button.dart';

class AppDialog {
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: AppColors.redColor,
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> errorDialog(
      BuildContext context, String errorMessage, void Function() ontapClose) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const Apptext(
            text: "Error",
            style: TextStyle(
              color: AppColors.redColor,
              fontSize: 18,
            ),
          ),
          content: Apptext(
            maxLine: 5,
            text: errorMessage,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          actions: [
            CustomSmallButton(
                borderRadius: BorderRadius.circular(4),
                btnColor: AppColors.redColor,
                textColor: AppColors.whiteColor,
                text: 'Close',
                ontap: ontapClose)
          ],
        );
      },
    );
  }

  static Future<dynamic> generalDialog(BuildContext context, String title,
      String message, void Function() ontapClose) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Apptext(
            text: title,
            style: const TextStyle(
              color: AppColors.greenColor,
              fontSize: 18,
            ),
          ),
          content: Apptext(
            text: message,
            maxLine: 3,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          actions: [
            CustomSmallButton(
                borderRadius: BorderRadius.circular(4),
                btnColor: AppColors.greenColor,
                textColor: AppColors.whiteColor,
                text: 'Close',
                ontap: ontapClose)
          ],
        );
      },
    );
  }
}
