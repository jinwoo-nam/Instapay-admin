import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_view_model.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common_widget/calendar_widget.dart';
import '../../common_widget/period_select_widget.dart';
import 'components/create_qr_widget.dart';
import 'components/qr_info_list_widget.dart';

class QrManageScreen extends StatefulWidget {
  const QrManageScreen({Key? key}) : super(key: key);

  @override
  State<QrManageScreen> createState() => _QrManageScreenState();
}

class _QrManageScreenState extends State<QrManageScreen> {
  final scrollController = ScrollController();
  String startDateNotSelect = '';
  String endDateNotSelect = '';
  late FToast fToast;
  late Widget toast;

  _removeToast() {
    fToast.removeCustomToast();
  }

  _showToast(String message) {
    _removeToast();

    fToast.showToast(
      child: Container(
          width: 300,
          height: 120,
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
    Future.microtask(() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          fToast = FToast();
          fToast.init(context);
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QrManageViewModel>();
    final state = viewModel.state;
    final selectButtonWidth = MediaQuery.of(context).size.width < 500
        ? (MediaQuery.of(context).size.width - 40) / 5
        : (500 - 40) / 5;
    double dateContainerWidth =
        MediaQuery.of(context).size.width < 500 ? 140 : 170;

    return SingleChildScrollView(
      controller: scrollController,
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
                      '결제 QR 관리',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.setQrManageCalendarSelectState(
                                          !state.isQrManageCalendarSelected,
                                          true);
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
                                            state.qrManageStartDay == null
                                                ? '시작일'
                                                : DateFormat('yyyy-MM-dd')
                                                    .format(state
                                                        .qrManageStartDay!),
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
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.setQrManageCalendarSelectState(
                                          !state.isQrManageCalendarSelected,
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
                                            state.qrManageEndDay == null
                                                ? '종료일'
                                                : DateFormat('yyyy-MM-dd')
                                                    .format(
                                                        state.qrManageEndDay!),
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
                          if (state.isQrManageCalendarSelected)
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
                            if (state.qrManageStartDay != null) {
                              start = DateFormat('yyyy-MM-dd')
                                  .format(state.qrManageStartDay!);
                            }
                            if (state.qrManageEndDay != null) {
                              end = DateFormat('yyyy-MM-dd')
                                  .format(state.qrManageEndDay!);
                            }
                            bool res =
                                await viewModel.searchQrInfoList(start, end);

                            if (!res) {
                              _showToast(
                                  '데이터를 가져오는데 실패 했습니다.\n다시 로그인 해보시길 바랍니다.');
                            }
                          },
                          child: const Text('검색'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.resetQrManage();
                            setState(() {
                              startDateNotSelect = '';
                              endDateNotSelect = '';
                            });
                          },
                          child: const Text('초기화'),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(
                        color: Colors.white54,
                        height: 1,
                      ),
                    ),
                    (state.isLoadingQrManageSearch == false)
                        ? (state.qrInfoList.isNotEmpty)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('사용 중단'),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('다시 사용'),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // viewModel.setCalendarSelectState(
                                          //     false, CalendarType.qrCreate);
                                          // viewModel.setSelectedDay(null);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateQrWidget(),
                                            ),
                                          );
                                        },
                                        child: const Text('신규 등록'),
                                      ),
                                    ],
                                  ),
                                  ...state.qrInfoList
                                      .map(
                                        (e) => QrInfoListWidget(
                                          data: e,
                                        ),
                                      )
                                      .toList(),
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
