import 'package:flutter/material.dart';

import '../models/event_type_enum.dart';

class CustomDropDown<T> extends StatefulWidget {
  final TextEditingController controller;
  final List<T> dropDownItems;
  final String hintText;
  final String labelText;
  final String Function(T) itemDescription;
  final String? initialValue;

  const CustomDropDown({
    Key? key,
    required this.controller,
    required this.dropDownItems,
    required this.labelText,
    required this.hintText,
    required this.itemDescription,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  T? selectedItem;
  
  
    @override
  void initState() {
    super.initState();
    if (T == EventType) {
      selectedItem = _parseEventType(widget.initialValue);
    } 
    if (selectedItem != null) {
      widget.controller.text = widget.itemDescription(selectedItem!);
    }
  }

    T? _parseEventType(String? value) {
    if (value == null) return null;
    switch (value) {
      case 'Wedding':
        return EventType.weddingEvent as T;
      case 'Birthday Party':
        return EventType.birthdayParty as T;
      case 'Corporate Meeting':
        return EventType.corporateMeeting as T;
      case 'Other':
        return EventType.other as T;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      decoration: InputDecoration(
        labelText: widget.labelText,
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
              ? widget.itemDescription(selectedItem!) 
              : '';
        });
      },
      items: widget.dropDownItems.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            widget.itemDescription(item),
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
