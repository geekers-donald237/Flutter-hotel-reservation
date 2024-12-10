import 'package:flutter/material.dart';

import '../screens/image_screen.dart';
import '../urls/all_url.dart';
import '../widgets/app_text.dart';


class GallerySection extends StatelessWidget {
  const GallerySection({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    if (imagePaths.length <= 3) {
      // If there are 3 or fewer images, display them without the "more" block
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppText.medium('Gallery', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                final imagePath = imagePaths[index];
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network('${Urls.racine}imagesAccomodation/${imagePath}',
                      fit: BoxFit.cover,
                      scale: 1.05,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      // If there are more than 3 images, use the existing logic
      List<String> firstThreeImages = imagePaths.take(3).toList();
      int remainingImageCount = imagePaths.length - 3;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppText.medium('Gallery', fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10),
              itemCount: firstThreeImages.length + 1,
              itemBuilder: (context, index) {
                if (index < firstThreeImages.length) {
                  final imagePath = firstThreeImages[index];
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network('${Urls.racine}imagesAccomodation/${imagePath}',
                        fit: BoxFit.cover,
                        scale: 1.05,
                      ),
                    ),
                  );
                } else {
                  // Display the "more" block with the background image
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageScreen(imagePaths: imagePaths,)));
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image:
                            AssetImage(imagePaths[3]), // Background image
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black
                                  .withOpacity(0.5), // Dark overlay color
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$remainingImageCount\nmore',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    }
  }
}
