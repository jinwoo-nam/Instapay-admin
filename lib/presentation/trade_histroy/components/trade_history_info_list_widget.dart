import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/tras/tras_info.dart';

class TradeHistoryInfoListWidget extends StatelessWidget {
  final TrasInfo info;

  const TradeHistoryInfoListWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              '결제건명',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              info.productName!,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              const Text(
                '이용자명',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                info.payerName!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              const Text(
                '결제금액',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                info.paymentAmount!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              const Text(
                '결제기관',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                info.bankName!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              const Text(
                '주문번호',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Text(
                  info.orderNo!,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              const Text(
                '결제일시',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                info.adate!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Divider(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
