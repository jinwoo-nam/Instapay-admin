import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:instapay_admin/presentation/tras_history/tras_history_state.dart';
import 'package:instapay_admin/util/util.dart';

class TrasSummaryTableWidget extends StatelessWidget {
  const TrasSummaryTableWidget({
    Key? key,
    required this.dataTableWidth,
    required this.state,
  }) : super(key: key);

  final double dataTableWidth;
  final TrasHistoryState state;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 5,
      minWidth: dataTableWidth,
      columns: [
        DataColumn2(
          fixedWidth: dataTableWidth * 8 / 100,
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
          fixedWidth: dataTableWidth * 13.5 / 100,
          label: const Center(
            child: Text(
              '건수',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: dataTableWidth * 22.5 / 100,
          label: const Center(
            child: Text(
              '금액',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: dataTableWidth * 20 / 100,
          label: const Center(
            child: Text(
              '수수료/VAT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataColumn2(
          fixedWidth: dataTableWidth * 20 / 100,
          label: const Center(
            child: Text(
              '정산액',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      rows: [
        DataRow2(
          cells: [
            const DataCell(Center(child: Text("승인"))),
            DataCell(Center(
                child: Text(
                    '${state.trasHistory?.summary?.complete?.count ?? ''}'))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.complete?.paymentAmount ??
                        0)))),
            DataCell(Center(child: Text(currencyFormat(0)))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.complete?.paymentAmount ??
                        0)))),
          ],
        ),
        DataRow2(
          cells: [
            const DataCell(Center(child: Text('취소'))),
            DataCell(Center(
                child: Text(
                    '${state.trasHistory?.summary?.canceled?.count ?? ''}'))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.canceled?.paymentAmount ??
                        0)))),
            DataCell(Center(child: Text(currencyFormat(0)))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.canceled?.paymentAmount ??
                        0)))),
          ],
        ),
        DataRow2(
          cells: [
            const DataCell(Center(child: Text('보류'))),
            DataCell(Center(
                child: Text(
                    '${state.trasHistory?.summary?.notpaid?.count ?? ''}'))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.notpaid?.paymentAmount ?? 0)))),
            DataCell(Center(child: Text(currencyFormat(0)))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.notpaid?.paymentAmount ?? 0)))),
          ],
        ),
        DataRow2(
          cells: [
            const DataCell(Center(child: Text('합계'))),
            DataCell(Center(
                child:
                Text('${state.trasHistory?.summary?.total?.count ?? ''}'))),
            const DataCell(Center(child: Text(''))),
            const DataCell(Center(child: Text(''))),
            DataCell(Center(
                child: Text(currencyFormat(
                    state.trasHistory?.summary?.total?.paymentAmount ?? 0)))),
          ],
        ),
      ],
    );
  }
}
