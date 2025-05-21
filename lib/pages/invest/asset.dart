class Asset {

  final String id;
  final String name;
  final String ticker;
  final double price;

  final double changePercent;
  final double changeAmount;

  final String category;   
  final int quantity;

  Asset({
    required this.id,
    required this.name,
    required this.ticker,
    required this.price,

    required this.changePercent,
    required this.changeAmount,
    
    required this.category,
    required this.quantity,
  });
}
