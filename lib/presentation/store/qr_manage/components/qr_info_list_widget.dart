import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/store/goods.dart';
import 'package:instapay_admin/presentation/store/qr_manage/components/qr_info_detail_widget.dart';
import 'package:instapay_admin/ui/color.dart';
import 'package:instapay_admin/util/util.dart';

class QrInfoListWidget extends StatefulWidget {
  final Goods data;

  const QrInfoListWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<QrInfoListWidget> createState() => _QrInfoListWidgetState();
}

class _QrInfoListWidgetState extends State<QrInfoListWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    String expireDate = '';
    String qrState = '';
    if (widget.data.ldate == null) {
      qrState = '사용중';
      expireDate = 'always';
    } else {
      if (widget.data.ldate!.isEmpty) {
        qrState = '사용중';
        expireDate = 'always';
      } else {
        expireDate = widget.data.ldate!;
        int year = int.parse(widget.data.ldate!.substring(0, 4));
        int month = int.parse(widget.data.ldate!.substring(5, 7));
        int day = int.parse(widget.data.ldate!.substring(8, 10));
        int hour = int.parse(widget.data.ldate!.substring(11, 13));
        int min = int.parse(widget.data.ldate!.substring(14, 16));
        int sec = int.parse(widget.data.ldate!.substring(17, 19));
        DateTime temp = DateTime(year, month, day, hour, min, sec);

        Duration duration = temp.difference(DateTime.now());
        if (duration.inDays < 0) {
          qrState = '사용 중단';
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
              value: isSelected,
              onChanged: (checked) {
                setState(() {
                  if (checked != null) {
                    isSelected = checked;
                  }
                });
              }),
          Expanded(
            child: InkWell(
              onTap: () {
                // viewModel.setCalendarSelectState(false, CalendarType.qrDetail);
                // viewModel.setSelectedDay(null);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrInfoDetailWidget(
                      data: widget.data,
                    ),
                  ),
                );
              },
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
                          child: Text(widget.data.gname!),
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
                          child: Text(
                              currencyFormat(int.parse(widget.data.price!))),
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
                          child: Text(expireDate),
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
                          child: Text(widget.data.adate!),
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
                          child: Text(qrState),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
