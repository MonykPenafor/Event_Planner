import 'package:event_planner/services/payment_services.dart';
import 'package:flutter/material.dart';

import '../models/payment.dart';

Widget PaymentItem(Payment p, int index, PaymentServices paymentServices, BuildContext context, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(p.description),
      subtitle: Text(p.category!),
      trailing: Text('-\$${p.value!.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
      onTap: () { },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Payment?'),
              content: const Text('Do you really want to delete this payment register?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    paymentServices.removeLocalPayment(index);
                    if (p.id != null) {
                      paymentServices.paymentsToDelete.add(p);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },



    );
  }