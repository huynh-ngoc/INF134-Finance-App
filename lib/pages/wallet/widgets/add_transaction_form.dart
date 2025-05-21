import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:provider/provider.dart';

import '../../models/transaction_provider.dart';
import 'package:intl/intl.dart';


class AddTransactionForm extends StatefulWidget {
  final VoidCallback onTransactionAdded;  

  const AddTransactionForm({Key? key, required this.onTransactionAdded}) : super(key: key);  // <-- ADD required parameter

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  double _amount = 0.0;
  DateTime _date = DateTime.now(); 


  String _category = 'Needs';
  bool _isIncome = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTransaction = Transaction(
        title: _title,
        amount: _amount,

    

        //date: DateTime.now(),

        date: _date,

        isIncome: _isIncome,
        category: _category,
      );

      //dummyTransactions.add(newTransaction); // add to dummy list

      Provider.of<TransactionProvider>(context, listen: false)
        .add(newTransaction);



      widget.onTransactionAdded();  // <-- call the callback to refresh WalletPage
      Navigator.of(context).pop(); // close the bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add Transaction', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) => _amount = double.tryParse(value!) ?? 0,
                validator: (value) => value!.isEmpty ? 'Please enter an amount' : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero, 
                leading: const Icon(Icons.calendar_today_outlined),
                title: Text(DateFormat.yMMMd().format(_date)),
                onTap: () async {
                  final choose = await showDatePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 5),
                    lastDate: DateTime(DateTime.now().year + 5),
                    initialDate: _date,
                  );

                  if (choose != null)
                  {
                    setState(()=> _date = choose); 
                  }
                },
              ),

              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Category'),
                items: ['Needs', 'Wants', 'Goals', 'Income']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: Text('Is Income?'),
                value: _isIncome,
                onChanged: (value) {
                  setState(() {
                    _isIncome = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
