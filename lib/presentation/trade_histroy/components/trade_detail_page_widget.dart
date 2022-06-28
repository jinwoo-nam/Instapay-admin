import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';
import 'package:instapay_admin/responsive/responsive.dart';

class TradeDetailPageWidget extends StatefulWidget {
  final TrasInfo info;

  const TradeDetailPageWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<TradeDetailPageWidget> createState() => _TradeDetailPageWidgetState();
}

class _TradeDetailPageWidgetState extends State<TradeDetailPageWidget> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double mainWidth;
    if (Responsive.isMobile(context)) {
      mainWidth = 500;
    } else if (Responsive.isTablet(context)) {
      mainWidth = 750;
    } else {
      mainWidth = 1000;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('거래 상세 내역'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          width: mainWidth,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text(
                      '거래 ID : ${widget.info.orderNo ?? ''}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    '주문 정보',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Text(
                              '가맹점명',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                widget.info.payerName ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Text(
                              '주문 번호',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                widget.info.orderNo ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
