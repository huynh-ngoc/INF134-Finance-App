// File: lib/pages/shared_wallet_page.dart

import 'package:flutter/material.dart';

import '../shared_wallets/components/create_wallet_form.dart';
import '../shared_wallets/components/invitations_bottom_sheet.dart';
import '../shared_wallets/components/wallet_empty_state.dart';
import '../shared_wallets/components/wallet_card.dart';
import '../shared_wallets/models/transaction.dart';
import '../shared_wallets/wallet_details_page.dart';

class SharedWalletPage extends StatefulWidget {
  const SharedWalletPage({Key? key}) : super(key: key);

  @override
  _SharedWalletPageState createState() => _SharedWalletPageState();
}

class _SharedWalletPageState extends State<SharedWalletPage> with SingleTickerProviderStateMixin {
  final TextEditingController _walletNameController = TextEditingController();
  final TextEditingController _memberController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _depositLimitController = TextEditingController();
  final TextEditingController _withdrawLimitController = TextEditingController();

  final FocusNode _memberFocusNode = FocusNode();

  List<String> currentMembers = [];
  List<Map<String, dynamic>> savedWallets = [];
  List<Map<String, dynamic>> pendingInvitations = [];

  late AnimationController _animationController;
  bool _showCreateForm = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Sample data
    savedWallets = [
      {
        'name': 'Family Expenses',
        'members': ['You', 'Partner', 'Kids'],
        'color': Colors.blue,
        'balance': 1250.00,
        'lastActivity': 'Today, 2:30 PM',
        'inviteCode': 'FAM123',
        'depositLimit': 5000.00,
        'withdrawLimit': 1000.00,
        'transactions': [
          Transaction(
            id: 't1',
            description: 'Grocery Shopping',
            amount: 120.50,
            category: 'Food & Dining',
            spentBy: 'Partner',
            date: DateTime.now().subtract(const Duration(hours: 2)),
            type: 'expense',
          ),
          Transaction(
            id: 't2',
            description: 'Monthly Allowance',
            amount: 500.00,
            category: 'Other',
            spentBy: 'You',
            date: DateTime.now().subtract(const Duration(days: 1)),
            type: 'deposit',
          ),
        ],
      },
    ];

    pendingInvitations = [
      {
        'id': '1',
        'walletName': 'Office Lunch Group',
        'invitedBy': 'John Doe',
        'members': 5,
        'inviteCode': 'OFF789',
      },
    ];
  }

  @override
  void dispose() {
    _walletNameController.dispose();
    _memberController.dispose();
    _searchController.dispose();
    _depositLimitController.dispose();
    _withdrawLimitController.dispose();
    _animationController.dispose();
    _memberFocusNode.dispose();
    super.dispose();
  }

  void _createWallet() {
    if (_walletNameController.text.trim().isEmpty || currentMembers.isEmpty) return;

    final depositLimit = double.tryParse(_depositLimitController.text) ?? 0;
    final withdrawLimit = double.tryParse(_withdrawLimitController.text) ?? 0;

    if (depositLimit <= 0 || withdrawLimit <= 0) return;

    final walletExists = savedWallets.any(
      (wallet) => wallet['name'].toLowerCase() == _walletNameController.text.trim().toLowerCase(),
    );
    if (walletExists) return;

    final colors = [Colors.blue, Colors.green, Colors.purple];
    final inviteCode = DateTime.now().millisecondsSinceEpoch.toString().substring(7);

    setState(() {
      savedWallets.add({
        'name': _walletNameController.text.trim(),
        'members': List.from(currentMembers),
        'color': colors[savedWallets.length % colors.length],
        'balance': 0.0,
        'lastActivity': 'Just created',
        'inviteCode': inviteCode,
        'depositLimit': depositLimit,
        'withdrawLimit': withdrawLimit,
        'transactions': <Transaction>[],
      });
      _walletNameController.clear();
      _depositLimitController.clear();
      _withdrawLimitController.clear();
      currentMembers.clear();
      _memberController.clear();
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

  void _viewWalletDetails(Map<String, dynamic> wallet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalletDetailsPage(
          wallet: wallet,
          onTransactionAdded: (tx) {
            setState(() {
              wallet['transactions'].add(tx);
              wallet['balance'] += tx.type == 'expense' ? -tx.amount : tx.amount;
              wallet['lastActivity'] = 'Just now';
            });
          },
        ),
      ),
    );
  }

  void _showInviteOptions(Map<String, dynamic> wallet) {}
  void _showWalletOptions(Map<String, dynamic> wallet) {}
  void _showJoinWalletDialog() {}
  void _handleAcceptInvite(String id) {}
  void _handleDeclineInvite(String id) {}

  List<Map<String, dynamic>> get filteredWallets {
    if (_searchQuery.isEmpty) return savedWallets;
    return savedWallets.where((wallet) =>
      wallet['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      wallet['members'].any((m) => m.toLowerCase().contains(_searchQuery.toLowerCase()))
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Wallets'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {
              if (pendingInvitations.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => buildInvitationsBottomSheet(
                    invitations: pendingInvitations,
                    onAccept: _handleAcceptInvite,
                    onDecline: _handleDeclineInvite,
                  ),
                );
              }
            },
          ),
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
              ? buildCreateWalletForm(
                  context: context,
                  walletNameController: _walletNameController,
                  depositLimitController: _depositLimitController,
                  withdrawLimitController: _withdrawLimitController,
                  memberController: _memberController,
                  memberFocusNode: _memberFocusNode,
                  currentMembers: currentMembers,
                  onAddMember: _addMember,
                  onRemoveMember: _removeMember,
                  onCreateWallet: _createWallet,
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
                      hintText: 'Search wallets...',
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
                  onPressed: _showJoinWalletDialog,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: filteredWallets.isEmpty
                ? buildWalletEmptyState(
                    context: context,
                    onCreatePressed: () {
                      setState(() {
                        _showCreateForm = true;
                        _animationController.forward();
                      });
                    },
                  )
                : ListView.builder(
                    itemCount: filteredWallets.length,
                    itemBuilder: (context, index) {
                      final wallet = filteredWallets[index];
                      return WalletCard(
                        wallet: wallet,
                        onTap: () => _viewWalletDetails(wallet),
                        onLongPress: () => _showWalletOptions(wallet),
                        onInvite: () => _showInviteOptions(wallet)
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
