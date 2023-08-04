import 'package:flutter/material.dart';

import '../gen/theme.dart';

class CheckBox extends StatefulWidget {
  final String text;
  final Function(bool) onChanged;

  const CheckBox(this.text, {required this.onChanged});

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                  widget.onChanged(
                      _isSelected); // Mettre à jour l'état dans le parent
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kDarkGreyColor)),
                child: _isSelected
                    ? Icon(
                        Icons.check,
                        size: 17,
                        color: Colors.green,
                      )
                    : null,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(widget.text),
          ],
        )
      ],
    );
  }
}
