import 'package:flutter/material.dart';

class CustomDisponibility extends StatelessWidget {
  const CustomDisponibility({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Ajoutez ici la logique à exécuter lors de l'appui sur le bouton
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // Couleur de fond bleue
        ),
        child: Text(
          'Voir les disponibilités',
          style: TextStyle(color: Colors.white), // Couleur du texte en blanc
        ),
      ),
    );
  }
}
