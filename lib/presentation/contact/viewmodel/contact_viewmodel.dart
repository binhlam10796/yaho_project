import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yaho/common/resources/resources.dart';
import 'package:yaho/common/route/navigation_service.dart';
import 'package:yaho/core/models/mapper/contact.dart';
import 'package:yaho/core/usecases/contact_usecase.dart';
import 'package:yaho/di/di.dart';
import 'package:yaho/presentation/base/base_viewmodel.dart';
import 'package:yaho/utils/paging_helper.dart';

class ContactViewModel extends BaseViewModel
    with ContactViewModelInputs, ContactViewModelOutputs {
  final ContactUseCase _userUseCase;

  ContactViewModel(this._userUseCase);

  final NavigationService _navigationService = instance<NavigationService>();

  final List<Contact> _user = [];

  final _contactController = BehaviorSubject<List<Contact>>();
  final contactPagingHelper = PagingHelper<Contact>();

  final StreamController _inputIsContactLoadingController =
      BehaviorSubject<bool>();
  final _shimmerStateController = BehaviorSubject<bool>();

  @override
  Sink get inputIsContactLoading => _inputIsContactLoadingController.sink;

  @override
  Sink get inputShimmerState => _shimmerStateController.sink;

  @override
  Sink get inputContact => _contactController.sink;

  @override
  Stream<List<Contact>> get outputContact =>
      _contactController.stream.map((data) => data);

  @override
  Stream<bool> get outputShimmerState =>
      _shimmerStateController.stream.map((data) => data);

  @override
  Stream<bool> get outputIsContactLoading =>
      _inputIsContactLoadingController.stream.map((isLoading) => isLoading);

  @override
  void dispose() {
    _contactController.close();
    _shimmerStateController.close();
    _inputIsContactLoadingController.close();
  }

  fetchContact(bool firstLoad) async {
    if (firstLoad) {
      inputShimmerState.add(true);
      _user.clear();
      inputContact.add(_user);
    } else {
      if (!contactPagingHelper.canLoadNextPage()) {
        inputShimmerState.add(false);
        return;
      }
    }

    if (!firstLoad) {
      inputIsContactLoading.add(true);
    }
    contactPagingHelper.isLoadingPage = true;

    (await _userUseCase.fetchContact(contactPagingHelper.pageNumber)).fold(
      (failure) {
        var data = {
          "title": AppStrings.error.tr(),
          "message": failure.message,
        };
        _navigationService.openDialog(
          types: DialogTypes.error,
          data: data,
          singleTapListener: (_) {
            _navigationService.dismissDialog();
          },
        );
        inputIsContactLoading.add(false);
        contactPagingHelper.setLastPage();
      },
      (response) {
        inputShimmerState.add(false);
        inputIsContactLoading.add(false);
        if (response.isNotEmpty) {
          _user.addAll(response);
          inputContact.add(_user);
          if (response.length < contactPagingHelper.pageSize) {
            contactPagingHelper.appendLastPage(response);
          } else {
            contactPagingHelper.appendPage(response);
          }
        } else {
          contactPagingHelper.setLastPage();
        }
      },
    );
    contactPagingHelper.isLoadingPage = false;
  }

  onLoadNextPage() {
    fetchContact(false);
  }

  onRefreshPage() {
    contactPagingHelper.initRefresh();
    fetchContact(true);
  }

  @override
  void start() {
    fetchContact(true);
  }
}

abstract class ContactViewModelInputs {
  Sink get inputIsContactLoading;

  Sink get inputShimmerState;

  Sink get inputContact;
}

abstract class ContactViewModelOutputs {
  Stream<bool> get outputIsContactLoading;

  Stream<bool> get outputShimmerState;

  Stream<List<Contact>> get outputContact;
}
