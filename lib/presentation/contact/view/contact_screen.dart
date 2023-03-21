import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaho/common/resources/colors_manager.dart';
import 'package:yaho/common/resources/strings_manager.dart';
import 'package:yaho/common/resources/values_manager.dart';
import 'package:yaho/common/widgets/yaho_bottom_loader.dart';
import 'package:yaho/common/widgets/yaho_load_scrollview.dart';
import 'package:yaho/core/models/mapper/contact.dart';
import 'package:yaho/di/di.dart';
import 'package:yaho/presentation/contact/viewmodel/contact_viewmodel.dart';
import 'package:yaho/presentation/contact/widget/contact_item_grid.dart';
import 'package:yaho/presentation/contact/widget/contact_item_list.dart';
import 'package:yaho/presentation/contact/widget/contact_shimmer.dart';

class ContactScreen extends StatefulWidget {
  @override
  ContactScreenState createState() => ContactScreenState();
}

class ContactScreenState extends State<ContactScreen> {
  final ContactViewModel _viewModel = instance<ContactViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final icon = _isGridView ? Icons.list_alt_sharp : Icons.grid_on_sharp;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  ColorManager.brightBlueColor,
                  ColorManager.darkBlueColor
                ]),
          ),
        ),
        title: Text(AppStrings.contact.tr()),
      ),
      body: StreamBuilder<bool>(
        stream: _viewModel.outputShimmerState,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == false) {
            return _getContentWidget();
          }
          return const ContactShimmer();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isGridView = !_isGridView;
          });
        },
        child: Container(
          width: AppSize.s60,
          height: AppSize.s60,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                ColorManager.darkBlueColor,
                ColorManager.brightBlueColor
              ])),
          child: Icon(
            icon,
            size: AppSize.s36,
          ),
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<List<Contact>>(
      stream: _viewModel.outputContact,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var contact = snapshot.data ?? [];
          return YahoLoadScrollView(
            isDepartmentLoad: true,
            child: _isGridView
                ? GridView.builder(
                    itemCount: contact.length + 2,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= contact.length
                          ? StreamBuilder<bool>(
                              stream: _viewModel.outputIsContactLoading,
                              builder: (context, snapshot) {
                                return Visibility(
                                  visible: snapshot.data ?? false,
                                  child: const YahoBottomLoader(),
                                );
                              })
                          : ContactItemGrid(contact: contact[index]);
                    },
                  )
                : ListView.builder(
                    itemCount: contact.length + 1,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= contact.length
                          ? StreamBuilder<bool>(
                              stream: _viewModel.outputIsContactLoading,
                              builder: (context, snapshot) {
                                return Visibility(
                                  visible: snapshot.data ?? false,
                                  child: const YahoBottomLoader(),
                                );
                              })
                          : ContactItemList(contact: contact[index]);
                    },
                  ),
            onLoadNextPage: () => _viewModel.onLoadNextPage(),
            onRefreshPage: () => _viewModel.onRefreshPage(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
