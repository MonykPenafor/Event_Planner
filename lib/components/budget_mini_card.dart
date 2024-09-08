import 'package:event_planner/services/payment_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetMiniCard extends StatelessWidget {
  final String label;
  // final String subLabel;
  final double moneySpent;
  final IconData? icon;

  BudgetMiniCard({
    Key? key,
    required this.label,
    // required this.subLabel,
    required this.moneySpent,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 81, 177, 94), Color.fromARGB(255, 200, 255, 0)],
        ),
      ),
      child: Column(
        children: [
          Icon(icon),
          Text(label, style: TextStyle(color: Colors.white)),
          // Text(subLabel, style: TextStyle(color: Colors.white)),
          Text('\$$moneySpent',
              style: const TextStyle(
                  color: Color.fromARGB(255, 236, 236, 236),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
