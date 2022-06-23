import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/common_widget/period_select_widget.dart';

const String loginBaseUrl = 'https://api.instapay.kr/s1/login';
const String storeBaseUrl = 'https://api.instapay.kr/s1/store';
const String trasBaseUrl = 'https://api.instapay.kr/s1/tras';
const String loginAid = 'd20ah-ol17w-03p30-15b05-e05dc';
GlobalKey globalKey = GlobalKey();

final periodSelect = [
  PeriodSelectData(title: '당일', type: PeriodSelectType.today),
  PeriodSelectData(title: '일주일', type: PeriodSelectType.week),
  PeriodSelectData(title: '1개월', type: PeriodSelectType.oneMonth),
  PeriodSelectData(title: '2개월', type: PeriodSelectType.twoMonth),
  PeriodSelectData(title: '3개월', type: PeriodSelectType.threeMonth),
];