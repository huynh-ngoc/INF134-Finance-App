// File: lib/models/transaction.dart

class Transaction {
  final String id;
  final String description;
  final double amount;
  final String category;
  final String spentBy;
  final DateTime date;
  final String type; // 'expense' or 'deposit'

  const Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
    required this.spentBy,
    required this.date,
    required this.type,
  });

  // Create a copy with some fields replaced - useful for UI updates
  Transaction copyWith({
    String? id,
    String? description,
    double? amount,
    String? category,
    String? spentBy,
    DateTime? date,
    String? type,
  }) {
    return Transaction(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      spentBy: spentBy ?? this.spentBy,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  // String representation for debugging
  @override
  String toString() {
    return 'Transaction{id: $id, description: $description, amount: $amount, category: $category, spentBy: $spentBy, date: $date, type: $type}';
  }
}