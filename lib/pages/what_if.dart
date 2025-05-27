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
  double monthlySavingRequired = 0;  //for calculate monthly savings
  double timeRequired = 0;          //for calculate time required to save
  bool planSaved = false;

  //for tracking amount and time left on the progress bar
  DateTime? planStartDate;
  double manualAmountSaved = 0; double tempSavingsInput = 0; // for the input field
  double monthsPassedAuto = 0;

  final List<String> scenarios = [
    'Cutting daily coffee',
    'Cancel unused subscriptions',
    'Limit online shopping',
    'Cook instead of eating out',
  ];

  @override
  Widget build(BuildContext context) {

    // Calculate savings based on income and expenses
    //Calculate budget impact based on income and expenses
    double savings = income - expenses;
    double budgetImpact = income > 0 ? (savings / income) * 100 : 0;

    // Auto-calculate time passed
    if (planStartDate != null) {
      final now = DateTime.now();
      final daysPassed = now.difference(planStartDate!).inDays;
      monthsPassedAuto = (daysPassed / 30).clamp(0, timeRequired); // rough month estimate
    }

    return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("What If Planner"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Create Plan"),
              Tab(text: "Track Progress"),
            ],
          ),
        ),

        //Tab 1: Create Plan
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1. Select Financial Scenario & Add Description", style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(  
                    value: selectedScenario,
                    items: scenarios.map((scenario) {
                      return DropdownMenuItem(value: scenario, child: Text(scenario));
                    }).toList(),
                    onChanged: (value) => setState(() => selectedScenario = value!),
                    decoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder()),
              keyboardType: TextInputType.text,
              
            ),
            SizedBox(height: 12),



            Text("2. Enter Purchase Amount & Goal Timeline", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(labelText: "Goal Amount (\$)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => goalAmount = double.tryParse(val) ?? 0),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: "Goal Timeline (months)", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => timeRequired = double.tryParse(val) ?? 0),
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

            
            // Text("4. Explore Your Savings Plan", style: TextStyle(fontWeight: FontWeight.bold)),
            // Text("You could save \$${savings.toStringAsFixed(2)} per month.",
            //     style: TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.w500)),
            // SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                
                // Calculate monthly savings required to reach the goal amount
                setState(() {
                  planSaved = true;
                  planStartDate = DateTime.now();   //set the start date to now
                  if (goalAmount > 0 && savings > 0) {
                    monthlySavingRequired = goalAmount / timeRequired;
                  }
                });
              },
              child: Text("Calculate"),
            ),

            //display results if plan is saved
            if (planSaved) ...[
              SizedBox(height: 12),
              Text(" Results", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Monthly Saving Required: \$${monthlySavingRequired.toStringAsFixed(2)}"),
              Text("Time required: ${timeRequired.toStringAsFixed(1)} months"),
              Text("Budget Impact: It is ${( monthlySavingRequired/ savings * 100).toStringAsFixed(1)}% of your savings"),

              SizedBox(height: 16),
              Text("Alternative Options", style: TextStyle(fontWeight: FontWeight.bold)),
              Card(
                child: ListTile(
                title: Text("Reduce non-essential spending"),
                subtitle: Text("Save additional \$150/month to achieve in ${(goalAmount / (savings + 150)).toStringAsFixed(1)} months"),
               ),
              ),
              Card(
                child: ListTile(
                title: Text("Financing Option"),
                subtitle: Text("Pay \$${(goalAmount / 10 * 1.05).toStringAsFixed(2)} for 10 months (includes 5% interest)"),
                ),
              ),
            ]
          ],
        ),
      ),

      //TAB 2: track progress
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" Track Your Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 16),
                  if (!planSaved)
                    Text("No plan saved yet. Create a plan first on the other tab.",
                        style: TextStyle(color: Colors.grey))
                  else ...[
                    Text("Scenario: $selectedScenario"),
                    Text("Goal: \$${goalAmount.toStringAsFixed(2)}"),
                    Text("Estimated Time: ${timeRequired.toStringAsFixed(1)} months"),
                    SizedBox(height: 16),

                    // Display current savings and progress
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Manual Amount Saved (\$)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          tempSavingsInput = double.tryParse(val) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          manualAmountSaved += tempSavingsInput; // Add to the saved amount
                          tempSavingsInput = 0; // Reset input field
                        });
                      },
                      child: Text("Add Savings!"),
                      ),

                    Text("Saving Progress"),
                    LinearProgressIndicator(

                      // Calculate progress based on manual amount saved
                      //if goalAmount is 0, set progress to 0
                      //if goalAmount is greater than 0, calculate progress
                      value: goalAmount > 0 ? (manualAmountSaved / goalAmount).clamp(0, 1) : 0,

                      minHeight: 20,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    ),
                    SizedBox(height: 8),

                    // Display progress text
                    Text("Progress: \$${manualAmountSaved.toStringAsFixed(2)} of \$${goalAmount.toStringAsFixed(2)}"),
                    
                    Text("Time Progress"),
                    LinearProgressIndicator(
                      value: timeRequired > 0 ? (monthsPassedAuto / timeRequired).clamp(0, 1) : 0,
                      minHeight: 20,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    ),
                    Text("Time Passed: ${monthsPassedAuto.toStringAsFixed(1)} months"),
                  ]
                ],
              ),
            ),
    ],
    ),
      
          
      


      )
    );
  }
}
