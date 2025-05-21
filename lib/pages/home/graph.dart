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
    final data =
        context.select<TransactionProvider, Map<DateTime, double>>((p) =>
            p.grouped(kind: kind, range: range));

    final groups = <BarChartGroupData>[];
    int idx = 0;
    data.entries.forEach((e) {
      groups.add(BarChartGroupData(
        x: idx++,
        barsSpace: 2,
        barRods: [
          BarChartRodData(
            toY: e.value,
            color: color,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ));
    });

    final maxY = data.values.isEmpty ? 10 : data.values.reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxY * 1.15,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (v, _) => Text(
                _label(data.keys.elementAt(v.toInt()), range),
                style: const TextStyle(fontSize: 11),
              ),
            ),
          ),
        ),
        barGroups: groups,
      ),
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeOutCubic,
    );
  }

  String _label(DateTime d, StatsRange r) {
    switch (r) {
      case StatsRange.day:
        return d.hour.toString();
      case StatsRange.week:
        return ['M','T','W','T','F','S','S'][d.weekday - 1];
      case StatsRange.month:
        return d.day.toString();
      case StatsRange.year:
        return ['J','F','M','A','M','J','J','A','S','O','N','D'][d.month - 1];
    }
  }
}
