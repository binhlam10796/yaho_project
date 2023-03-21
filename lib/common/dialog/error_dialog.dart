import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaho/common/listener/listener.dart';
import 'package:yaho/common/resources/resources.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final SingleTapListener singleTapListener;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.singleTapListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(AppPadding.p24),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s20))),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSize.s16, width: AppSize.sMax),
            Image.asset(ImageAssets.imgError),
            const SizedBox(height: AppSize.s16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: getTextMediumStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.contentColor,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: getTextRegularStyle(
                  fontSize: FontSize.s15,
                  color: ColorManager.greyColor,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Container(
              height: AppSize.s1,
              color: ColorManager.contentColor.withOpacity(0.1),
            ),
            const SizedBox(height: AppSize.s16),
            InkWell(
              onTap: () {
                singleTapListener(true);
              },
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  AppStrings.close.tr(),
                  textAlign: TextAlign.center,
                  style: getTextMediumStyle(
                    fontSize: FontSize.s15,
                    color: ColorManager.darkBlueColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
          ],
        ),
      ),
    );
  }
}
