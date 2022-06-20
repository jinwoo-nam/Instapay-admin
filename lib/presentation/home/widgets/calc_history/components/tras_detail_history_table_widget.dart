import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';
import 'package:instapay_admin/ui/color.dart';

class TrasDetailHistoryTableWidget extends StatefulWidget {
  final List<TrasInfo> info;
  final int totalCount;
  final int selectedCount;

  const TrasDetailHistoryTableWidget({
    Key? key,
    required this.info,
    required this.totalCount,
    required this.selectedCount,
  }) : super(key: key);

  @override
  State<TrasDetailHistoryTableWidget> createState() =>
      _TrasDetailHistoryTableWidgetState();
}

class _TrasDetailHistoryTableWidgetState
    extends State<TrasDetailHistoryTableWidget> {
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    final int count = (widget.totalCount / widget.selectedCount).ceil();

    return Column(
      children: [
        DataTable2(
          columnSpacing: 5,
          minWidth: 750,
          columns: const [
            DataColumn2(
              fixedWidth: 75,
              label: Center(
                child: Text(
                  '구분',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 90,
              label: Center(
                child: Text(
                  '승인 일자',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 70,
              label: Center(
                child: Text(
                  '거래 금액',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 70,
              label: Center(
                child: Text(
                  '결제 수단',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 45,
              label: Center(
                child: Text(
                  '수수료',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 40,
              label: Center(
                child: Text(
                  'VAT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 60,
              label: Center(
                child: Text(
                  '정산 금액',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 100,
              label: Center(
                child: Text(
                  '이용자',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            DataColumn2(
              fixedWidth: 55,
              label: Center(
                child: Text(
                  '결제 내용',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
          rows: widget.info.map((e) {
            return DataRow2(
              cells: [
                DataCell(Center(
                    child: Text(
                  e.tstatus ?? '',
                  style: const TextStyle(fontSize: 13),
                ))),
                DataCell(Center(
                    child: Text(
                  e.adate ?? '',
                  style: const TextStyle(fontSize: 12),
                ))),
                DataCell(Center(child: Text(e.paymentAmount ?? ''))),
                DataCell(Center(child: Text(e.paymentMethods ?? ''))),
                const DataCell(Center(child: Text('0'))),
                const DataCell(Center(child: Text('0'))),
                DataCell(Center(child: Text(e.paymentAmount ?? ''))),
                DataCell(Center(
                    child: Text(
                  e.payerName ?? '',
                  style: const TextStyle(fontSize: 12),
                ))),
                DataCell(Center(child: Text(e.productName ?? ''))),
              ],
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: bgColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: const Text('<<'),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (curIndex > 0) {
                      curIndex -= 1;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: bgColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: const Text('<'),
                ),
              ),
              for (int i = 0; i < count; i++)
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: (i == curIndex) ? pointColor : null,
                      border: Border.all(color: bgColor),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: Text('${i + 1}'),
                  ),
                ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (curIndex < count - 1) {
                      curIndex += 1;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: bgColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: const Text('>'),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: bgColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: const Text('>>'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
              'Showing 1 to ${widget.selectedCount} of ${widget.totalCount} records'),
        ),
      ],
    );
  }
}
