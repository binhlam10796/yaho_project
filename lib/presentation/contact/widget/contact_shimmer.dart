import 'package:flutter/material.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:shimmer/shimmer.dart';

class ContactShimmer extends StatelessWidget {
  const ContactShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: 7,
      itemBuilder: (context, index) {
        return _shimmerItem();
      },
    );
  }

  Widget _shimmerItem() {
    return Shimmer.fromColors(
      baseColor: ColorManager.greyColor.withOpacity(0.2),
      highlightColor: ColorManager.greyColor.withOpacity(0.1),
      child: Container(
        height: AppSize.s110,
        padding: const EdgeInsets.only(
          right: AppPadding.p16,
          top: AppPadding.p12,
          bottom: AppPadding.p12,
        ),
        margin: const EdgeInsets.only(
          left: AppMargin.m16,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: AppSize.s1,
              color: ColorManager.greyColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p12),
              child: Container(
                height: AppSize.s18,
                width: AppSize.s18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  color: ColorManager.greyColor,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: AppSize.s24,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: ColorManager.greyColor,
                    ),
                  ),
                  Container(
                    height: AppSize.s24,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: ColorManager.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSize.s8),
            SizedBox(
              width: AppSize.s70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: AppSize.s24,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: ColorManager.greyColor,
                    ),
                  ),
                  Container(
                    height: AppSize.s24,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      color: ColorManager.greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
