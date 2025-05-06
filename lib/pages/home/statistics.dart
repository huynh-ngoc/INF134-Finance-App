import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  
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
              children: List.generate(labels.length, (i) {
                final isSel = i == _selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = i),
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                      color: isSel ? Colors.black : Colors.black54,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

           
            Row(
              children: [
                Expanded(child: _statCard('\$2,258','Expenses',
                    bg: Colors.black, fg: Colors.white)),
                const SizedBox(width: 12),
                Expanded(child: _statCard('\$5,900','Incomes',
                    bg: Colors.white, fg: Colors.black)),
              ],
            ),

            const SizedBox(height: 24),

            // Graph TBD
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text('📈')),
            ),

            // transactions list,
          ],
        ),
      ),
    );
  }

  Widget _statCard(String amount, String label,
      {required Color bg, required Color fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(amount,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: fg,
              )),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                fontSize: 14,
                color: fg,
              )),
        ],
      ),
    );
  }
}
