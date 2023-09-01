import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SortOptionsBottomSheet extends StatefulWidget {
  @override
  _SortOptionsBottomSheetState createState() => _SortOptionsBottomSheetState();
}

class _SortOptionsBottomSheetState extends State<SortOptionsBottomSheet> {
  String? selectedOption;

  Widget build(BuildContext context) {
    List<String> sortOptions = [
      AppLocalizations.of(context)!.bottom_option_logement_first,
      AppLocalizations.of(context)!.bottom_option_distancet,
      AppLocalizations.of(context)!.bottom_option_popularitet,
      AppLocalizations.of(context)!.bottom_option_categorie_croissant,
      AppLocalizations.of(context)!.bottom_option_categorie_decroissant,
      AppLocalizations.of(context)!.bottom_option_plus_demande,
      AppLocalizations.of(context)!.bottom_option_tarif,
    ];
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
                      Navigator.of(context).pop();
                    },
                  ),
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
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
