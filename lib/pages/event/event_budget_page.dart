import 'package:flutter/material.dart';

class EventBudgetPage extends StatelessWidget {
  const EventBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(context),
            const SizedBox(height: 32),
            Text('Transaction', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Balance', style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text('\$5,473.00', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Income', style: TextStyle(color: Colors.white)),
                  Text('\$3,365.00', style: TextStyle(color: Colors.greenAccent)),
                ],
              ),
              Column(
                children: [
                  Text('Expense', style: TextStyle(color: Colors.white)),
                  Text('\$940.00', style: TextStyle(color: Colors.redAccent)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: ListView(
        children: [
          _buildTransactionItem('Clothes', 'T-shirt 3 pcs', 367.00, '29 Aug', Icons.shopping_bag),
          _buildTransactionItem('Food', 'Slice Cake 5 pcs', 201.00, '29 Aug', Icons.fastfood),
          _buildTransactionItem('Transport', 'Payment of Rent', 457.00, '29 Aug', Icons.directions_car),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String subtitle, double amount, String date, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text('-\$${amount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
      onTap: () {
        // Action on tap
      },
    );
  }
}
