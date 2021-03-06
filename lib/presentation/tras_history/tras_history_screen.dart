import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instapay_admin/domain/model/tras/tras_info.dart';
import 'package:instapay_admin/presentation/tras_history/tras_history_view_model.dart';
import 'package:instapay_admin/responsive/responsive.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common_widget/calendar_widget.dart';
import 'components/tras_date_select_widget.dart';
import 'components/tras_detail_history_widget.dart';
import 'components/tras_history_table.dart';
import 'components/tras_summary_table_widget.dart';

class TrasHistoryScreen extends StatefulWidget {
  const TrasHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TrasHistoryScreen> createState() => _TrasHistoryScreenState();
}

class _TrasHistoryScreenState extends State<TrasHistoryScreen> {
  final scrollController = ScrollController();
  final historyScrollController = ScrollController();
  final items = [10, 30, 50];
  int selectedValue = 10;
  final _pagingController = PagingController<int, TrasInfo>(firstPageKey: 1);

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
      final viewModel = context.read<TrasHistoryViewModel>();
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
    historyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TrasHistoryViewModel>();
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
      controller: scrollController,
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
                      '?????? ?????? ??????',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      //'?????? ??????',
                      '??????',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TrasDateSelectWidget(
                        dateContainerWidth: dateContainerWidth,
                        trasDay: state.calcDay,
                      ),
                    ),
                    if (state.isCalcCalendarSelected) const CalendarWidget(),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final result = await viewModel.searchTrasHistory(
                              DateFormat('yyyy-MM-dd').format(state.calcDay!),
                              '',
                              0,
                            );
                            if (result == false) {
                              _showToast('???????????? ?????? ???????????????. ?????? ????????? ????????????.');
                            }
                          },
                          child: const Text('??????'),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '?????? ????????????',
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
                                            child: const Text('????????? ????????????'),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                              '?????? ?????? : ${state.totalTrasHistoryData.length} / ${state.trasHistoryTotalCount}'),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      if (!Responsive.isMobile(context))
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: TrasHistoryTableHeader(),
                                        ),
                                      SizedBox(
                                        height: 600,
                                        child: PagedListView(
                                          scrollController:
                                              historyScrollController,
                                          pagingController: _pagingController,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<
                                                      TrasInfo>(
                                                  itemBuilder:
                                                      (context, tras, index) {
                                            if (Responsive.isMobile(context)) {
                                              return TrasDetailHistoryWidget(
                                                info: tras,
                                              );
                                            } else {
                                              return TrasHistoryTableBody(
                                                info: tras,
                                              );
                                            }
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
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
