import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/franchisee/franchisee_manager_info.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_calc_detail_info_use_case.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_calc_history_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/domain/use_case/trade_history/get_payment_history_use_case.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final ManagerUseCase managerUseCase;
  final GetQrInfoListUseCase getQrInfo;
  final GetPaymentHistoryUseCase getPaymentHistory;
  final GetCalcHistoryUseCase getCalcHistory;
  final GetCalcDetailInfoUseCase getCalcDetailInfo;

  HomeViewModel({
    required this.managerUseCase,
    required this.getQrInfo,
    required this.getPaymentHistory,
    required this.getCalcHistory,
    required this.getCalcDetailInfo,
  }) {
    getPaymentHistoryList();
    setDefaultCalcDateTime();
    getManagerData();
    getQrInfoList();
  }

  HomeState _state = HomeState();

  HomeState get state => _state;

  Future<void> searchCalcHistory(String searchDate) async {
    _state = state.copyWith(
      isLoadingCalcHistorySearch: true,
    );
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));
    getCalcHistoryInfo();
    getCalcDetailInfoList();

    _state = state.copyWith(
      isLoadingCalcHistorySearch: false,
    );
    notifyListeners();
  }

  void getCalcDetailInfoList() async {
    final calcDetail = await getCalcDetailInfo();
    calcDetail.when(
        success: (data) {
          _state = state.copyWith(
            calcDetailInfoList: data,
          );
        },
        error: (message) {});
  }

  void getCalcHistoryInfo() async {
    final calcHistory = await getCalcHistory();
    calcHistory.when(
        success: (data) {
          _state = state.copyWith(
            calcHistorySummary: data,
          );
        },
        error: (message) {});
  }

  void getPaymentHistoryList() async {
    final tradeHistory = await getPaymentHistory();
    tradeHistory.when(
      success: (data) {
        _state = state.copyWith(
          paymentHistoryList: data,
        );
      },
      error: (message) {},
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

  void setCalendarSelectState(bool selected, CalendarType type) {
    if (type == CalendarType.trade_start || type == CalendarType.trade_end) {
      _state = state.copyWith(
        isTradeCalendarSelected: selected,
        periodType: type,
      );
    } else if (type == CalendarType.calc) {
      _state = state.copyWith(
        isCalcCalendarSelected: selected,
        periodType: type,
      );
    } else if (type == CalendarType.qrManage_start ||
        type == CalendarType.qrManage_end) {
      _state = state.copyWith(
        isQrManageCalendarSelected: selected,
        periodType: type,
      );
    } else if (type == CalendarType.qrDetail) {
      _state = state.copyWith(
        isQrDetailCalendarSelected: selected,
        periodType: type,
      );
    } else if (type == CalendarType.qrCreate) {
      _state = state.copyWith(
        isQrCreateCalendarSelected: selected,
        periodType: type,
      );
    }

    notifyListeners();
  }

  void setSelectedDay(DateTime? selectedDay) {
    if (state.periodType == CalendarType.trade_start) {
      _state = state.copyWith(
        tradeStartDay: selectedDay,
        isTradeCalendarSelected: false,
      );
    } else if (state.periodType == CalendarType.trade_end) {
      _state = state.copyWith(
        tradeEndDay: selectedDay,
        isTradeCalendarSelected: false,
      );
    } else if (state.periodType == CalendarType.calc) {
      _state = state.copyWith(
        calcDay: selectedDay,
        isCalcCalendarSelected: false,
      );
    } else if (state.periodType == CalendarType.qrManage_start) {
      _state = state.copyWith(
        qrManageStartDay: selectedDay,
        isQrManageCalendarSelected: false,
      );
    } else if (state.periodType == CalendarType.qrManage_end) {
      _state = state.copyWith(
        qrManageEndDay: selectedDay,
        isQrManageCalendarSelected: false,
      );
    } else if (state.periodType == CalendarType.qrDetail) {
      _state = state.copyWith(
        qrDetailEndDay: selectedDay,
        isQrDetailCalendarSelected: false,
      );
    }else if (state.periodType == CalendarType.qrCreate) {
      _state = state.copyWith(
        qrCreateEndDay: selectedDay,
        isQrCreateCalendarSelected: false,
      );
    }

    notifyListeners();
  }

  void setPeriodToday(PeriodGroupSelectType type) {
    switch (type) {
      case PeriodGroupSelectType.trade:
        _state = state.copyWith(
          tradeStartDay: DateTime.now(),
          tradeEndDay: DateTime.now(),
        );
        break;
      case PeriodGroupSelectType.qrManage:
        _state = state.copyWith(
          qrManageStartDay: DateTime.now(),
          qrManageEndDay: DateTime.now(),
        );
        break;
    }
    notifyListeners();
  }

  void setPeriodWeek(PeriodGroupSelectType type) {
    switch (type) {
      case PeriodGroupSelectType.trade:
        _state = state.copyWith(
          tradeStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 7)).year,
              DateTime.now().subtract(const Duration(days: 7)).month,
              DateTime.now().subtract(const Duration(days: 7)).day),
          tradeEndDay: DateTime.now(),
        );
        break;
      case PeriodGroupSelectType.qrManage:
        _state = state.copyWith(
          qrManageStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 7)).year,
              DateTime.now().subtract(const Duration(days: 7)).month,
              DateTime.now().subtract(const Duration(days: 7)).day),
          qrManageEndDay: DateTime.now(),
        );
        break;
    }

    notifyListeners();
  }

  void setPeriodOneMonth(PeriodGroupSelectType type) {
    switch (type) {
      case PeriodGroupSelectType.trade:
        _state = state.copyWith(
          tradeStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 30)).year,
              DateTime.now().subtract(const Duration(days: 30)).month,
              DateTime.now().subtract(const Duration(days: 30)).day),
          tradeEndDay: DateTime.now(),
        );
        break;
      case PeriodGroupSelectType.qrManage:
        _state = state.copyWith(
          qrManageStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 30)).year,
              DateTime.now().subtract(const Duration(days: 30)).month,
              DateTime.now().subtract(const Duration(days: 30)).day),
          qrManageEndDay: DateTime.now(),
        );
        break;
    }
    notifyListeners();
  }

  void setPeriodTwoMonth(PeriodGroupSelectType type) {
    switch (type) {
      case PeriodGroupSelectType.trade:
        _state = state.copyWith(
          tradeStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 60)).year,
              DateTime.now().subtract(const Duration(days: 60)).month,
              DateTime.now().subtract(const Duration(days: 60)).day),
          tradeEndDay: DateTime.now(),
        );
        break;
      case PeriodGroupSelectType.qrManage:
        _state = state.copyWith(
          qrManageStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 60)).year,
              DateTime.now().subtract(const Duration(days: 60)).month,
              DateTime.now().subtract(const Duration(days: 60)).day),
          qrManageEndDay: DateTime.now(),
        );
        break;
    }
    notifyListeners();
  }

  void setPeriodThreeMonth(PeriodGroupSelectType type) {
    switch (type) {
      case PeriodGroupSelectType.trade:
        _state = state.copyWith(
          tradeStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 90)).year,
              DateTime.now().subtract(const Duration(days: 90)).month,
              DateTime.now().subtract(const Duration(days: 90)).day),
          tradeEndDay: DateTime.now(),
        );
        break;
      case PeriodGroupSelectType.qrManage:
        _state = state.copyWith(
          qrManageStartDay: DateTime(
              DateTime.now().subtract(const Duration(days: 90)).year,
              DateTime.now().subtract(const Duration(days: 90)).month,
              DateTime.now().subtract(const Duration(days: 90)).day),
          qrManageEndDay: DateTime.now(),
        );
        break;
    }
    notifyListeners();
  }
}
