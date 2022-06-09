import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/trade_history/payment_complete_info.dart';

class TradeHistoryInfoListWidget extends StatelessWidget {
  final PaymentCompleteInfo paymentInfo;

  const TradeHistoryInfoListWidget({
    Key? key,
    required this.paymentInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
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
                paymentInfo.title,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
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
                paymentInfo.userName,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
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
                '${paymentInfo.price}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
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
                paymentInfo.paymentInstitution,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
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
              Text(
                paymentInfo.orderNumber,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
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
                paymentInfo.paymentDateTime,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white,
        )
      ],
    );
  }
}