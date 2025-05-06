import 'package:flutter/material.dart';
import './invest/asset.dart';

class InvestPage extends StatefulWidget {
  const InvestPage({super.key});
  @override
  State<InvestPage> createState() => investPageState();
}

class investPageState extends State<InvestPage> {
  final tabs = ['All', 'Stocks', 'Crypto', 'ETF', 'Other'];
  int selectedTab = 0;

  final List<Asset> _assets = [
    Asset(
      id: 'tesla',
      name: 'Tesla',
      ticker: 'TSLA',
      price: 720.25,
      changePercent: 0.62,
      changeAmount: 4.32,
      category: 'Stocks',
      quantity: 1,
    ),
    Asset(
      id: 'nio',
      name: 'NIO',
      ticker: 'NIO',
      price: 41.43,
      changePercent: -1.2,
      changeAmount: -0.50,
      category: 'Stocks',
      quantity: 5,
    ),
  ];

  List<Asset> get _filteredAssets {
    final cat = tabs[selectedTab];
    if (cat == 'All') return _assets;
    return _assets.where((a) => a.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              const BackButton(color: Colors.black),
              const Spacer(),
              const Text('My Portfolio',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
            ]),
          ),

          const SizedBox(height: 8),
          const Text('Total balance',
              style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          const Text('\$2,442',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('+0.36% (\$9.04)',
              style: TextStyle(fontSize: 16, color: Colors.green)),

          const SizedBox(height: 16),
          SizedBox(
            height: 60,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final selected = i == selectedTab;
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = i),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? Colors.black : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$${_filteredAssets.fold<double>(0, (sum, a) => sum + a.price).toStringAsFixed(0)}',
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        Text(
                          tabs[i],
                          style: TextStyle(
                            color: selected ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade100,
                ),
                child: const Center(child: Text('📈 ')),
              ),
            ),
          ),

          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.15,
              maxChildSize: 0.9,
              builder: (context, scrollCu) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        Text(
                          'Assets: ${tabs[selectedTab]}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ]),
                    ),

                    Expanded(
                      child: ListView.builder(
                        controller: scrollCu,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _filteredAssets.length,
                        itemBuilder: (context, idx) {
                          final a = _filteredAssets[idx];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(a.ticker[0]),
                            ),
                            title: Text(a.name,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(
                              '${a.ticker} – ${a.quantity} shares',
                              style:
                                  const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('\$${a.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: a.changePercent >= 0
                                            ? Colors.greenAccent
                                            : Colors.redAccent,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  '${a.changePercent.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      color: a.changePercent >= 0
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            
                          );
                        },
                      ),
                    ),
                  ]),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
