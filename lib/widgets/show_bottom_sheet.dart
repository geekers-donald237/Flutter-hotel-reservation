
import 'package:flutter/material.dart';

class SortOptionsBottomSheet extends StatefulWidget {
  @override
  _SortOptionsBottomSheetState createState() => _SortOptionsBottomSheetState();
}

class _SortOptionsBottomSheetState extends State<SortOptionsBottomSheet> {
  String? selectedOption;

  List<String> sortOptions = [
    'Logements entiers en premier',
    'Distance du lieu d\'intérêt',
    'Popularité',
    'Catégorie (ordre croissant)',
    'Catégorie (ordre décroissant)',
    'Plus demandées',
    'Tarif (du moins cher au plus cher)',
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomSheetHeight = screenHeight * 4 / 5;

    return Container(
      height: bottomSheetHeight,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trier par :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Column(
              children: sortOptions.map((option) {
                return ListTile(
                  title: Text(option),
                  trailing: Radio<String>(
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
                    // Ajoutez ici le code à exécuter lorsque l'élément est sélectionné
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
