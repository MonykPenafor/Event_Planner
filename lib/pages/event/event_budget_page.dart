import 'package:event_planner/components/budget_container.dart';
import 'package:event_planner/models/payment.dart';
import 'package:event_planner/models/payment_type_enum.dart';
import 'package:event_planner/services/payment_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/budget_mini_card.dart';
import '../../components/custom_dropdown.dart';
import '../../components/payment_component.dart';
import '../../models/event_type_enum.dart';


class EventBudgetPage extends StatefulWidget {
  final TextEditingController budgetController;
  final TextEditingController serviceFeeController;


  const EventBudgetPage({
    super.key,
    required this.budgetController,
    required this.serviceFeeController,
    });

  @override
  _EventBudgetPageState createState() => _EventBudgetPageState();
}

class _EventBudgetPageState extends State<EventBudgetPage> {
  final TextEditingController _paymentDescriptionController = TextEditingController();
  final TextEditingController _paymentValueController = TextEditingController();
  final TextEditingController _paymentImageController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    
    final paymentServices = Provider.of<PaymentServices>(context);

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
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Service Fee', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(
                          '\$${paymentServices.serviceFee!.toStringAsFixed(2)}',
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

            Wrap(
              spacing: 8.0, // Espaçamento horizontal entre os itens
              runSpacing: 8.0, // Espaçamento vertical entre as linhas
              children: [
                BudgetMiniCard(icon: Icons.restaurant, label: "heyheyhey", subLabel: "hey", moneySpent: 200),
                BudgetMiniCard(icon: Icons.restaurant, label: "hheyheyheyey", subLabel: "hey", moneySpent: 200),
                BudgetMiniCard(icon: Icons.restaurant, label: "hey", subLabel: "hey", moneySpent: 200),
                BudgetMiniCard(icon: Icons.restaurant, label: "hheyheyheyey", subLabel: "hey", moneySpent: 200),
                BudgetMiniCard(icon: Icons.restaurant, label: "hey", subLabel: "hey", moneySpent: 200),
                BudgetMiniCard(icon: Icons.restaurant, label: "hey", subLabel: "hey", moneySpent: 200),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Payments', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(width: 7,),
                SizedBox(
                  width: 30,
                  height: 30, 
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
                                        const Text('Payment'),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _paymentDescriptionController,
                                          decoration: const InputDecoration(
                                            labelText: 'Description',
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        TextField(
                                          controller: _paymentValueController,
                                          decoration: const InputDecoration(
                                            labelText: 'Value',
                                            prefixText: '\$',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),

                                        const SizedBox(height: 24),
                                        
                                        CustomDropDown<PaymentTypes>(
                                          controller: _paymentTypeController,
                                          dropDownItems: PaymentTypes.values,
                                        ),

                                        const SizedBox(height: 8),

                                        TextField(
                                          controller: _paymentImageController,
                                          decoration: const InputDecoration(
                                            labelText: 'Image URL',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          if (_paymentDescriptionController.text.isNotEmpty) {
                                            
                                            Payment payment = Payment(description: _paymentDescriptionController.text, value: double.tryParse(_paymentValueController.text), img: _paymentImageController.text, category: _paymentTypeController.text);

                                            paymentServices.addLocalPayment(payment);
                                            _paymentDescriptionController.clear();
                                            _paymentValueController.clear();
                                            _paymentImageController.clear();
                                            _paymentTypeController.clear();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                    },
                    icon: const Icon(Icons.add),
                    iconSize: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),

             paymentServices.localPayments.isEmpty 
              ? const Center(child: Text('No payments registered')) 
              : ListView.builder(
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paymentServices.localPayments.length,
                  itemBuilder: (context, index) {
                    var payment = paymentServices.localPayments[index];
                    return PaymentItem(payment, index, paymentServices, context, Icons.receipt);
                  },
                ),

          ],
        ),
      ),
    );
  }
}

