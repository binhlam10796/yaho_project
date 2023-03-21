import 'package:flutter/material.dart';
import 'package:yaho/common/resources/colors_manager.dart';
import 'package:yaho/common/resources/fonts_manager.dart';
import 'package:yaho/common/resources/styles_manager.dart';
import 'package:yaho/common/resources/values_manager.dart';

enum YahoButtonTheme {
  orangeTheme,
  whiteTheme,
}

class YahoButton extends StatefulWidget {
  final String title;
  final Function()? func;
  final YahoButtonTheme? theme;

  const YahoButton({
    Key? key,
    this.func,
    required this.title,
    this.theme = YahoButtonTheme.orangeTheme,
  }) : super(key: key);

  @override
  State<YahoButton> createState() => _YahoButtonState();
}

class _YahoButtonState extends State<YahoButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: DurationConstant.d100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (widget.func != null) {
          _controller.forward();
        }
      },
      onPointerUp: (PointerUpEvent event) {
        if (widget.func != null) {
          _controller.reverse();
          widget.func!();
        }
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s24),
              border: Border.all(
                color: widget.theme == YahoButtonTheme.whiteTheme
                    ? ColorManager.lineColor
                    : Colors.transparent,
              ),
              color: widget.theme == YahoButtonTheme.orangeTheme
                  ? widget.func != null
                      ? ColorManager.darkBlueColor
                      : ColorManager.disabledColor
                  : ColorManager.whiteColor),
          child: SizedBox(
            height: AppSize.s48,
            child: Center(
              child: Text(
                widget.title,
                style: getTextMediumStyle(
                  color: widget.theme == YahoButtonTheme.orangeTheme
                      ? ColorManager.whiteColor
                      : ColorManager.contentColor,
                  fontSize: FontSize.s16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
