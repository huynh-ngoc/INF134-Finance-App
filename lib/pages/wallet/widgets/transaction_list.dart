import 'package:flutter/material.dart';
import '../models/transaction.dart'; // Import your Transaction model
import '../widgets/transaction_title.dart';    
import 'package:provider/provider.dart';
import '../../models/transaction_provider.dart';
import '../models/transaction.dart';
import './transaction_title.dart';







class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For now, use dummy list inside the model
    //final transactions = dummyTransactions; // Assuming dummy data from your model
    final transactions = context.watch<TransactionProvider>().mostRecent();

    if (transactions.isEmpty) {
      return Center(
        child: Text('No transactions yet!'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,    // Important to avoid scrolling inside scrollview
      physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionTile(transaction: transactions[index]);
      },
    );
  }
}
