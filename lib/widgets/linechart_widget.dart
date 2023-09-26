import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_01/models/order.dart';
import 'package:flutter_test_01/utils/constants.dart';

class LineChartWidget extends StatelessWidget {
  final List<OrderAnanlys> data;
  const LineChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      duration: const Duration(milliseconds: 250),
      LineChartData(
        backgroundColor: Colors.lime[100],
        titlesData: titleData,
        lineBarsData: [orderData, paidData, discountData],
        minX: 0,
        minY: 0,
        maxX: data.length.toDouble(),
      ),
    );
  }

  FlTitlesData get titleData => const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, reservedSize: 32, interval: 5),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, reservedSize: 32, interval: 60000000),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  LineChartBarData get orderData => LineChartBarData(
        spots: data
            .map((point) => FlSpot(
                double.parse(point.dailyDate.substring(6, 8)), point.orderAmt))
            .toList(),
        isCurved: true,
        dotData: const FlDotData(show: true),
        color: AppColors.contentColorCyan,
        show: true,
        showingIndicators: [1, 2],
      );

  LineChartBarData get paidData => LineChartBarData(
        spots: data
            .map((point) => FlSpot(
                double.parse(point.dailyDate.substring(6, 8)), point.paidAmt))
            .toList(),
        isCurved: true,
        dotData: const FlDotData(show: true),
        color: AppColors.contentColorOrange,
        barWidth: 5,
        show: true,
        showingIndicators: [1, 3],
      );

  LineChartBarData get discountData => LineChartBarData(
        spots: data
            .map((point) => FlSpot(
                double.parse(point.dailyDate.substring(6, 8)),
                point.discountAmt))
            .toList(),
        isCurved: true,
        dotData: const FlDotData(show: true),
        color: AppColors.contentColorRed,
        show: true,
        showingIndicators: [1, 4],
      );
}
