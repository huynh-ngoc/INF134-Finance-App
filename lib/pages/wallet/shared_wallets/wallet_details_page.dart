// File: lib/pages/wallet_details_page.dart

import 'package:flutter/material.dart';
import '../shared_wallets/components/transaction_dialog.dart';
import '../shared_wallets/components/wallet_details_tabs.dart';
import '../shared_wallets/models/transaction.dart';

class WalletDetailsPage extends StatefulWidget {
  final Map<String, dynamic> wallet;
  final Function(Transaction) onTransactionAdded;

  const WalletDetailsPage({
    Key? key,
    required this.wallet,
    required this.onTransactionAdded,
  }) : super(key: key);

  @override
  _WalletDetailsPageState createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'Food & Dining';
  String _transactionType = 'expense';

  final List<String> expenseCategories = [
    'Food & Dining',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Education',
    'Travel',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openTransactionDialog() {
    showAddTransactionDialog(
      context: context,
      transactionType: _transactionType,
      onTypeChanged: (type) => setState(() => _transactionType = type),
      categories: expenseCategories,
      selectedCategory: _selectedCategory,
      onCategoryChanged: (cat) {
        if (cat != null) {
          setState(() => _selectedCategory = cat);
        }
      },
      onAdd: (Transaction tx) {
        widget.onTransactionAdded(tx);
        setState(() {});
      },
      spentBy: 'You',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wallet['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openTransactionDialog,
          ),
        ],
      ),
      body: buildWalletDetailsTabs(
        tabController: _tabController,
        transactions: List<Transaction>.from(widget.wallet['transactions']),
        members: List<String>.from(widget.wallet['members']),
      ),
    );
  }
}
