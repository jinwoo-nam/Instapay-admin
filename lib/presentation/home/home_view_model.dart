import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/franchisee_manager_info.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final ManagerUseCase managerUseCase;
  final GetQrInfoListUseCase getQrInfo;

  HomeViewModel({
    required this.managerUseCase,
    required this.getQrInfo,
  }) {
    setDefaultCalcDateTime();
    getManagerData();
    getQrInfoList();
  }

  HomeState _state = HomeState();

  HomeState get state => _state;

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

  void getManagerData() async {
    final managers = await managerUseCase.getManager();
    managers.when(
        success: (data) {
          _state = state.copyWith(managers: data);
        },
        error: (message) {});
    notifyListeners();
  }

  void addManagerData(FranchiseeManagerInfo manager) async {
    await managerUseCase.addManager(manager);

    getManagerData();
  }

  void deleteManagerData(int index) async {
    await managerUseCase.deleteManager(index);

    getManagerData();
  }

  void setDefaultCalcDateTime() {
    _state = state.copyWith(
      calcDay: DateTime.now(),
    );
  }

  void setSelectScreenType(SelectScreenType type) {
    _state = state.copyWith(
      selectScreenType: type,
    );
    notifyListeners();
  }

  void setCalendarSelectState(bool selected, PeriodType type) {
    _state = state.copyWith(
      isCalendarSelected: selected,
      periodType: type,
    );
    notifyListeners();
  }

  void setSelectedDay(DateTime? selectedDay) {
    if (state.periodType == PeriodType.start) {
      _state = state.copyWith(
        startDay: selectedDay,
        isCalendarSelected: false,
      );
    } else if (state.periodType == PeriodType.end) {
      _state = state.copyWith(
        endDay: selectedDay,
        isCalendarSelected: false,
      );
    } else if (state.periodType == PeriodType.qrManage) {
      _state = state.copyWith(
        qrManageEndDay: selectedDay,
        isCalendarSelected: false,
      );
    } else if (state.periodType == PeriodType.qrDetail) {
      _state = state.copyWith(
        qrDetailEndDay: selectedDay,
        isCalendarSelected: false,
      );
    }

    notifyListeners();
  }

  void setPeriodToday() {
    _state = state.copyWith(
      startDay: DateTime.now(),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodWeek() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 7)).year,
          DateTime.now().subtract(const Duration(days: 7)).month,
          DateTime.now().subtract(const Duration(days: 7)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodOneMonth() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 30)).year,
          DateTime.now().subtract(const Duration(days: 30)).month,
          DateTime.now().subtract(const Duration(days: 30)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodTwoMonth() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 60)).year,
          DateTime.now().subtract(const Duration(days: 60)).month,
          DateTime.now().subtract(const Duration(days: 60)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodThreeMonth() {
    _state = state.copyWith(
      startDay: DateTime(
          DateTime.now().subtract(const Duration(days: 90)).year,
          DateTime.now().subtract(const Duration(days: 90)).month,
          DateTime.now().subtract(const Duration(days: 90)).day),
      endDay: DateTime.now(),
    );
    notifyListeners();
  }
}
