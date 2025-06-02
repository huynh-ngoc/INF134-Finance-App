import 'package:flutter/material.dart';
import '../models/bill.dart';

Widget buildSplitBillDetailsTabs({
  required TabController tabController,
  required List<BillShare> splits,
  required List<String> members,
  required double totalAmount,
  required String createdAt,
}) {
  return Expanded(
    child: Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list_alt), text: 'Summary'),
            Tab(icon: Icon(Icons.group), text: 'Members'),
            Tab(icon: Icon(Icons.pie_chart), text: 'Splits'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // Summary Tab
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Created At: $createdAt', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),

              // Members Tab
              ListView(
                padding: const EdgeInsets.all(16.0),
                children: members
                    .map((m) => ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(m),
                        ))
                    .toList(),
              ),

              // Splits Tab
              ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: splits.length,
                itemBuilder: (context, index) {
                  final split = splits[index];
                  return ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(split.member),
                    trailing: Text('\$${split.amount.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
