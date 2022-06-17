import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:instapay_admin/domain/model/calc_history/tras_info.dart';

class TrasDetailHistoryTableWidget extends StatelessWidget {
  final List<TrasInfo> info;

  const TrasDetailHistoryTableWidget({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 5,
      minWidth: 750,
      columns: [
        DataColumn2(
          fixedWidth: 50,
          label: const Center(
            child: Text(
              '구분',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 110,
          label: const Center(
            child: Text(
              '승인 일자',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 70,
          label: const Center(
            child: Text(
              '거래 금액',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 70,
          label: const Center(
            child: Text(
              '결제 수단',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 50,
          label: const Center(
            child: Text(
              '수수료',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 50,
          label: const Center(
            child: Text(
              'VAT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 70,
          label: const Center(
            child: Text(
              '정산 금액',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 110,
          label: Center(
            child: Text(
              '이용자',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: 75,
          label: const Center(
            child: Text(
              '결제 내용',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      rows: [
        // DataRow2(
        //   cells: [
        //     const DataCell(Center(child: Text("승인"))),
        //     DataCell(Center(
        //         child: Text(
        //             '${state.trasHistory?.summary?.complete?.count ?? ''}'))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.complete?.paymentAmount ??
        //                 0)))),
        //     DataCell(Center(child: Text(currencyFormat(0)))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.complete?.paymentAmount ??
        //                 0)))),
        //   ],
        // ),
        // DataRow2(
        //   cells: [
        //     const DataCell(Center(child: Text('취소'))),
        //     DataCell(Center(
        //         child: Text(
        //             '${state.trasHistory?.summary?.canceled?.count ?? ''}'))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.canceled?.paymentAmount ??
        //                 0)))),
        //     DataCell(Center(child: Text(currencyFormat(0)))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.canceled?.paymentAmount ??
        //                 0)))),
        //   ],
        // ),
        // DataRow2(
        //   cells: [
        //     const DataCell(Center(child: Text('보류'))),
        //     DataCell(Center(
        //         child: Text(
        //             '${state.trasHistory?.summary?.notpaid?.count ?? ''}'))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.notpaid?.paymentAmount ?? 0)))),
        //     DataCell(Center(child: Text(currencyFormat(0)))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.notpaid?.paymentAmount ?? 0)))),
        //   ],
        // ),
        // DataRow2(
        //   cells: [
        //     const DataCell(Center(child: Text('합계'))),
        //     DataCell(Center(
        //         child:
        //             Text('${state.trasHistory?.summary?.total?.count ?? ''}'))),
        //     const DataCell(Center(child: Text(''))),
        //     const DataCell(Center(child: Text(''))),
        //     DataCell(Center(
        //         child: Text(currencyFormat(
        //             state.trasHistory?.summary?.total?.paymentAmount ?? 0)))),
        //   ],
        // ),
      ],
    );


  }
}
