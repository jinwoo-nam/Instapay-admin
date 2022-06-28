import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';

class TrasHistoryTableHeader extends StatelessWidget {
  const TrasHistoryTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                '구분',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 2,
          child: Center(
              child: Text(
                '승인일자',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                '거래금액',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                '결제수단',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                '수수료',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                'VAT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                '정산금액',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 2,
          child: Center(
              child: Text(
                '이용자',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
                '결제내용',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ],
    );
  }
}

class TrasHistoryTableBody extends StatelessWidget {
  final TrasInfo info;

  const TrasHistoryTableBody({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    info.tstatus ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                    child: Text(
                      info.adate ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      info.paymentAmount ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      info.paymentMethods ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              const Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      info.paymentAmount ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              Expanded(
                flex: 2,
                child: Center(
                    child: Text(
                      info.payerName ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
              Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                      info.productName ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
