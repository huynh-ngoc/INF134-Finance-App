import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction_provider.dart';
import 'package:intl/intl.dart';


import 'widgets/transaction_title.dart';
import 'widgets/add_transaction_form.dart';

import 'models/transaction.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>(); 

    final months = provider.byMonth(); 
    final now = DateTime.now(); 
    final keys = List<DateTime>.generate(
      13,
      (i) => DateTime(now.year, now.month - 6 + i),
    )..sort();


    return DefaultTabController(
      initialIndex: 6,
      length: keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),


          bottom: TabBar(
            isScrollable: true,
            tabs: [for (final k in keys) Tab(text: label(k))],


          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => AddTransactionForm(onTransactionAdded: () {}),
          ),
        ),
        body: TabBarView(
          children: [
            for (final key in keys)
              MonthList(items: months[key] ?? const [], date: key),
          ],
        ),
      ),
    );
  }

  String label(DateTime d) =>
      '${month[d.month - 1]}${DateTime.now().year == d.year ? '' : ' ${d.year}'}';

  static const month =
      ['Jan', 
      'Feb',
       'Mar',
       'Apr',
       'May', 
       'Jun',
        'Jul',
       'Aug',
    'Sep',
       'Oct',
    'Nov',
     'Dec'];
}

class MonthList extends StatelessWidget {
  const MonthList({required this.items, required this.date});

  final List<Transaction> items;
  
  final DateTime date; 

  @override
  Widget build(BuildContext context) 
  {


    final Map<String, List<Transaction>> byDay = {};

    for (final t in items) 
    {
      final k = _dayLabel(t.date);
      byDay.putIfAbsent(k, () => []).add(t);
    }

    final dayKeys = byDay.keys.toList();

    return ListView.builder(

      padding: const EdgeInsets.only(top: 12, bottom: 80),
      itemCount: dayKeys.length,
      itemBuilder: (_, i) {
        final g = byDay[dayKeys[i]]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(dayKeys[i],
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...g.map((t) => TransactionTile(transaction: t))
          ],
        );
      },
    );
  }

  String _dayLabel(DateTime d) {

    final today = DateTime.now();
    if (d.year == today.year && d.month == today.month && d.day == today.day) {
      return 'Today';
    }
    if (d.year == today.year &&
        d.month == today.month &&
        d.day == today.day - 1) {
      return 'Yesterday';
    }
    return DateFormat('EEEE, MMM d').format(d);
  }
}
