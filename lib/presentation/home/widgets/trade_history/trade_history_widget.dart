import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/period_select_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/trade_history_info_list_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TradeHistoryWidget extends StatelessWidget {
  const TradeHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final periodSelect = [
      PeriodSelectData(title: '당일', type: PeriodSelectType.today),
      PeriodSelectData(title: '일주일', type: PeriodSelectType.week),
      PeriodSelectData(title: '1개월', type: PeriodSelectType.oneMonth),
      PeriodSelectData(title: '2개월', type: PeriodSelectType.twoMonth),
      PeriodSelectData(title: '3개월', type: PeriodSelectType.threeMonth),
    ];
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    final selectButtonWidth = MediaQuery.of(context).size.width < 500
        ? (MediaQuery.of(context).size.width - 40) / 5
        : (500 - 40) / 5;

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 500,
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
                              GestureDetector(
                                onTap: () {
                                  viewModel.setCalendarSelectState(
                                      !state.isCalendarSelected,
                                      PeriodType.start);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: secondaryColor,
                                  ),
                                  width: 170,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.startDay == null
                                            ? '시작일'
                                            : DateFormat('yyyy-MM-dd')
                                                .format(state.startDay!),
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
                              const SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  viewModel.setCalendarSelectState(
                                      !state.isCalendarSelected,
                                      PeriodType.end);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: secondaryColor,
                                  ),
                                  width: 170,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.endDay == null
                                            ? '종료일'
                                            : DateFormat('yyyy-MM-dd')
                                                .format(state.endDay!),
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
                            ],
                          ),
                          if (state.isCalendarSelected) const CalendarWidget(),
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
                          onPressed: () {},
                          child: const Text('검색'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('초기화'),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 16.0,
                        bottom: 8,
                      ),
                      child: Text(
                        '결제 완료',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: pointColor,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    ...state.paymentHistoryList.map((e) {
                      return TradeHistoryInfoListWidget(
                        paymentInfo: e,
                      );
                    }).toList(),
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
