import 'package:flutter/material.dart';
import 'aligned_pet_image.dart';

class FourPets extends StatelessWidget {
  const FourPets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 400,
      child: Center(
        child: Transform.rotate(
          angle: -20 / 360,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints:
              const BoxConstraints(maxHeight: 380, maxWidth: 380),
              child: const Stack(
                children: [
                  AlignedPetImage(
                    alignment: Alignment.topCenter,
                    imagePath: 'images/onboard_screen/crocodile.png',
                  ),
                  AlignedPetImage(
                    alignment: Alignment.centerLeft,
                    imagePath: 'images/onboard_screen/pink_sheep.png',
                  ),
                  AlignedPetImage(
                    alignment: Alignment.centerRight,
                    imagePath: 'images/onboard_screen/fox.png',
                  ),
                  AlignedPetImage(
                    alignment: Alignment.bottomCenter,
                    imagePath: 'images/onboard_screen/dog.png',
                  ),
                  AlignedPetImage(
                    alignment: Alignment.center,
                    imagePath: 'images/onboard_screen/Vector_V.png',
                    isVector: true,
                  ),
                  AlignedPetImage(
                    alignment: Alignment.center,
                    imagePath: 'images/onboard_screen/Vector_H.png',
                    isVector: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
