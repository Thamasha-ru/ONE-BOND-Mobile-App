import 'package:flutter/material.dart';

class BuyTokensPage extends StatefulWidget {
  @override
  _BuyTokensPageState createState() => _BuyTokensPageState();
}

class _BuyTokensPageState extends State<BuyTokensPage> {
  final _amountController = TextEditingController();
  String? _selectedPaymentMethod;
  final List<String> _paymentMethods = ['USDT', 'Credit/Debit Card', 'Bank Transfer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy OBC Tokens'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the amount of OBC tokens you want to buy:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount (OBC Tokens)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              items: _paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Payment Method',
              ),
              hint: Text('Select a payment method'),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction Summary:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildTransactionSummary(),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_amountController.text.isEmpty || _selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter the amount and select a payment method')),
                  );
                } else {
                  _showConfirmationDialog();
                }
              },
              child: Text('Confirm and Pay'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSummary() {
    final amount = _amountController.text;
    final paymentMethod = _selectedPaymentMethod ?? 'None';
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: ${amount.isEmpty ? '0' : amount} OBC Tokens'),
          Text('Payment Method: $paymentMethod'),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Purchase'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount: ${_amountController.text} OBC Tokens'),
              Text('Payment Method: ${_selectedPaymentMethod ?? 'None'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement the payment logic here
                _showSuccessDialog();
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Purchase Successful'),
          content: Text('Your purchase of ${_amountController.text} OBC Tokens was successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Go back to the previous page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
