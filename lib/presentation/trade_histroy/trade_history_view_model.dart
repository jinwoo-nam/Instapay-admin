import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/use_case/trade_history/get_payment_history_use_case.dart';
import 'package:instapay_admin/presentation/trade_histroy/trade_history_state.dart';

class TradeHistoryViewModel with ChangeNotifier {
  final GetPaymentHistoryUseCase getPaymentHistory;

  TradeHistoryViewModel({
    required this.getPaymentHistory,
  });

  TradeHistoryState _state = TradeHistoryState();

  TradeHistoryState get state => _state;

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

  Future<bool> searchTradeHistory(String startDate, String endDate) async {
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
    return true;
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
  }

  Future<void> resetTradeHistory() async {
    _state = state.copyWith(
      paymentHistoryList: [],
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
}
