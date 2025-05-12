import 'package:flutter/material.dart';

import './invest/asset.dart';

class AssetDetailPage extends StatefulWidget 
{
  final Asset asset;
  const AssetDetailPage({super.key, required this.asset});

  @override
  State<AssetDetailPage> createState() => AssetDetailPageState();
}

class AssetDetailPageState extends State<AssetDetailPage> 
{
  final timeRanges = ['24h','7d','30d','60d','90d','All'];
  int selectedRange = 5;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(widget.asset.name, style: const TextStyle(color: Colors.black)),
      ),
      body: Column(children: [
        const SizedBox(height: 16),
        Text('\$${widget.asset.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        Text(
          '${widget.asset.changePercent.toStringAsFixed(2)}% (\$${widget.asset.changeAmount.toStringAsFixed(2)})',
          style: TextStyle(
            fontSize: 16,
            color: widget.asset.changePercent >= 0 ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(height: 24),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(timeRanges.length, (i) {
              final sel = i == selectedRange;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() => selectedRange = i),
                  child: Text(
                    timeRanges[i],
                    style: TextStyle(
                      fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                      color: sel ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text('📈')),
            ),
          ),
        ),

      ]),
    );
  }
}
