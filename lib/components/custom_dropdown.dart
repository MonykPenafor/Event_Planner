import 'package:flutter/material.dart';

import '../models/payment_type_enum.dart';

class CustomDropDown<T> extends StatefulWidget {
  final TextEditingController controller;
  final List<T> dropDownItems;
  final String hintText;

  const CustomDropDown({
    Key? key,
    required this.controller,
    required this.dropDownItems,
    this.hintText = 'Please select an option',
  }) : super(key: key);

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      decoration: InputDecoration(
        labelText: 'Select Payment Category',
        labelStyle: TextStyle(
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blueGrey[300]!, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blueGrey[600]!, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      ),
      icon: Icon(Icons.arrow_drop_down, color: Colors.blueGrey[600]),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: Colors.blueGrey[800],
        fontSize: 16,
      ), 
      hint: Text(  
        widget.hintText,
        style: TextStyle(
          color: Colors.blueGrey[400],
          fontSize: 16,
        ),
      ),
      onChanged: (T? newValue) {
        setState(() {
          selectedItem = newValue;
          widget.controller.text = selectedItem != null 
              ? (selectedItem is PaymentTypes 
                  ? (selectedItem as PaymentTypes).description 
                  : selectedItem.toString()) 
              : '';
        });
      },
      items: widget.dropDownItems.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item is PaymentTypes ? (item as PaymentTypes).description : item.toString(),
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}




