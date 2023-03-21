import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/common/widgets/yaho_button.dart';
import 'package:yaho/di/di.dart';
import 'package:yaho/presentation/welcome/model/slider_model.dart';
import 'package:yaho/presentation/welcome/viewmodel/welcome_viewmodel.dart';
import 'package:yaho/presentation/welcome/widget/custom_slider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final WelcomeViewModel _viewModel = instance<WelcomeViewModel>();

  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Column(
            children: [
              const SizedBox(height: kToolbarHeight * 1.3),
              SvgPicture.asset(ImageAssets.splashLogo),
              const SizedBox(height: AppSize.s30),
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    // contents of slider
                    return CustomSlider(
                      image: slides[index].image ?? '',
                      title: slides[index].title ?? '',
                      content: slides[index].content ?? '',
                    );
                  },
                  controller: _pageController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  slides.length,
                  (index) => buildDot(index, context),
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p32),
                child: YahoButton(
                  title: currentIndex == slides.length - 1
                      ? AppStrings.login.tr()
                      : AppStrings.strContinue.tr(),
                  func: () {
                    if (currentIndex == slides.length - 1) {
                      _viewModel.goToLoginScreen();
                    }
                    _pageController.nextPage(
                      duration:
                          const Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s16),
              InkWell(
                onTap: () {
                  _viewModel.goToLoginScreen();
                },
                child: Text(
                  AppStrings.skip.tr(),
                  style: getTextMediumStyle(
                    color: ColorManager.contentColor,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
              const SizedBox(height: AppPadding.p32),
            ],
          ),
    );
  }

  // container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index
            ? ColorManager.darkBlueColor
            : ColorManager.brightBlueColor.withOpacity(0.3),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }
}