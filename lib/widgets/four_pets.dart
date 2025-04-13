import 'package:cheat_chat/imports/imports.dart';

class FourPets extends StatelessWidget {
  const FourPets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 400,
      child: SafeArea(
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
                      imagePath: 'assets/images/crocodile.png',
                    ),
                    AlignedPetImage(
                      alignment: Alignment.centerLeft,
                      imagePath: 'assets/images/pink_sheep.png',
                    ),
                    AlignedPetImage(
                      alignment: Alignment.centerRight,
                      imagePath: 'assets/images/fox.png',
                    ),
                    AlignedPetImage(
                      alignment: Alignment.bottomCenter,
                      imagePath: 'assets/images/dog.png',
                    ),
                    AlignedPetImage(
                      alignment: Alignment.center,
                      imagePath: 'assets/images/Vector_V.png',
                      isVector: true,
                    ),
                    AlignedPetImage(
                      alignment: Alignment.center,
                      imagePath: 'assets/images/Vector_H.png',
                      isVector: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
