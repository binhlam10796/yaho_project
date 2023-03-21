import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/common/widgets/yaho_bottom_loader.dart';
import 'package:yaho/di/di.dart';
import 'package:yaho/presentation/splash/viewmodel/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final SplashViewModel _viewModel = instance<SplashViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContentWidget(),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _viewModel.start();
  }

  Widget _getContentWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  const YahoBottomLoader(),
                  Expanded(child: Container()),
                  Center(
                    child: Image.asset(
                      ImageAssets.splashLogo,
                      height: MediaQuery.of(context).size.height / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(child: Container()),
                  const SizedBox(height: AppSize.s12),
                  Text(AppStrings.productDevelopedBy.tr(),
                      style: const TextStyle(
                          color: ColorManager.greyColor,
                          fontSize: FontSize.s16)),
                  const SizedBox(height: AppSize.s4),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'PLUS ',
                        style: TextStyle(
                            color: ColorManager.darkBlueColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'TEAM',
                        style: TextStyle(
                            color: ColorManager.brightBlueColor,
                            fontWeight: FontWeight.bold))
                  ])),
                  const SizedBox(height: AppSize.s8),
                  StreamBuilder<String>(
                      stream: _viewModel.outputVersionName,
                      builder: (context, snapshot) {
                        String version = snapshot.data ?? '1.0.0';
                        return Text(
                          version,
                          style: getTextRegularStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.greyColor,
                          ),
                        );
                      }),
                  const SizedBox(height: AppPadding.p32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
