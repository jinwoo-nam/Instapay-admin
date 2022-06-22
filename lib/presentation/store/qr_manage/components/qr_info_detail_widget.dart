import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instapay_admin/domain/model/franchisee/qr_code_info.dart';
import 'package:instapay_admin/presentation/common_widget/calendar_widget.dart';
import 'package:instapay_admin/presentation/store/qr_manage/qr_manage_view_model.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QrInfoDetailWidget extends StatefulWidget {
  final QrCodeInfo data;

  const QrInfoDetailWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<QrInfoDetailWidget> createState() => _QrInfoDetailWidgetState();
}

class _QrInfoDetailWidgetState extends State<QrInfoDetailWidget> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QrManageViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR코드 상세'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
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
                        const Text('상품 이름'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: secondaryColor,
                                ),
                                child: Text(widget.data.title),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('상품 가격'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: secondaryColor,
                                ),
                                child: Text('${widget.data.price} 원'),
                              ),
                            ),
                          ],
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // viewModel.setCalendarSelectState(
                                    //     !state.isQrDetailCalendarSelected,
                                    //     CalendarType.qrDetail);
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
                                          state.qrDetailEndDay == null
                                              ? '종료일'
                                              : DateFormat('yyyy-MM-dd').format(
                                                  state.qrDetailEndDay!),
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
                              const Text('24:00 까지 유효합니다.'),
                              Text(
                                widget.data.expireDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        if (state.isQrDetailCalendarSelected)
                          const CalendarWidget(),
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
                            child: const Text('유효기간 수정하기'),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.white,
                            )),
                            width: 250,
                            height: 250,
                            child: const Center(
                              child: Text('qr'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize:
                                    const Size(120, 40), //width, height
                              ),
                              onPressed: () {},
                              child: const Text('다운로드'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize:
                                    const Size(120, 40), //width, height
                              ),
                              onPressed: () {},
                              child: const Text('소스보기'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize:
                                    const Size(120, 40), //width, height
                              ),
                              onPressed: () {},
                              child: const Text('복사하기'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
