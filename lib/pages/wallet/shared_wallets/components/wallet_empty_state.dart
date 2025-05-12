// File: lib/components/wallet_empty_state.dart

import 'package:flutter/material.dart';

Widget buildWalletEmptyState({
  required VoidCallback onCreatePressed,
  required BuildContext context,
}) {
  return Container(
    padding: const EdgeInsets.all(40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.account_balance_wallet_outlined,
          size: 80,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        Text(
          'No Shared Wallets Yet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create your first shared wallet to start\nmanaging expenses with others',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[500],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onCreatePressed,
          icon: const Icon(Icons.add),
          label: const Text('Create Wallet'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    ),
  );
}
