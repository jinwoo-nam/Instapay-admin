import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/domain/use_case/store/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_state.dart';

class QrManageViewModel with ChangeNotifier {
  final GetQrInfoListUseCase getQrInfo;
  final TokenUseCase tokenUseCase;

  QrManageViewModel({
    required this.getQrInfo,
    required this.tokenUseCase,
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

  Future<bool> getQrInfoList() async {
    String token = await tokenUseCase.loadAccessToken();
    bool res = false;

    final qrInfo = await getQrInfo(token);
    qrInfo.when(
        success: (data) {
          _state = state.copyWith(
            qrInfoList: data,
          );
          res = true;
        },
        error: (message) {});

    return res;
  }

  Future<bool> searchQrInfoList(String startDate, String endDate) async {
    _state = state.copyWith(
      isLoadingQrManageSearch: true,
    );
    notifyListeners();

    bool res = await getQrInfoList();

    _state = state.copyWith(
      isLoadingQrManageSearch: false,
    );
    notifyListeners();
    return res;
  }

  Future<void> resetQrManage() async {
    _state = state.copyWith(
      qrInfoList: [],
      qrManageStartDay: null,
      qrManageEndDay: null,
    );
    notifyListeners();
  }

  void setQrCreateCalendarSelectState(bool isSelected) {
    _state = state.copyWith(
      isQrCreateCalendarSelected: isSelected,
    );
    notifyListeners();
  }

  void setQrDetailCalendarSelectState(bool isSelected) {
    _state = state.copyWith(
      isQrDetailCalendarSelected: isSelected,
    );
    notifyListeners();
  }

  void setQrManageCalendarSelectState(bool isSelected, bool isStartSelect) {
    _state = state.copyWith(
      isQrManageCalendarSelected: isSelected,
      isStartDateCalendarSelected: isStartSelect,
    );
    notifyListeners();
  }

  void selectDateOnCalendar(DateTime date) {
    if (state.isStartDateCalendarSelected) {
      _state = state.copyWith(
        qrManageStartDay: date,
        isQrManageCalendarSelected: false,
      );
    } else {
      _state = state.copyWith(
        qrManageEndDay: date,
        isQrManageCalendarSelected: false,
      );
    }
    notifyListeners();
  }

  void selectQrCreateDateOnCalendar(DateTime date) {
    _state = state.copyWith(
      qrCreateEndDay: date,
      isQrCreateCalendarSelected: false,
    );
    notifyListeners();
  }

  void selectQrDetailDateOnCalendar(DateTime date) {
    _state = state.copyWith(
      qrDetailEndDay: date,
      isQrDetailCalendarSelected: false,
    );
    notifyListeners();
  }
}
