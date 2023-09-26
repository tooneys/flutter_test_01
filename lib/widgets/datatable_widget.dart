import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_01/models/order.dart';
import 'package:intl/intl.dart';

var numberF = NumberFormat('###,###,###');

class DataTableWidget extends StatelessWidget {
  final List<OrderAnanlys> data;
  const DataTableWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return dtAnalysis();
  }

  Widget dtAnalysis() {
    var resultCol = [
      const DataColumn2(
        label: Text('일자'),
        size: ColumnSize.M,
      ),
      const DataColumn2(
        label: Text('주문금액'),
        numeric: true,
        size: ColumnSize.L,
      ),
      const DataColumn2(
        label: Text('결제금액'),
        numeric: true,
        size: ColumnSize.L,
      ),
      const DataColumn2(
        label: Text('할인금액'),
        numeric: true,
        size: ColumnSize.L,
      ),
    ];

    var resultRow = data.map((e) {
      return DataRow(
        cells: [
          DataCell(Text(e.dailyDate.toString())),
          DataCell(Text(numberF.format(e.orderAmt))),
          DataCell(Text(numberF.format(e.paidAmt))),
          DataCell(Text(numberF.format(e.discountAmt))),
        ],
      );
    }).toList();

    return SizedBox(
      child: DataTable2(
        columnSpacing: 20,
        horizontalMargin: 12,
        minWidth: 500,
        columns: resultCol,
        rows: resultRow,
      ),
    );
  }
}
