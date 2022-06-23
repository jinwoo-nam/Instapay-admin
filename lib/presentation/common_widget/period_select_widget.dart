import 'package:flutter/material.dart';

enum PeriodSelectType {
  today,
  week,
  oneMonth,
  twoMonth,
  threeMonth,
}

final periodSelect = [
  PeriodSelectData(title: '당일', type: PeriodSelectType.today),
  PeriodSelectData(title: '일주일', type: PeriodSelectType.week),
  PeriodSelectData(title: '1개월', type: PeriodSelectType.oneMonth),
  PeriodSelectData(title: '2개월', type: PeriodSelectType.twoMonth),
  PeriodSelectData(title: '3개월', type: PeriodSelectType.threeMonth),
];

class PeriodSelectWidget extends StatelessWidget {
  final double selectButtonWidth;
  final PeriodSelectData data;

  const PeriodSelectWidget({
    Key? key,
    required this.selectButtonWidth,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
      ),
      padding: const EdgeInsets.all(6),
      width: selectButtonWidth,
      height: 40,
      alignment: Alignment.center,
      child: Text(data.title, textAlign: TextAlign.center),
    );
  }
}

class PeriodSelectData {
  final String title;
  final PeriodSelectType type;

  PeriodSelectData({
    required this.title,
    required this.type,
  });
}
