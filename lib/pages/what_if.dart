import 'package:flutter/material.dart';

class WhatIfPage extends StatefulWidget {
  @override
  _WhatIfPageState createState() => _WhatIfPageState();
}

class _WhatIfPageState extends State<WhatIfPage> {
  String selectedScenario = 'Cutting daily coffee';
  double itemPrice = 0;
  double goalAmount = 0;
  double income = 0;
  double expenses = 0;
  bool planSaved = false;

  final List<String> scenarios = [
    'Cutting daily coffee',
    'Cancel unused subscriptions',
    'Limit online shopping',
    'Cook instead of eating out',
  ];

  @override
  Widget build(BuildContext context) {
    double savings = income - expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text("What If Planner"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1. Select Financial Scenario", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: selectedScenario,
              items: scenarios.map((scenario) {
                return DropdownMenuItem(value: scenario, child: Text(scenario));
              }).toList(),
              onChanged: (value) => setState(() => selectedScenario = value!),
              decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12)),
            ),
            SizedBox(height: 16),

            Text("2. Enter Item Price & Goal Amount", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(labelText: "Item Price (\$)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => itemPrice = double.tryParse(val) ?? 0),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: "Goal Amount (\$)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => goalAmount = double.tryParse(val) ?? 0),
            ),
            SizedBox(height: 16),

            Text("3. Input Monthly Income & Expenses", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(labelText: "Monthly Income (\$)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => income = double.tryParse(val) ?? 0),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: "Monthly Expenses (\$)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => expenses = double.tryParse(val) ?? 0),
            ),
            SizedBox(height: 16),

            Text("4. Explore Your Savings Plan", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("You could save \$${savings.toStringAsFixed(2)} per month.",
                style: TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.w500)),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() => planSaved = true);
                // You can save to local storage or Wallet page here
              },
              child: Text("Save Plan to Wallet"),
            ),
            if (planSaved)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("✅ Plan Saved!", style: TextStyle(color: Colors.green)),
              )
          ],
        ),
      ),
    );
  }
}
