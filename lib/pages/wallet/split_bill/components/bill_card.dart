import 'package:flutter/material.dart';
import '../models/bill.dart';

class BillCard extends StatelessWidget {
  final Map<String, dynamic> bill;
  final VoidCallback onTap;

  const BillCard({Key? key, required this.bill, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bill['color'],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          bill['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          'Total: \$${bill['totalAmount'].toStringAsFixed(2)}\nMembers: ${bill['members'].join(', ')}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
