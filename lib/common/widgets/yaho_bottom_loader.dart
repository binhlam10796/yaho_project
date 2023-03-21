import 'package:flutter/material.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:lottie/lottie.dart';

class YahoBottomLoader extends StatelessWidget {
  const YahoBottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Center(
        child: SizedBox(
          width: AppSize.s28,
          height: AppSize.s28,
          child: Lottie.asset(JsonAssets.bottomLoading),
        ),
      ),
    );
  }
}
