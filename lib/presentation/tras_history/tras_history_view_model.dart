import 'dart:async';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';
import 'package:instapay_admin/domain/use_case/calc_history/get_tras_history_use_case.dart';
import 'package:instapay_admin/domain/use_case/login/token_use_case.dart';
import 'package:instapay_admin/presentation/tras_history/tras_history_state.dart';

class TrasHistoryViewModel with ChangeNotifier {
  final TokenUseCase tokenUseCase;
  final GetTrasHistoryUseCase getTrasHistory;
  final excel = Excel.createExcel();

  TrasHistoryViewModel({
    required this.tokenUseCase,
    required this.getTrasHistory,
  }) {
    setDefaultCalcDateTime();
  }

  TrasHistoryState _state = TrasHistoryState();

  TrasHistoryState get state => _state;

  late PagingController<int, TrasInfo> _pagingController;

  set pagingController(PagingController<int, TrasInfo> controller) {
    _pagingController = controller;
  }

  void fetchHistoryPage(int page, int limit) async {
    if (state.trasHistory != null &&
        state.trasHistory!.count == state.totalTrasHistoryData.length) {
      _pagingController.appendLastPage([]);
      return;
    }
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

  Future<bool> getTrasHistoryInfo(String tid, int limit) async {
    String token = await tokenUseCase.loadAccessToken();
    final history = await getTrasHistory(token, tid, limit);
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

  Future<bool> searchTrasHistory(
      String searchDate, String tid, int limit) async {
    _state = state.copyWith(
      isLoadingCalcHistorySearch: true,
      totalTrasHistoryData: [],
    );
    notifyListeners();

    final result = await getTrasHistoryInfo(tid, limit);
    _pagingController.appendPage(state.trasHistory!.tras, 1);

    _state = state.copyWith(
      isLoadingCalcHistorySearch: false,
      trasHistoryTotalCount: state.trasHistory!.count,
    );
    notifyListeners();
    return result;
  }

  void setDefaultCalcDateTime() {
    _state = state.copyWith(
      calcDay: DateTime.now(),
    );
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
