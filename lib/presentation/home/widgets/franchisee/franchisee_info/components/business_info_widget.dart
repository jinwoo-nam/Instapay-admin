import 'package:flutter/material.dart';

class BusinessInfoWidget extends StatelessWidget {
  const BusinessInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(
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
                  '장나라 팬클럽',
                  style: TextStyle(
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
                  '구분',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '개인 사업자',
                  style: TextStyle(
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
                  '대표자명',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '배재광',
                  style: TextStyle(
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
                  '사업자번호',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '1122111080',
                  style: TextStyle(
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
                  'ID',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'yuki@instapay.kr',
                  style: TextStyle(
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
                  '계약일자',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '2017-05-17 15:25:33',
                  style: TextStyle(
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
                  '업종',
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(
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
                  '서울 특별시 강남구 영동대로 85길 38 진성빌딩',
                  style: TextStyle(
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
                  '정산계좌',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '우리은행 1005503862118',
                  style: TextStyle(
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
                  '예금주',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '배재광',
                  style: TextStyle(
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
                  '',
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