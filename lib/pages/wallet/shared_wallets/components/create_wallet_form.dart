// File: lib/components/create_wallet_form.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildCreateWalletForm({
  required BuildContext context,
  required TextEditingController walletNameController,
  required TextEditingController depositLimitController,
  required TextEditingController withdrawLimitController,
  required TextEditingController memberController,
  required FocusNode memberFocusNode,
  required List<String> currentMembers,
  required VoidCallback onAddMember,
  required Function(String) onRemoveMember,
  required VoidCallback onCreateWallet,
}) {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create a Shared Wallet',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: walletNameController,
          decoration: InputDecoration(
            labelText: 'Wallet Name',
            prefixIcon: const Icon(Icons.account_balance_wallet),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: depositLimitController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: 'Deposit Limit',
                  prefixIcon: const Icon(Icons.add_circle_outline),
                  prefixText: '\$ ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: withdrawLimitController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: 'Withdraw Limit',
                  prefixIcon: const Icon(Icons.remove_circle_outline),
                  prefixText: '\$ ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: memberController,
                focusNode: memberFocusNode,
                decoration: InputDecoration(
                  labelText: 'Add Member',
                  prefixIcon: const Icon(Icons.person_add),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                onFieldSubmitted: (_) => onAddMember(),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: onAddMember,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (currentMembers.isNotEmpty) ...[
          Text(
            'Members (${currentMembers.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: currentMembers.map((member) {
              return Chip(
                avatar: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  child: Text(
                    member[0].toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                label: Text(member),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => onRemoveMember(member),
                backgroundColor: Colors.grey[100],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onCreateWallet,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Create Wallet'),
          ),
        ),
      ],
    ),
  );
}
