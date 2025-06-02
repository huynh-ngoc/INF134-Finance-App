import 'package:flutter/material.dart';

Widget buildBillEmptyState({required BuildContext context}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.receipt_long, size: 80, color: Colors.grey),
        const SizedBox(height: 16),
        const Text(
          'No bills yet!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        const Text('Start by creating a new bill.', style: TextStyle(color: Colors.grey)),
      ],
    ),
  );
}
