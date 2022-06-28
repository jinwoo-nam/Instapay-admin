import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instapay_admin/presentation/trade_histroy/components/trade_detail_page_widget.dart';
import 'package:instapay_admin/presentation/trade_histroy/components/trade_history_info_list_widget.dart';
import 'package:instapay_admin/presentation/trade_histroy/trade_history_view_model.dart';
import 'package:instapay_admin/presentation/tras_history/components/tras_history_table.dart';
import 'package:instapay_admin/responsive/responsive.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/model/calc_history/tras_info.dart';
import '../common_widget/calendar_widget.dart';
import '../common_widget/period_select_widget.dart';

class TradeHistoryScreen extends StatefulWidget {
  const TradeHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TradeHistoryScreen> createState() => _TradeHistoryScreenState();
}

class _TradeHistoryScreenState extends State<TradeHistoryScreen> {
  final scrollController = ScrollController();
  final tradeScrollController = ScrollController();
  String startDateNotSelect = '';
  String endDateNotSelect = '';
  final _pagingController = PagingController<int, TrasInfo>(firstPageKey: 1);
  final items = [10, 30, 50];
  int selectedValue = 10;

  late FToast fToast;
  late Widget toast;

  _removeToast() {
    fToast.removeCustomToast();
  }

  _showToast(String message) {
    _removeToast();

    fToast.showToast(
      child: Container(
          width: 250,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.grey,
          ),
          child: Center(
            child: Text(message),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 4),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        fToast = FToast();
        fToast.init(context);
      },
    );
    Future.microtask(() {
      final viewModel = context.read<TradeHistoryViewModel>();
      _pagingController.addPageRequestListener((pageKey) {
        viewModel.fetchHistoryPage(pageKey, 0);
      });
      viewModel.pagingController = _pagingController;

      _pagingController.appendPage(viewModel.state.totalTrasHistoryData, 1);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    scrollController.dispose();
    tradeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TradeHistoryViewModel>();
    final state = viewModel.state;
    final double mainWidth;
    final double dataTableWidth;
    if (Responsive.isMobile(context)) {
      mainWidth = 500;
      dataTableWidth = 400;
    } else if (Responsive.isTablet(context)) {
      mainWidth = 750;
      dataTableWidth = 700;
    } else {
      mainWidth = 1000;
      dataTableWidth = 900;
    }

    final selectButtonWidth = MediaQuery.of(context).size.width < 500
        ? (MediaQuery.of(context).size.width - 40) / 5
        : (mainWidth - 40) / 5;
    double dateContainerWidth =
        MediaQuery.of(context).size.width < mainWidth ? 140 : 170;

    return SingleChildScrollView(
      controller: scrollController,
      child: Center(
        child: SizedBox(
          width: mainWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '거래내역 조회',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      '기간 입력',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.setCalendarSelectState(
                                          !state.isTradeCalendarSelected, true);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: secondaryColor,
                                      ),
                                      width: dateContainerWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.tradeStartDay == null
                                                ? '시작일'
                                                : DateFormat('yyyy-MM-dd')
                                                    .format(
                                                        state.tradeStartDay!),
                                            style: const TextStyle(
                                              color: Colors.white54,
                                            ),
                                          ),
                                          const FaIcon(
                                            FontAwesomeIcons.calendarDays,
                                            color: Colors.white54,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      startDateNotSelect,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.setCalendarSelectState(
                                          !state.isTradeCalendarSelected,
                                          false);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(13),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: secondaryColor,
                                      ),
                                      width: dateContainerWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.tradeEndDay == null
                                                ? '종료일'
                                                : DateFormat('yyyy-MM-dd')
                                                    .format(state.tradeEndDay!),
                                            style: const TextStyle(
                                              color: Colors.white54,
                                            ),
                                          ),
                                          const FaIcon(
                                            FontAwesomeIcons.calendarDays,
                                            color: Colors.white54,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      endDateNotSelect,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (state.isTradeCalendarSelected)
                            CalendarWidget(
                              onCalendarTap: (date) {
                                viewModel.selectDateOnCalendar(date);
                              },
                            ),
                        ],
                      ),
                    ),
                    const Text(
                      '기간 선택',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: periodSelect
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  switch (e.type) {
                                    case PeriodSelectType.today:
                                      viewModel.setPeriodToday();
                                      break;
                                    case PeriodSelectType.week:
                                      viewModel.setPeriodWeek();
                                      break;
                                    case PeriodSelectType.oneMonth:
                                      viewModel.setPeriodOneMonth();
                                      break;
                                    case PeriodSelectType.twoMonth:
                                      viewModel.setPeriodTwoMonth();
                                      break;
                                    case PeriodSelectType.threeMonth:
                                      viewModel.setPeriodThreeMonth();
                                      break;
                                  }
                                },
                                child: PeriodSelectWidget(
                                  data: e,
                                  selectButtonWidth: selectButtonWidth,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            String start = '', end = '';

                            if (state.tradeStartDay != null) {
                              start = DateFormat('yyyy-MM-dd')
                                  .format(state.tradeStartDay!);
                            }
                            if (state.tradeEndDay != null) {
                              end = DateFormat('yyyy-MM-dd')
                                  .format(state.tradeEndDay!);
                            }

                            final result = await viewModel.searchTradeHistory(
                                start, end, '', 0);

                            if (result == false) {
                              _showToast('로그인이 만료 되었습니다. 다시 로그인 해주세요.');
                            }
                          },
                          child: const Text('검색'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.resetTradeHistory();
                            setState(() {
                              startDateNotSelect = '';
                              endDateNotSelect = '';
                            });
                          },
                          child: const Text('초기화'),
                        ),
                      ],
                    ),
                    (state.isLoadingTradeHistorySearch == false)
                        ? (state.trasHistory != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 35.0,
                                      bottom: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '결제 완료',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: pointColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                viewModel.ExcelExport();
                                              },
                                              child: const Text('엑셀로 내려받기'),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                '거래 내역 : ${state.totalTrasHistoryData.length} / ${state.trasHistoryTotalCount}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 16.0),
                                    child: Divider(
                                      height: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (!Responsive.isMobile(context))
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: TrasHistoryTableHeader(),
                                    ),
                                  SizedBox(
                                    height: 600,
                                    child: PagedListView(
                                      scrollController: tradeScrollController,
                                      pagingController: _pagingController,
                                      builderDelegate:
                                          PagedChildBuilderDelegate<TrasInfo>(
                                              itemBuilder:
                                                  (context, tras, index) {
                                        if (Responsive.isMobile(context)) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TradeDetailPageWidget(
                                                          info: tras,
                                                        )),
                                              );
                                            },
                                            child: TradeHistoryInfoListWidget(
                                              info: tras,
                                            ),
                                          );
                                        } else {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TradeDetailPageWidget(
                                                          info: tras,
                                                        )),
                                              );
                                            },
                                            child: TrasHistoryTableBody(
                                              info: tras,
                                            ),
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                        : const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
