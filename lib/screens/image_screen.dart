import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

import '../gen/theme.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  final List<String> imagePaths;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        foregroundColor: kblack,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
              size: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Ionicons.share_social_outline, size: 30),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: widget.imagePaths.length,
                itemBuilder: (context, index) {
                  final imagePath = widget.imagePaths[index];
                  if (index % 3 == 0) {
                    // Display the image alone on its row
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (index % 3 == 1) {
                      // Display two images side by side on the same row
                      final nextImagePath = widget.imagePaths[index + 1];
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(nextImagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  // return Container(); // Empty container for other cases
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique à exécuter lors de l'appui sur le bouton "Voir les disponibilités"
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700], // Couleur de fond bleue sombre
                elevation: 0, // Pas d'élévation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Pas de bordure
                ),
              ),
              child: Container(
                width: double.infinity, // Prend toute la largeur disponible
                padding: EdgeInsets.symmetric(vertical: 15), // Espace vertical
                child: Text(
                  'Voir les disponibilités',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
