
import 'package:flutter/material.dart';
import './invest/asset.dart';
import 'AssetDetailPage.dart';

class InvestPage extends StatefulWidget {
  const InvestPage({super.key});
  @override
  State<InvestPage> createState() => investPageState();
}

class investPageState extends State<InvestPage> {
  final tabs = ['All', 'Stocks', 'Crypto', 'ETF', 'Other'];
  int selectedTab = 0;

  final List<Asset> assets = [
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

  List<Asset> get filteredAssets {
    final cat = tabs[selectedTab];
    if (cat == 'All') return assets;
    return assets.where((a) => a.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sumAll = assets.fold<double>(0, (sum, a) => sum + a.price);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Center(
                    child: Text('My Portfolio',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 8),
                const Text('Total balance',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                const Text('\$2,442',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('+0.36% (\$9.04)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.green)),

                const SizedBox(height: 16),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, i) {
                      final cat = tabs[i];
                      final sumCat = (cat == 'All')
                          ? sumAll
                          : assets
                              .where((a) => a.category == cat)
                              .fold<double>(0, (s, a) => s + a.price);
                      final pct = sumAll > 0 ? sumCat / sumAll * 100 : 0;
                      final selected = i == selectedTab;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => selectedTab = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.black
                                : Colors.grey.shade200,
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text('\$${sumCat.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 2),
                              Text('${pct.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                      color: selected
                                          ? Colors.white70
                                          : Colors.black54,
                                      fontSize: 12)),
                              const SizedBox(height: 2),
                              Text(cat,
                                  style: TextStyle(
                                      color: selected
                                          ? Colors.white70
                                          : Colors.black54,
                                      fontSize: 12)),
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
                      child: const Center(child: Text('📈 Chart Placeholder')),
                    ),
                  ),
                ),
              ],
            ),

            DraggableScrollableSheet(
              expand: true,         
              initialChildSize: 0.15,
              minChildSize: 0.15,
              maxChildSize: 0.91,    
              builder: (context, ctrl) {
                final filtered = filteredAssets;
                final sumFiltered = filtered
                    .fold<double>(0, (s, a) => s + a.price);
                final pct = sumAll > 0
                    ? sumFiltered / sumAll * 100
                    : 0;
                final itemCount = 2 + filtered.length;

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: ListView.builder(
                    controller: ctrl,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8),
                    itemCount: itemCount,
                    itemBuilder: (context, idx) {
                      if (idx == 0) {
                        return Center(
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(vertical: 12),
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius:
                                  BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }
                      if (idx == 1) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(children: [
                            Text('Assets: ${tabs[selectedTab]}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                                '\$${sumFiltered.toStringAsFixed(2)} • ${pct.toStringAsFixed(0)}%',
                                style:
                                    const TextStyle(color: Colors.white70)),
                          ]),
                        );
                      }
                      final asset = filtered[idx - 2];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(asset.ticker[0]),
                        ),
                        title: Text(asset.name,
                            style:
                                const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          '${asset.ticker} – ${asset.quantity} shares',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.end,
                          children: [
                            Text('\$${asset.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: asset.changePercent >= 0
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              '${asset.changePercent.toStringAsFixed(2)}%',
                              style: TextStyle(
                                  color: asset.changePercent >= 0
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  AssetDetailPage(asset: asset),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
