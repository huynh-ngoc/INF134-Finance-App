import 'package:financial_app/pages/models/transaction_provider.dart';
import 'package:financial_app/pages/wallet/models/transaction.dart';
import 'package:flutter/material.dart';

import 'graph.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  StatsRange _range = StatsRange.week;
  TxKind _kind  = TxKind.expense;
  
  int _selectedIndex = 1;

  final labels = ['Day','Week','Month','Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF64FFDA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Statistics', style: TextStyle(color: Colors.black)),
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            const Text('Total balance',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            const Text('\$24,124',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 24),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: StatsRange.values.map((r) {
                final sel = r == _range;
                final label = r.name[0].toUpperCase() + r.name.substring(1);
                return GestureDetector(
                  onTap: () => setState(() => _range = r),
                  child: Text(label,
                      style: TextStyle(
                        fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                        color: sel ? Colors.black : Colors.black54,
                      )),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,   
              children: [
                Expanded(
                  child: _statCard(
                    '\$', 'Expenses',
                    selected: _kind == TxKind.expense,
                    onTap: () => setState(() => _kind = TxKind.expense),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    '\$', 'Income',
                    selected: _kind == TxKind.income,
                    onTap: () => setState(() => _kind = TxKind.income),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

          
            SizedBox(
              height: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: StatisticsBar(
                    kind: _kind,
                    range: _range,
                    color:
                        (_kind == TxKind.expense) ? Colors.black : Colors.green,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

   Widget _statCard(String amount, String label,
      {required bool selected, required VoidCallback onTap, bool inverted = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            Text(amount,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text(label,
                style: TextStyle(
                     color: selected ? Colors.white70 : Colors.black54)),
          ],
        ),
      ),
    );
  }
}