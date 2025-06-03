import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction_provider.dart';
import '../wallet/models/transaction.dart' ;



class StatisticsBar extends StatelessWidget {
  const StatisticsBar({
    Key? key,
    required this.kind,
    required this.range,
    required this.color,
  }) : super(key: key);

  final TxKind kind;
  final StatsRange range;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    final eData = provider.grouped(kind: TxKind.expense, range: range);
    final iData = provider.grouped(kind: TxKind.income,  range: range);

    final groups = <BarChartGroupData>[];
    int x = 0;
    eData.forEach((d, eVal) {
      final iVal = iData[d] ?? 0;
      groups.add(
        BarChartGroupData(
          x: x++,
          barRods: [
            BarChartRodData(
              toY: eVal,
              width: 8,
              color: kind == TxKind.expense ? Colors.black : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(3),
            ),
        BarChartRodData(
          toY: iVal,
          width: 8,
          color: kind == TxKind.income ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
      barsSpace: 6,
    ),
  );
});

final allVals = [...eData.values, ...iData.values];
final rawMax = (allVals.isEmpty ? 0 : allVals.reduce((a, b) => a > b ? a : b));
final maxY = (rawMax < 5000 ? 5000 : rawMax).toDouble();

return BarChart(
  BarChartData(
    minY: 0,
    maxY: maxY,
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      horizontalInterval: 1000,
      getDrawingHorizontalLine: (idx) =>
          FlLine(color: Colors.grey.shade300, strokeWidth: 1),
    ),
    borderData: FlBorderData(show: false),
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1000,
          reservedSize: 32,
          getTitlesWidget: (value, _) {
            final intK = (value ~/ 1000);
            return Text(
              '${intK}k',
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (double value, TitleMeta meta) {
            final int index = value.toInt();
            if (index < 0 || index >= eData.keys.length) return const SizedBox();
            final dt = eData.keys.elementAt(index);
            return Text(
              _label(dt, range),
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
    ),
    barGroups: groups,
  ),
  duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  
}
  String _label(DateTime d, StatsRange r) {
    switch (r) {
      case StatsRange.day:
        final hr = d.hour;
        return (hr % 4 == 0) ? '${hr}:00 ' : '';

      case StatsRange.week:
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d.weekday - 1];

      case StatsRange.month:
        return [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ][d.month - 1];

      case StatsRange.year:
        return '${d.year}';
    }
  }
}
