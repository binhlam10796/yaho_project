import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yaho/common/resources/resources.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.all(AppPadding.p24),
      title: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.pleaseWait.tr(),
                style: getTextMediumStyle(
                    color: ColorManager.contentColor, fontSize: FontSize.s16)),
            const SpinKitThreeBounce(
              size: AppSize.s20,
              color: ColorManager.darkBlueColor,
            ),
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          bottom: AppPadding.p16,
        ),
        child: Text(
          AppStrings.subPleaseWait.tr(),
          style: getTextRegularStyle(
              color: ColorManager.greyColor, fontSize: FontSize.s14),
        ),
      ),
    );
  }
}
