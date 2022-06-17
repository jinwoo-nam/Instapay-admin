import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_date_select_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_detail_history_table_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_detail_history_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_summary_table_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/responsive/responsive.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrasHistoryWidget extends StatelessWidget {
  const TrasHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    double dateContainerWidth =
        MediaQuery.of(context).size.width < 500 ? 140 : 170;

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

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: mainWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '일일 정산 내역',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      //'날짜 지정',
                      '날짜',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TrasDateSelectWidget(
                        dateContainerWidth: dateContainerWidth,
                        state: state,
                      ),
                    ),
                    if (state.isCalcCalendarSelected) const CalendarWidget(),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.searchCalcHistory(
                          DateFormat('yyyy-MM-dd').format(state.calcDay!),
                        );
                      },
                      child: const Text('보기'),
                    ),
                    (state.isLoadingCalcHistorySearch == false)
                        ? (state.trasHistory != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Center(
                                      child: TrasSummaryTableWidget(
                                          dataTableWidth: dataTableWidth,
                                          state: state),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    '세부 거래내역',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: pointColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (state.trasHistory != null)
                                    TrasDetailHistoryTableWidget(
                                      info: state.trasHistory!.tras,
                                    ),
                                  // ...state.trasHistory!.tras.map((e) {
                                  //   return TrasDetailHistoryTableWidget(
                                  //     info: e,
                                  //   );
                                  // }).toList(),
                                ],
                              )
                            : Container()
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
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
