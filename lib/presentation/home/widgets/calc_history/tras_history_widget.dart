import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_date_select_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_detail_history_table_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/calc_history/components/tras_summary_table_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/responsive/responsive.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrasHistoryWidget extends StatefulWidget {
  const TrasHistoryWidget({Key? key}) : super(key: key);

  @override
  State<TrasHistoryWidget> createState() => _TrasHistoryWidgetState();
}

class _TrasHistoryWidgetState extends State<TrasHistoryWidget> {
  final items = [10, 30, 50];
  int selectedValue = 10;

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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            viewModel.searchCalcHistory(
                              DateFormat('yyyy-MM-dd').format(state.calcDay!),
                              '',
                              selectedValue,
                            );
                          },
                          child: const Text('보기'),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        DropdownButton2(
                          isExpanded: true,
                          items: items
                              .map((item) => DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      '$item',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as int;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          //iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                          buttonHeight: 40,
                          buttonWidth: 100,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            // border: Border.all(
                            //   color: Colors.black26,
                            // ),
                            //color: Colors.redAccent,
                          ),
                          //buttonElevation: 2,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownWidth: 200,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            //color: Colors.redAccent,
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(-20, 0),
                        ),
                      ],
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
                                      totalCount: state.trasHistory!.count,
                                      selectedCount: selectedValue,
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
