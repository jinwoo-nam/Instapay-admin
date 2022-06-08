import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/presentation/home/home_state.dart';
import 'package:instapay_admin/presentation/home/home_view_model.dart';
import 'package:instapay_admin/presentation/home/widgets/trade_history/components/calendar_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateQrWidget extends StatefulWidget {
  const CreateQrWidget({Key? key}) : super(key: key);

  @override
  State<CreateQrWidget> createState() => _CreateQrWidgetState();
}

class _CreateQrWidgetState extends State<CreateQrWidget> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('결제 QR코드 만들기'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('상품 이름'),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: '한글, 영문, 숫자, (), [], _ 만 사용 64자 이내',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('상품 가격'),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'KRW(숫자만 허용)',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '0 INC',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('유효기간'),
                    Row(
                      children: [
                        Checkbox(
                            value: check,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  check = value;
                                }
                              });
                            }),
                        const Text('설정하기'),
                      ],
                    ),
                    if (check)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                viewModel.setCalendarSelectState(
                                    !state.isCalendarSelected,
                                    PeriodType.qrManage);
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
                                      state.qrManageEndDay == null
                                          ? '종료일'
                                          : DateFormat('yyyy-MM-dd')
                                              .format(state.qrManageEndDay!),
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
                          const Text('등록된 상품 목록에서 언제든지 이용정지 할 수 있습니다.'),
                          const Text('24:00 까지 유효합니다.'),
                        ],
                      ),
                    if (state.isCalendarSelected) const CalendarWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(120, 40), //width, height
                        ),
                        onPressed: () {},
                        child: const Text('QR 생성하기'),
                      ),
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
