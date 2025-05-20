import 'package:flutter/material.dart';
import '../models/transaction.dart';

Widget buildWalletDetailsTabs({
  required TabController tabController,
  required List<Transaction> transactions,
  required List<String> members,
}) {
  return Expanded(
    child: Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.history), text: 'Transactions'),
            Tab(icon: Icon(Icons.group), text: 'Members'),
            Tab(icon: Icon(Icons.insights), text: 'Summary'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // Transactions Tab
              transactions.isEmpty
                  ? const Center(child: Text('No transactions yet'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        return ListTile(
                          leading: Icon(
                            tx.type == 'expense'
                                ? Icons.remove_circle_outline
                                : Icons.add_circle_outline,
                            color: tx.type == 'expense' ? Colors.red : Colors.green,
                          ),
                          title: Text(tx.description),
                          subtitle: Text('${tx.category} • ${tx.spentBy}'),
                          trailing: Text(
                            '${tx.type == 'expense' ? '-' : '+'}\$${tx.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: tx.type == 'expense' ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),

              // Members Tab
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: members
                      .map((m) => ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(m),
                          ))
                      .toList(),
                ),
              ),

              // Summary Tab (placeholder)
              const Center(
                child: Text('Summary charts and analytics coming soon...'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
