import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_text.dart';

class DateField extends StatelessWidget {
  final TextEditingController dateController;
  final Function()? onTap;
  final String label;

  const DateField({
    required this.dateController,
    this.onTap,
    required this.label,
  });

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat("dd-MM-yyyy").format(pickedDate);
      dateController.text = formattedDate;
    } else {
      print("Not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: dateController,
        decoration: InputDecoration(
          label: AppText.small(label, fontSize: 14),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontWeight: FontWeight.bold),
        readOnly: true,
        onTap: onTap ?? () => _selectDate(context),
      ),
    );
  }
}
