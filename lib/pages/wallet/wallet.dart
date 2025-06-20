import 'package:flutter/material.dart';
import 'widgets/budget_summary.dart';
import 'widgets/transaction_list.dart';
import 'widgets/add_transaction_form.dart';
import './shared_wallets/shared_wallets_page.dart';
import './split_bill/split_bill_page.dart';


import 'package:provider/provider.dart';
import '../models/transaction_provider.dart';
import 'transactions_page.dart';




class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
              const BudgetSummary(),

              const SizedBox(height: 20),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.group, color: Colors.blue),
                  title: const Text('Split Bill'),
                  subtitle: const Text('Track shared expenses with friends or partners.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplitBillPage(), 
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Shared Wallets Section (Coming Soon)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.wallet, color: Colors.green),
                  title: const Text('Shared Wallets'),
                  subtitle: const Text('Manage family or group wallets.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SharedWalletPage()),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Spending Alerts Section (Coming Soon)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.redAccent),
                  title: const Text('Spending Alerts'),
                  subtitle: const Text('Get notified when overspending.'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // TODO: Set up spending alerts
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Transaction List
              //const Text(
                //'Transaction History',
                //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //),
              
              Row(
                children: [
                  const Text('Transaction History',
                    style: 
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TransactionsPage()),
                  ), 
                  child: const Text('View all')),
                  
                ],

              ),
              const SizedBox(height: 10),
              const TransactionList(), // Transaction list widget
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => AddTransactionForm(
              onTransactionAdded: () {
                setState(() {}); // Refresh the WalletPage
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
