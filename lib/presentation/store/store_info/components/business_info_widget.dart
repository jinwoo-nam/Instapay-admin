import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/store/store.dart';

class BusinessInfoWidget extends StatelessWidget {
  final Store store;
  final String userId;

  const BusinessInfoWidget({
    Key? key,
    required this.store,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '가맹점명',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.sname,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '구분',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.info?.stype ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '대표자명',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.info?.ceo ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '사업자번호',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.info?.biz ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  userId,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '계약일자',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.adate,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '업종',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.info?.industry ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '주소지',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '${store.juso?.fixed ?? ''} ${store.juso?.user ?? ''} ${store.juso?.zip ?? ''}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '정산계좌',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '${store.adjust?.bank ?? ''} ${store.adjust?.account ?? ''}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  '예금주',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.info?.ceo ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  '거래 형태',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '--',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Colors.white54,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
