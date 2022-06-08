import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/franchisee/qr_manage/components/create_qr_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/period_select_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QrManageWidget extends StatelessWidget {
  const QrManageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<QrCodeInfo> qrInfoList = [
      QrCodeInfo(
        title: 'AAA',
        price: 100,
        expireDate: '2022-06-02 16:43:38',
        createDate: '2022-06-02 16:43:38',
        state: '중단',
      ),
      QrCodeInfo(
        title: 'BBB',
        price: 100,
        expireDate: '2022-06-02 16:43:38',
        createDate: '2022-06-02 16:43:38',
        state: '중단',
      ),
    ];

    final periodSelect = [
      PeriodSelectData(title: '당일', type: PeriodSelectType.today),
      PeriodSelectData(title: '일주일', type: PeriodSelectType.week),
      PeriodSelectData(title: '1개월', type: PeriodSelectType.oneMonth),
      PeriodSelectData(title: '2개월', type: PeriodSelectType.twoMonth),
      PeriodSelectData(title: '3개월', type: PeriodSelectType.threeMonth),
    ];
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    final selectButtonWidth = (MediaQuery.of(context).size.width - 40) / 5;

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
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('중단 하기'),
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
                        viewModel.setSelectedDay(null);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateQrWidget(),
                          ),
                        );
                      },
                      child: const Text('신규 등록'),
                    ),
                  ],
                ),
                ...qrInfoList
                    .map(
                      (e) => QrInfoListWidget(
                        data: e,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QrCodeInfo {
  final String title;
  final int price;
  final String expireDate;
  final String createDate;
  final String state;
  bool isSelected;

  QrCodeInfo({
    required this.title,
    required this.price,
    required this.expireDate,
    required this.createDate,
    required this.state,
    this.isSelected = false,
  });
}

class QrInfoListWidget extends StatefulWidget {
  final QrCodeInfo data;
  final Function(bool)? onPress;

  const QrInfoListWidget({
    Key? key,
    required this.data,
    this.onPress,
  }) : super(key: key);

  @override
  State<QrInfoListWidget> createState() => _QrInfoListWidgetState();
}

class _QrInfoListWidgetState extends State<QrInfoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
              value: widget.data.isSelected,
              onChanged: (checked) {
                setState(() {
                  widget.data.isSelected = !widget.data.isSelected;
                });
              }),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text('결제건명'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(widget.data.title),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('결제금액'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text('${widget.data.price}'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('유효기간'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(widget.data.expireDate),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('생성일시'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(widget.data.createDate),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('상태'),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(widget.data.state),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
