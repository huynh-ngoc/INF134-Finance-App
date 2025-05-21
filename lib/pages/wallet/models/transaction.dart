enum TxKind { income, expense }



class Transaction {
  final String title;      // Name of the transaction (e.g., "Groceries")
  final double amount;     // Amount of money
  final DateTime date;     // Date of the transaction
  final bool isIncome;     // True if income, False if expense
  final String category;   // Category: "Needs", "Wants", "Goals", "Income"
  final TxKind kind; 
  

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
    required this.kind, 
  });
}

// Dummy data for testing (can be replaced with real data later)
/*

List<Transaction> dummyTransactions = [
  Transaction(
    title: "Paycheck",
    amount: 2000,
    date: DateTime.now(),
    isIncome: true,
    category: 'Income',
  ),
  Transaction(
    title: "Groceries",
    amount: 150,
    date: DateTime.now(),
    isIncome: false,
    category: 'Needs',
  ),
  Transaction(
    title: "Movie Night",
    amount: 50,
    date: DateTime.now(),
    isIncome: false,
    category: 'Wants',
  ),
  Transaction(
    title: "Savings Deposit",
    amount: 300,
    date: DateTime.now(),
    isIncome: true,
    category: 'Goals',
  ),
];
*/