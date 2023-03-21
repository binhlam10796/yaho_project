import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaho/common/resources/resources.dart';

class CustomSlider extends StatelessWidget {
  final String image;
  final String title;
  final String content;

  const CustomSlider({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height / 3,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
            matchTextDirection: true
          ),
          const SizedBox(height: AppSize.s16),
          SizedBox(
            height: AppSize.s55,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: getTextBoldStyle(
                fontSize: FontSize.s22,
                color: ColorManager.contentColor,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s16),
          Text(
            content,
            textAlign: TextAlign.center,
            style: getTextMediumStyle(
              fontSize: FontSize.s16,
              color: ColorManager.contentColor,
            ),
          ),
          const SizedBox(height: AppSize.s16),
        ],
      ),
    );
  }
}
