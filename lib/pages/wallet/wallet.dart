import 'package:flutter/material.dart';
import 'widgets/budget_summary.dart';
import 'widgets/transaction_list.dart';


class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Budget Summary
              BudgetSummary(),

              const SizedBox(height: 20),

              // Split Bill Section (Coming Soon)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.group, color: Colors.blue),
                  title: Text('Split Bill'),
                  subtitle: Text('Track shared expenses with friends or partners.'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Navigate to Split Bill page
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Shared Wallets Section (Coming Soon)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.wallet, color: Colors.green),
                  title: Text('Shared Wallets'),
                  subtitle: Text('Manage family or group wallets.'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Navigate to Shared Wallet page
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Spending Alerts Section (Coming Soon)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.warning, color: Colors.redAccent),
                  title: Text('Spending Alerts'),
                  subtitle: Text('Get notified when overspending.'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Set up spending alerts
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Transaction List
              Text(
                'Transaction History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TransactionList(), // (Show transaction list here)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open Add Transaction form
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
