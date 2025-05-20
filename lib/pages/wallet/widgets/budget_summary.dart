import 'package:flutter/material.dart';

class BudgetSummary extends StatelessWidget {
  const BudgetSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for now (later, we can pass real data into this widget)
    double income = 2000;
    double expenses = 1100;
    double savings = income - expenses;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Budget Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Income:', style: TextStyle(color: Colors.green, fontSize: 16)),
                Text('\$${income.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expenses:', style: TextStyle(color: Colors.red, fontSize: 16)),
                Text('\$${expenses.toStringAsFixed(2)}'),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Savings:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('\$${savings.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
