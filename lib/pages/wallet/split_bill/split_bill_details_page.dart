import 'package:flutter/material.dart';
import 'models/bill.dart';
import 'components/split_bill_details_tab.dart';

class SplitBillDetailsPage extends StatefulWidget {
  final Map<String, dynamic> bill;

  const SplitBillDetailsPage({Key? key, required this.bill}) : super(key: key);

  @override
  _SplitBillDetailsPageState createState() => _SplitBillDetailsPageState();
}

class _SplitBillDetailsPageState extends State<SplitBillDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<BillShare> splits;
  late List<String> members;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    splits = List<BillShare>.from(widget.bill['splitDetails']);
    members = List<String>.from(widget.bill['members']);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bill['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Future: add edit functionality
            },
          ),
        ],
      ),
      body: buildSplitBillDetailsTabs(
        tabController: _tabController,
        splits: splits,
        members: members,
        totalAmount: widget.bill['totalAmount'],
        createdAt: widget.bill['createdAt'] ?? 'Unknown',
      ),
    );
  }
}
