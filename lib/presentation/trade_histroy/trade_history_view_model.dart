import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instapay_admin/domain/model/tras/tras_info.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/domain/use_case/tras/get_tras_history_use_case.dart';
import 'package:instapay_admin/presentation/trade_histroy/trade_history_state.dart';

class TradeHistoryViewModel with ChangeNotifier {
  final TokenUseCase tokenUseCase;
  final GetTrasHistoryUseCase getTrasHistory;
  final excel = Excel.createExcel();

  TradeHistoryViewModel({
    required this.tokenUseCase,
    required this.getTrasHistory,
  });

  TradeHistoryState _state = TradeHistoryState();

  TradeHistoryState get state => _state;

  late PagingController<int, TrasInfo> _pagingController;

  set pagingController(PagingController<int, TrasInfo> controller) {
    _pagingController = controller;
  }

  void fetchHistoryPage(int page, int limit) async {
    if (state.trasHistory != null &&
        state.trasHistory!.count <= state.totalTrasHistoryData.length) {
      _pagingController.appendLastPage([]);
      return;
    }
    String tid = '';
    if (state.trasHistory!.tras.isNotEmpty) {
      tid = state.trasHistory!.tras.last.tid!;
    }

    await getPaymentHistoryList(tid, limit);

    final isLastPage = state.trasHistory!.tras.length < limit;
    if (isLastPage) {
      _pagingController.appendLastPage(state.trasHistory!.tras);
    } else {
      final nextPageKey = page + 1;
      _pagingController.appendPage(state.trasHistory!.tras, nextPageKey);
    }

    notifyListeners();
  }

  void setPeriodToday() {
    _state = state.copyWith(
      tradeStartDay: DateTime.now(),
      tradeEndDay: DateTime.now(),
    );
    notifyListeners();
  }

  void setPeriodWeek() {
    _state = state.copyWith(
      tradeStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 7)).year,
          DateTime.now().subtract(const Duration(days: 7)).month,
          DateTime.now().subtract(const Duration(days: 7)).day),
      tradeEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void setPeriodOneMonth() {
    _state = state.copyWith(
      tradeStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 30)).year,
          DateTime.now().subtract(const Duration(days: 30)).month,
          DateTime.now().subtract(const Duration(days: 30)).day),
      tradeEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void setPeriodTwoMonth() {
    _state = state.copyWith(
      tradeStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 60)).year,
          DateTime.now().subtract(const Duration(days: 60)).month,
          DateTime.now().subtract(const Duration(days: 60)).day),
      tradeEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  void setPeriodThreeMonth() {
    _state = state.copyWith(
      tradeStartDay: DateTime(
          DateTime.now().subtract(const Duration(days: 90)).year,
          DateTime.now().subtract(const Duration(days: 90)).month,
          DateTime.now().subtract(const Duration(days: 90)).day),
      tradeEndDay: DateTime.now(),
    );

    notifyListeners();
  }

  Future<bool> searchTradeHistory(
      String startDate, String endDate, String tid, int limit) async {
    _state = state.copyWith(
      isLoadingTradeHistorySearch: true,
      totalTrasHistoryData: [],
    );
    notifyListeners();

    _pagingController.refresh();
    final result = await getPaymentHistoryList(tid, limit);
    _pagingController.appendPage(state.trasHistory!.tras, 1);

    _state = state.copyWith(
      isLoadingTradeHistorySearch: false,
      trasHistoryTotalCount: state.trasHistory!.count,
    );
    notifyListeners();
    return result;
  }

  Future<bool> getPaymentHistoryList(String tid, int limit) async {
    String token = await tokenUseCase.loadAccessToken();
    final history = await getTrasHistory(token, tid, limit, state: 'approve');
    List<TrasInfo> trasInfoList = List.from(state.totalTrasHistoryData);
    bool result = false;

    history.when(
      success: (data) {
        List<TrasInfo> temp = List.from(trasInfoList)..addAll(data.tras);
        _state = state.copyWith(
          trasHistory: data,
          totalTrasHistoryData: temp,
        );
        result = true;
      },
      error: (message) {
        print(message);
      },
    );
    return result;
  }

  Future<void> resetTradeHistory() async {
    _state = state.copyWith(
      tradeStartDay: null,
      tradeEndDay: null,
    );
    notifyListeners();
  }

  void setCalendarSelectState(bool isSelected, bool isStartSelect) {
    _state = state.copyWith(
      isTradeCalendarSelected: isSelected,
      isStartDateCalendarSelected: isStartSelect,
    );
    notifyListeners();
  }

  void selectDateOnCalendar(DateTime date) {
    if (state.isStartDateCalendarSelected) {
      _state = state.copyWith(
        tradeStartDay: date,
        isTradeCalendarSelected: false,
      );
    } else {
      _state = state.copyWith(
        tradeEndDay: date,
        isTradeCalendarSelected: false,
      );
    }
    notifyListeners();
  }

  void ExcelExport() async {
    final Sheet sheet = excel[excel.getDefaultSheet()!];

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        '??????';

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        '?????? ??????';

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "?????? ??????";

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        "????????????";

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        "?????????";

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
        "VAT";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
        "????????????";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
        "?????????";
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
        "????????????";

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
    excel.save(fileName: "????????????.xlsx");
  }
}
