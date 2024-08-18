import 'package:event_planner/services/payment_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetContainer extends StatelessWidget {
  final TextEditingController controller;

  BudgetContainer({
    Key? key,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentServices = Provider.of<PaymentServices>(context);
    // paymentServices.budget = double.tryParse(controller.text)!;
    var  remainingBudget = paymentServices.calculateRemaining().toStringAsFixed(2);
    var  totalSpent = paymentServices.calculateSpent().toStringAsFixed(2);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text('Spent', style: TextStyle(color: Colors.white)),
                  Text('\$$totalSpent',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 236, 236, 236),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text('Total Budget',
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 3),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  titlePadding: const EdgeInsets.only(
                                      top: 16.0, left: 16.0, right: 16.0),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Budget'),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                  content: TextField(
                                    controller: controller,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Save'),
                                      onPressed: () {
                                        if (controller.text.isNotEmpty) {
                                          double? newBudget = double.tryParse(controller.text);
                                          if (newBudget != null) {
                                            paymentServices.updateBudget(newBudget);
                                          }
                                          controller.text = '';
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.mode_edit_rounded),
                          iconSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    paymentServices.budget.toStringAsFixed(2),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Remaining', style: TextStyle(color: Colors.white)),
                  Text('\$$remainingBudget',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        );
  }
}