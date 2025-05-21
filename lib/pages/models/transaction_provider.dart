import 'package:flutter/material.dart';

import "../../pages/wallet/models/transaction.dart";


class TransactionProvider  extends ChangeNotifier {
  final List<Transaction> items = [];

  List<Transaction> mostRecent([int max = 10]) {
    final copy = [...items]..sort((a,b) => b.date.compareTo(a.date));  
    
    return copy.take(max).toList(); 



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

  void add(Transaction item)
  {
    items.add(item);

    notifyListeners(); 

  }



}



