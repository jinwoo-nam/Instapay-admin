import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/franchisee/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_state.dart';

class QrManageViewModel with ChangeNotifier {
  final GetQrInfoListUseCase getQrInfo;

  QrManageViewModel({
    required this.getQrInfo,
  });

  QrManageState _state = QrManageState();

  QrManageState get state => _state;

  void setPeriodToday() {
    _state = state.copyWith(
      qrManageStartDay: DateTime.now(),
      qrManageEndDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodWeek() {
    _state = state.copyWith(
      qrManageStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 7)).year,
          DateTime.now().subtract(const Duration(days: 7)).month,
          DateTime.now().subtract(const Duration(days: 7)).day),
      qrManageEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void setPeriodOneMonth() {
    _state = state.copyWith(
      qrManageStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 30)).year,
          DateTime.now().subtract(const Duration(days: 30)).month,
          DateTime.now().subtract(const Duration(days: 30)).day),
      qrManageEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void setPeriodTwoMonth() {
    _state = state.copyWith(
      qrManageStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 60)).year,
          DateTime.now().subtract(const Duration(days: 60)).month,
          DateTime.now().subtract(const Duration(days: 60)).day),
      qrManageEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void setPeriodThreeMonth() {
    _state = state.copyWith(
      qrManageStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 90)).year,
          DateTime.now().subtract(const Duration(days: 90)).month,
          DateTime.now().subtract(const Duration(days: 90)).day),
      qrManageEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void getQrInfoList() async {
    final qrInfo = await getQrInfo();
    qrInfo.when(
        success: (data) {
          _state = state.copyWith(
            qrInfoList: data,
          );
        },
        error: (message) {});

    notifyListeners();
  }

  Future<void> searchQrInfoList(String startDate, String endDate) async {
    _state = state.copyWith(
      isLoadingQrManageSearch: true,
    );
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));
    getQrInfoList();

    _state = state.copyWith(
      isLoadingQrManageSearch: false,
    );
    notifyListeners();
  }

  Future<void> resetQrManage() async {
    _state = state.copyWith(
      qrInfoList: [],
      qrManageStartDay: null,
      qrManageEndDay: null,
    );
    notifyListeners();
  }
}
