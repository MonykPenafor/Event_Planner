import 'package:event_planner/components/budget_container.dart';
import 'package:event_planner/services/payment_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/budget_mini_card.dart';


class EventBudgetPage extends StatefulWidget {
  final TextEditingController budgetController;
  final TextEditingController serviceFeeController;


  EventBudgetPage({
    super.key,
    required this.budgetController,
    required this.serviceFeeController,
    });

  @override
  _EventBudgetPageState createState() => _EventBudgetPageState();
}

class _EventBudgetPageState extends State<EventBudgetPage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BudgetContainer(controller: widget.budgetController),

            const SizedBox(height: 5),
            
            Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 194, 240, 241), Color.fromARGB(255, 104, 200, 245)],
                  ),
                ),
                child: Consumer<PaymentServices>(
                  builder: (context, paymentServices, child) {
                    
                  // paymentServices.serviceFee = double.tryParse(widget.serviceFeeController.text)!;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Service Fee', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(
                          '\$${paymentServices.serviceFee.toStringAsFixed(2)}',
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
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
                                        const Text('Service Fee'),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                    content: TextField(
                                      controller: widget.serviceFeeController,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          if (widget.serviceFeeController.text.isNotEmpty) {
                                            double? newServiceFee = double.tryParse(widget.serviceFeeController.text);
                                            if (newServiceFee != null) {
                                              paymentServices.updateServiceFee(newServiceFee);
                                            }
                                            widget.serviceFeeController.text = '';
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
                            color: const Color.fromARGB(255, 0, 0, 0),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Payments', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(width: 7,),
                SizedBox(
                  width: 30,
                  height: 30, 
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    iconSize: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPaymentItem('Venue Rental', 'Payment for venue', 1200.00, '15 Aug', Icons.location_city),
                _buildPaymentItem('Catering', 'Food and drinks', 800.00, '16 Aug', Icons.restaurant),
                _buildPaymentItem('Decorations', 'Event decorations', 300.00, '18 Aug', Icons.party_mode),
                
                BudgetMiniCard(icon: Icons.restaurant , label: "hey", subLabel: "hey", moneySpent: 200),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem(String title, String subtitle, double amount, String date, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text('-\$${amount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
      onTap: () { },
    );
  }
}
