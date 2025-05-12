import 'package:flutter/material.dart';
import '../models/transaction.dart';

void showAddTransactionDialog({
  required BuildContext context,
  required String transactionType,
  required ValueChanged<String> onTypeChanged,
  required List<String> categories,
  required String selectedCategory,
  required ValueChanged<String?> onCategoryChanged,
  required Function(Transaction) onAdd,
  required String spentBy,
}) {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Add Transaction'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Transaction Type
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Expense'),
                    value: 'expense',
                    groupValue: transactionType,
                    onChanged: (value) => onTypeChanged(value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Deposit'),
                    value: 'deposit',
                    groupValue: transactionType,
                    onChanged: (value) => onTypeChanged(value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            // Amount
            TextFormField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 12),

            // Category Dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: onCategoryChanged,
              items: categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final desc = descriptionController.text.trim();
            final amt = double.tryParse(amountController.text.trim()) ?? 0.0;

            if (desc.isNotEmpty && amt > 0) {
              final newTx = Transaction(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                description: desc,
                amount: amt,
                category: selectedCategory,
                spentBy: spentBy,
                date: DateTime.now(),
                type: transactionType,
              );
              onAdd(newTx);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}
