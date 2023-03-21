import 'package:flutter/material.dart';
import 'package:yaho/common/resources/colors_manager.dart';

/// Signature for EndOfPageListeners
typedef EndOfPageListener = void Function();

/// Signature for RefreshPageListeners
typedef RefreshPageListener = void Function();

/// A widget that wraps a [Widget] and will trigger [onLoadNextPage] when it
/// reaches the bottom of the list
class YahoLoadScrollView extends StatefulWidget {
  /// The [Widget] that this widget watches for changes on
  final Widget child;

  /// Called when the [child] reaches the end of the list
  final EndOfPageListener onLoadNextPage;

  /// Called when user pull down page
  final RefreshPageListener onRefreshPage;

  /// The offset to take into account when triggering [onLoadNextPage] in pixels
  final int scrollOffset;

  /// Prevented update nested listview with other axis direction
  final Axis scrollDirection;

  ///
  final bool isDepartmentLoad;

  @override
  State<StatefulWidget> createState() => YahoLoadScrollViewState();

  const YahoLoadScrollView({
    Key? key,
    required this.child,
    required this.onLoadNextPage,
    required this.onRefreshPage,
    this.scrollDirection = Axis.vertical,
    this.scrollOffset = 100,
    this.isDepartmentLoad = false,
  }) : super(key: key);
}

class YahoLoadScrollViewState extends State<YahoLoadScrollView> {
  @override
  void didUpdateWidget(YahoLoadScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: RefreshIndicator(
        child: _getScrollableView(),
        color: ColorManager.disabledColor,
        onRefresh: () async {
          widget.onRefreshPage();
        },
      ),
      onNotification: (notification) => _onNotification(notification, context),
    );
  }

  _getScrollableView() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.child,
        ],
      ),
    );
  }

  bool _onNotification(ScrollNotification notification, BuildContext context) {
    if (widget.scrollDirection == notification.metrics.axis) {
      if (notification is ScrollUpdateNotification) {
        if (!widget.isDepartmentLoad) {
          if (notification.metrics.maxScrollExtent >
                  notification.metrics.pixels &&
              notification.metrics.maxScrollExtent -
                      notification.metrics.pixels <=
                  widget.scrollOffset &&
              notification.metrics.pixels >= 0) {
            _loadMore();
          }
        } else {
          if (notification.metrics.extentAfter < 20 &&
              notification.metrics.axisDirection == AxisDirection.down &&
              notification.metrics.pixels >= 0) {
            _loadMore();
          }
        }
        return true;
      }

      if (notification is OverscrollNotification) {
        if (notification.overscroll > 0) {
          _loadMore();
        }
        return true;
      }
    }
    return false;
  }

  void _loadMore() {
    widget.onLoadNextPage();
  }
}
