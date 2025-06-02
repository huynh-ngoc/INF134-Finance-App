import 'package:flutter/material.dart';
import 'models/bill.dart';
import 'components/create_bill_form.dart';
import 'components/bill_card.dart';
import 'components/bill_empty_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SplitBillPage extends StatefulWidget {
  final Map<String, dynamic>? bill; // Optional for dashboard view

  const SplitBillPage({Key? key, this.bill}) : super(key: key);

  @override
  State<SplitBillPage> createState() => _SplitBillPageState();
}

class _SplitBillPageState extends State<SplitBillPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _billNameController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _memberController = TextEditingController();
  final FocusNode _memberFocusNode = FocusNode();

  late AnimationController _animationController;
  bool _showCreateForm = false;
  String _searchQuery = '';

  List<String> currentMembers = [];
  List<Map<String, dynamic>> savedBills = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    savedBills = [
      {
        'name': 'Dinner at Olive Garden',
        'members': ['You', 'Alice', 'Bob'],
        'color': Colors.blue,
        'totalAmount': 90.00,
        'createdAt': 'Yesterday, 7:30 PM',
        'splitDetails': [
          BillShare(member: 'You', amount: 30.00),
          BillShare(member: 'Alice', amount: 30.00),
          BillShare(member: 'Bob', amount: 30.00),
        ],
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    _billNameController.dispose();
    _totalAmountController.dispose();
    _memberController.dispose();
    _memberFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _createBill() {
    final name = _billNameController.text.trim();
    final total = double.tryParse(_totalAmountController.text) ?? 0;
    if (name.isEmpty || total <= 0 || currentMembers.isEmpty) return;

    final splitAmount = (total / currentMembers.length).toStringAsFixed(2);
    final splitDetails = currentMembers.map((m) => BillShare(member: m, amount: double.parse(splitAmount))).toList();
    final colors = [Colors.teal, Colors.orange, Colors.pink];

    setState(() {
      savedBills.add({
        'name': name,
        'members': List.from(currentMembers),
        'color': colors[savedBills.length % colors.length],
        'totalAmount': total,
        'createdAt': 'Just now',
        'splitDetails': splitDetails,
      });

      _billNameController.clear();
      _totalAmountController.clear();
      _memberController.clear();
      currentMembers.clear();
      _showCreateForm = false;
      _animationController.reverse();
    });
  }

  void _addMember() {
    final member = _memberController.text.trim();
    if (member.isNotEmpty && !currentMembers.contains(member)) {
      setState(() {
        currentMembers.add(member);
        _memberController.clear();
      });
      _memberFocusNode.requestFocus();
    }
  }

  void _removeMember(String member) {
    setState(() {
      currentMembers.remove(member);
    });
  }

  void _viewBillDetails(Map<String, dynamic> bill) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SplitBillPage(bill: bill),
      ),
    );
  }

  List<Map<String, dynamic>> get filteredBills {
    if (_searchQuery.isEmpty) return savedBills;
    return savedBills.where((b) =>
      b['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      b['members'].any((m) => m.toLowerCase().contains(_searchQuery.toLowerCase()))
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bill != null) {
      final List<BillShare> splits = List<BillShare>.from(widget.bill!['splitDetails']);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.bill!['name']),
          actions: [
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {
              // TODO: Implement split bill notifications
            },
          ),
          IconButton(
              icon: const Icon(Icons.qr_code),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Share Bill Link'),
                    content: QrImageView(
                      data: "https://yourapp.com/split/${widget.bill!['name']}",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount: \$${widget.bill!['totalAmount'].toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Split Between:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              ...splits.map((split) => ListTile(
                    title: Text(split.member),
                    trailing: Text('\$${split.amount.toStringAsFixed(2)}'),
                  )),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Bills'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_showCreateForm ? Icons.close : Icons.add_rounded),
            onPressed: () {
              setState(() {
                _showCreateForm = !_showCreateForm;
                _showCreateForm ? _animationController.forward() : _animationController.reverse();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showCreateForm ? null : 0,
            child: _showCreateForm
              ? buildCreateBillForm(
                  context: context,
                  billNameController: _billNameController,
                  totalAmountController: _totalAmountController,
                  memberController: _memberController,
                  memberFocusNode: _memberFocusNode,
                  currentMembers: currentMembers,
                  onAddMember: _addMember,
                  onRemoveMember: _removeMember,
                  onCreateBill: _createBill,
                )
              : null,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search split bills...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {}, // Placeholder for scan functionality
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: filteredBills.isEmpty
                ? buildBillEmptyState(context: context)
                : ListView.builder(
                    itemCount: filteredBills.length,
                    itemBuilder: (context, index) {
                      final bill = filteredBills[index];
                      return Dismissible(
                        key: Key(bill['name']),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          setState(() {
                            savedBills.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${bill['name']} deleted")),
                          );
                        },
                        child: BillCard(
                          bill: bill,
                          onTap: () => _viewBillDetails(bill),
                        ),
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
