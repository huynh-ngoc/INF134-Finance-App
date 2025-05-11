import 'package:flutter/material.dart';
import '../models/transaction.dart'; // Import your Transaction model

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({Key? key, required this.transaction}) : super(key: key);

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Needs':
        return Colors.blue;
      case 'Wants':
        return Colors.orange;
      case 'Goals':
        return Colors.purple;
      case 'Income':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: getCategoryColor(transaction.category),
        child: Icon(
          transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      title: Text(transaction.title),
      subtitle: Text('${transaction.category} • ${transaction.date.toLocal().toString().split(' ')[0]}'),
      trailing: Text(
        (transaction.isIncome ? '+ ' : '- ') + '\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: transaction.isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
