import 'package:flutter/material.dart';

import "../../pages/wallet/models/transaction.dart";

enum StatsRange { day, week, month, year }


extension on DateTime {
  DateTime get justDate => DateTime(year, month, day);
  DateTime get firstDayOfWeek => justDate.subtract(Duration(days: weekday - 1));
  DateTime get firstDayOfMonth => DateTime(year, month);


  DateTime get firstDayOfYear => DateTime(year);
}


class TransactionProvider  extends ChangeNotifier {
  final List<Transaction> items = [];

  List<Transaction> mostRecent([int max = 10]) {
    final copy = [...items]..sort((a,b) => b.date.compareTo(a.date));  
    
    return copy.take(max).toList(); 

  }

  Map<DateTime, double> grouped({
    required TxKind kind, 
    required StatsRange range, 

  }) {
    final now = DateTime.now(); 
    DateTime Function(DateTime) bucketStart; 
    int bucketCount; 

    switch (range) {
      case StatsRange.day:
        bucketStart = (d) => d.justDate;
        bucketCount = 24;   
        break;
      case StatsRange.week:
        bucketStart = (d) => d.firstDayOfWeek;
        bucketCount = 7;
        break;
      case StatsRange.month:
        bucketStart = (d) => d.firstDayOfMonth;
        bucketCount = DateUtils.getDaysInMonth(now.year, now.month);
        break;
      case StatsRange.year:
        bucketStart = (d) => d.firstDayOfYear;
        bucketCount = 12;
        break;
    }

    final Map<DateTime, double> out = {
      for (int i = 0; i < bucketCount; i++)
        _bucketLabelStart(now, i, range): 0
      
    };

    for (final item in items.where((item) => item.kind == kind)) {
      final k = bucketStart(item.date);
      if (out.containsKey(k)) out[k] = out[k]! + item.amount; 
    }

    return out; 






  }
     
  Map<DateTime, List<Transaction>> byMonth() {
    final now = DateTime.now(); 

    final m = <DateTime, List<Transaction>>{
      for (int i = 0; i < 6; i++)
        DateTime(now.year, now.month - i): <Transaction>[], 
    };





    for (final item in items)
    {
      final key = DateTime(item.date.year, item.date.month);
      m.putIfAbsent(key, () => []).add(item); 
    }

    for (final list in m.values)
    {
      list.sort((a,b) => b.date.compareTo(a.date));
    }
    return m;
  }


  DateTime _bucketLabelStart(DateTime base, int offset, StatsRange r) {
    switch (r) {
      case StatsRange.day:
        return DateTime(base.year, base.month, base.day, offset);
      case StatsRange.week:
        return base.firstDayOfWeek.add(Duration(days: offset));
      case StatsRange.month:
        return DateTime(base.year, base.month, offset + 1);
      case StatsRange.year:
        return DateTime(base.year, offset + 1);
    }
  }


  void add(Transaction item)
  {
    items.add(item);

    notifyListeners(); 

  }



}



