import 'dart:async';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';
import 'package:instapay_admin/domain/model/franchisee/contact.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_tras_history_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/info/get_franchisee_info_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/manager/manager_use_case.dart';
import 'package:instapay_admin/domain/use_case/franchisee/qr/get_qr_info_list_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/domain/use_case/trade_history/get_payment_history_use_case.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_ui_event.dart';

class HomeViewModel with ChangeNotifier {
  final ManagerUseCase managerUseCase;
  final GetQrInfoListUseCase getQrInfo;
  final GetPaymentHistoryUseCase getPaymentHistory;
  final GetFranchiseeInfoUseCase getFranchiseeInfo;
  final TokenUseCase tokenUseCase;
  final GetTrasHistoryUseCase getTrasHistory;
  final excel = Excel.createExcel();

  HomeViewModel({
    required this.managerUseCase,
    required this.getQrInfo,
    required this.getPaymentHistory,
    required this.getFranchiseeInfo,
    required this.tokenUseCase,
    required this.getTrasHistory,
  }) {
    setDefaultCalcDateTime();
    getFranchiseeInfoList();
  }

  HomeState _state = HomeState();

  HomeState get state => _state;

  late PagingController<int, TrasInfo> _pagingController;

  set pagingController(PagingController<int, TrasInfo> controller) {
    _pagingController = controller;
  }

  final _eventController = StreamController<HomeUiEvent>.broadcast();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  Future<void> getFranchiseeInfoList() async {
    final token = await tokenUseCase.loadAccessToken();
    final storeInfo = await getFranchiseeInfo.getStoreInfo(token);
    storeInfo.when(success: (data) {
      _state = state.copyWith(
        storeData: data,
        managers: data.contacts,
      );
      managerUseCase.setManagers(state.managers);
    }, error: (message) {
      _eventController.add(const HomeUiEvent.logout());
      print(message);
    });

    notifyListeners();
  }

  Future<void> searchCalcHistory(
      String searchDate, String tid, int limit) async {
    _state = state.copyWith(
      isLoadingCalcHistorySearch: true,
      totalTrasHistoryData: [],
    );
    notifyListeners();

    await getTrasHistoryInfo(tid, limit);
    _pagingController.appendPage(state.trasHistory!.tras, 1);

    _state = state.copyWith(
      isLoadingCalcHistorySearch: false,
      trasHistoryTotalCount: state.trasHistory!.count,
    );
    notifyListeners();
  }

  Future<void> searchTradeHistory(String startDate, String endDate) async {
    _state = state.copyWith(
      isLoadingTradeHistorySearch: true,
    );
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));
    getPaymentHistoryList();

    _state = state.copyWith(
      isLoadingTradeHistorySearch: false,
    );
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

  Future<void> resetTradeHistory() async {
    _state = state.copyWith(
      paymentHistoryList: [],
      tradeStartDay: null,
      tradeEndDay: null,
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

  void fetchHistoryPage(int page, int limit) async {
    String tid = '';
    if (state.trasHistory!.tras.isNotEmpty) {
      tid = state.trasHistory!.tras.last.tid!;
    }

    await getTrasHistoryInfo(tid, limit);

    final isLastPage = state.trasHistory!.tras.length < limit;
    if (isLastPage) {
      _pagingController.appendLastPage(state.trasHistory!.tras);
    } else {
      final nextPageKey = page + 1;
      _pagingController.appendPage(state.trasHistory!.tras, nextPageKey);
    }

    notifyListeners();
  }

  Future<void> getTrasHistoryInfo(String tid, int limit) async {
    String token = await tokenUseCase.loadAccessToken();
    final history = await getTrasHistory(token, tid, limit);
    List<TrasInfo> trasInfoList = List.from(state.totalTrasHistoryData);
    history.when(
      success: (data) {
        List<TrasInfo> temp = List.from(trasInfoList)..addAll(data.tras);
        _state = state.copyWith(
          trasHistory: data,
          totalTrasHistoryData: temp,
        );
      },
      error: (message) {
        print(message);
      },
    );
  }

  Future<void> getTrasPagination(int limit) async {}

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

  void addManagerData(Contact manager) async {
    String token = await tokenUseCase.loadAccessToken();
    final res = await managerUseCase.addManager(manager, token);
    res.when(success: (data) {
      if (data == "ok") {
        _state = state.copyWith(
          managers: managerUseCase.getManagers(),
        );
        _eventController.add(const HomeUiEvent.showSnackBar('담당자 추가 성공'));
      } else {
        _eventController
            .add(const HomeUiEvent.showSnackBar('담당자 추가에 실패 했습니다.'));
      }
    }, error: (message) {
      _eventController.add(const HomeUiEvent.showSnackBar('담당자 추가에 실패 했습니다.'));
    });
    notifyListeners();
  }

  void deleteManagerData(int index) async {
    String token = await tokenUseCase.loadAccessToken();
    final res = await managerUseCase.deleteManager(index, token);
    res.when(success: (data) {
      if (data == "ok") {
        _state = state.copyWith(
          managers: managerUseCase.getManagers(),
        );
        _eventController.add(const HomeUiEvent.showSnackBar('담당자 삭제'));
      } else {
        _eventController
            .add(const HomeUiEvent.showSnackBar('담당자 삭제에 실패 했습니다.'));
      }
    }, error: (message) {
      _eventController.add(const HomeUiEvent.showSnackBar('담당자 삭제에 실패 했습니다.'));
    });
    notifyListeners();
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
    } else if (state.periodType == CalendarType.qrCreate) {
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

  void ExcelExport() async {
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        '구분';

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        '승인 일자';

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "거래 금액";

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        "결제수단";

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        "수수료";

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
        "VAT";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
        "정산금액";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
        "이용자";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
        "결제내용";

    for (var row = 0; row < state.totalTrasHistoryData.length; row++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].tstatus;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].adate;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].paymentAmount;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].paymentMethods;

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
          .value = '0';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
          .value = "0";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].paymentAmount;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].payerName;
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1))
          .value = state.totalTrasHistoryData[row].productName;
    }
    excel.save(fileName: "세부 거래내역.xlsx");
  }
}
