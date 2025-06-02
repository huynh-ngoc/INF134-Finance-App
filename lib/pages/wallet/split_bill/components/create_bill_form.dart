import 'package:flutter/material.dart';

Widget buildCreateBillForm({
  required BuildContext context,
  required TextEditingController billNameController,
  required TextEditingController totalAmountController,
  required TextEditingController memberController,
  required FocusNode memberFocusNode,
  required List<String> currentMembers,
  required VoidCallback onCreateBill,
  required VoidCallback onAddMember,
  required Function(String) onRemoveMember,
}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: billNameController,
          decoration: const InputDecoration(labelText: 'Bill Name'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: totalAmountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Total Amount'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: memberController,
                focusNode: memberFocusNode,
                decoration: const InputDecoration(labelText: 'Add Member'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onAddMember,
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: currentMembers
              .map((member) => Chip(
                    label: Text(member),
                    onDeleted: () => onRemoveMember(member),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onCreateBill,
          child: const Text('Create Bill'),
        ),
      ],
    ),
  );
}
