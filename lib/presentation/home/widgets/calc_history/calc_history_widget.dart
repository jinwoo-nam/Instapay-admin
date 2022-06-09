import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/domain/model/calc_history/calc_history_detail_info.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:instapay_admin/util/util.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalcHistoryWidget extends StatelessWidget {
  const CalcHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 500,
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
                      '날짜 지정',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // viewModel.setCalendarSelectState(
                          //     !state.isCalendarSelected, PeriodType.start);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: secondaryColor,
                          ),
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.calcDay == null
                                    ? '정산일'
                                    : DateFormat('yyyy-MM-dd')
                                        .format(state.calcDay!),
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
                    ),
                    if (state.isCalendarSelected) const CalendarWidget(),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.searchCalcHistory(
                            DateFormat('yyyy-MM-dd').format(state.calcDay!));
                      },
                      child: const Text('보기'),
                    ),
                    (state.isLoadingCalcHistorySearch == false)
                        ? (state.calcHistorySummary != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 10.0),
                                    child: DataTable2(
                                        columnSpacing: 5,
                                        minWidth: 400,
                                        columns: const [
                                          DataColumn2(
                                            fixedWidth: 30,
                                            label: Center(
                                              child: Text(
                                                '구분',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            fixedWidth: 55,
                                            label: Center(
                                              child: Text(
                                                '건수',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            fixedWidth: 90,
                                            label: Center(
                                              child: Text(
                                                '금액',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            fixedWidth: 80,
                                            label: Center(
                                              child: Text(
                                                '수수료/VAT',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn2(
                                            fixedWidth: 80,
                                            label: Center(
                                              child: Text(
                                                '정산액',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: [
                                          DataRow2(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(state
                                                      .calcHistorySummary!
                                                      .complete
                                                      .state))),
                                              DataCell(Center(
                                                  child: Text(
                                                      '${state.calcHistorySummary!.complete.count}'))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .complete
                                                      .price)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .complete
                                                      .vat)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .complete
                                                      .result)))),
                                            ],
                                          ),
                                          DataRow2(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(state
                                                      .calcHistorySummary!
                                                      .cancel
                                                      .state))),
                                              DataCell(Center(
                                                  child: Text(
                                                      '${state.calcHistorySummary!.cancel.count}'))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .cancel
                                                      .price)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .cancel
                                                      .vat)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .cancel
                                                      .result)))),
                                            ],
                                          ),
                                          DataRow2(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(state
                                                      .calcHistorySummary!
                                                      .hold
                                                      .state))),
                                              DataCell(Center(
                                                  child: Text(
                                                      '${state.calcHistorySummary!.hold.count}'))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .hold
                                                      .price)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .hold
                                                      .vat)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .hold
                                                      .result)))),
                                            ],
                                          ),
                                          DataRow2(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(state
                                                      .calcHistorySummary!
                                                      .holdCancel
                                                      .state))),
                                              DataCell(Center(
                                                  child: Text(
                                                      '${state.calcHistorySummary!.holdCancel.count}'))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .holdCancel
                                                      .price)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .holdCancel
                                                      .vat)))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .holdCancel
                                                      .result)))),
                                            ],
                                          ),
                                          DataRow2(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(state
                                                      .calcHistorySummary!
                                                      .finalPrice
                                                      .state))),
                                              const DataCell(
                                                  Center(child: Text(''))),
                                              const DataCell(
                                                  Center(child: Text(''))),
                                              const DataCell(
                                                  Center(child: Text(''))),
                                              DataCell(Center(
                                                  child: Text(currencyFormat(state
                                                      .calcHistorySummary!
                                                      .finalPrice
                                                      .result)))),
                                            ],
                                          ),
                                        ]),
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
                                  ...state.calcDetailInfoList.map((e) {
                                    return CalcDetailHistory(
                                      info: e,
                                    );
                                  }).toList(),
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

class CalcDetailHistory extends StatelessWidget {
  final CalcHistoryDetailInfo info;

  const CalcDetailHistory({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '구분',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    info.state,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '승인일자',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    info.acceptDate,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '거래금액',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${info.paymentPrice}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '결제수단',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    info.paymentMethod,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '수수료',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${info.commission}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'VAT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${info.vat}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '정산금액',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${info.totalPrice}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '이용자',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    info.userName,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '결제내용',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    info.paymentContents,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
