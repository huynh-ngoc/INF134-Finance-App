// lib/pages/models/transaction_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import "../../pages/wallet/models/transaction.dart";

enum StatsRange { day, week, month, year }

extension on DateTime {
  DateTime get justDate => DateTime(year, month, day);

  DateTime get firstDayOfWeek =>
      justDate.subtract(Duration(days: weekday - DateTime.monday));

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  DateTime get firstDayOfYear => DateTime(year, 1, 1);
}

class TransactionProvider extends ChangeNotifier {
  final List<Transaction> items = [];

  List<Transaction> mostRecent([int max = 10]) {
    final copy = [...items]..sort((a, b) => b.date.compareTo(a.date));
    return copy.take(max).toList();
  }

  void add(Transaction item) {
    items.add(item);
    notifyListeners();
  }


  Map<DateTime, double> grouped({
    required TxKind kind,
    required StatsRange range,
  }) {
    final now = DateTime.now();
    final Map<DateTime, double> out = {};

    switch (range) {
      case StatsRange.day:
        final dayStart = DateTime(now.year, now.month, now.day);
        for (int h = 0; h < 24; h++) {
          out[dayStart.add(Duration(hours: h))] = 0;
        }
        break;

      case StatsRange.week:
        final monday = now.firstDayOfWeek;
        for (int d = 0; d < 7; d++) {
          out[monday.add(Duration(days: d))] = 0;
        }
        break;

      case StatsRange.month:
        final year = now.year;
        for (int m = 1; m <= 12; m++) {
          out[DateTime(year, m, 1)] = 0;
        }
        break;

      case StatsRange.year:
        final baseYear = now.year - 5;
        for (int i = 0; i < 6; i++) {
          out[DateTime(baseYear + i, 1, 1)] = 0;
        }
        break;
    }

    for (final item in items.where((t) => t.kind == kind)) {
      late DateTime bucketKey;
      switch (range) {
        case StatsRange.day:
        
          bucketKey = DateTime(
            item.date.year,
            item.date.month,
            item.date.day,
            item.date.hour,
          );
          break;

        case StatsRange.week:
          final mon = item.date.firstDayOfWeek;
          bucketKey = DateTime(mon.year, mon.month, mon.day);
          break;

        case StatsRange.month:
          bucketKey = DateTime(item.date.year, item.date.month, 1);
          break;

        case StatsRange.year:
          bucketKey = DateTime(item.date.year, 1, 1);
          break;
      }

      if (out.containsKey(bucketKey)) {
        out[bucketKey] = out[bucketKey]! + item.amount;
      }
    }

    return out;
  }

  Map<DateTime, List<Transaction>> byMonth() {
    final now = DateTime.now();

    final Map<DateTime, List<Transaction>> m = {
      for (int i = 0; i < 6; i++)
        DateTime(now.year, now.month - i): <Transaction>[],
    };

    for (final item in items) {
      final key = DateTime(item.date.year, item.date.month);
      if (!m.containsKey(key)) {
   
      } else {
        m[key]!.add(item);
      }
    }

    for (final sublist in m.values) {
      sublist.sort((a, b) => b.date.compareTo(a.date));
    }

    return m;
  }
}
