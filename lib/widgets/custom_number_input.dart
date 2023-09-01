import 'package:flutter/material.dart';

class CustomNumberInput extends StatelessWidget {
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final TextEditingController controller;

  CustomNumberInput({
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  }) : controller = TextEditingController(text: value.toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Bordure carrée
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            icon: Icon(Icons.remove),
          ),
          SizedBox(
            width: 50,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                // Optional: Uncomment the following lines to update the value as the user types
                // int newValue = int.tryParse(value) ?? 0;
                // onValueChanged(newValue);
              },
            ),
          ),
          IconButton(
            onPressed: onIncrease,
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}



class CustomNumberInput2 extends StatelessWidget {
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final TextEditingController controller;

  CustomNumberInput2({
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  }) : controller = TextEditingController(text: value.toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Bordure carrée
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 50,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  // Optional: Uncomment the following lines to update the value as the user types
                  // int newValue = int.tryParse(value) ?? 0;
                  // onValueChanged(newValue);
                },
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
