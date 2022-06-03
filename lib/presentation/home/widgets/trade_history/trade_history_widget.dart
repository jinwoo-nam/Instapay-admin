import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TradeHistoryWidget extends StatelessWidget {
  const TradeHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return SingleChildScrollView(
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
                                  !state.isCalendarSelected, PeriodType.start);
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
                                  !state.isCalendarSelected, PeriodType.end);
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
