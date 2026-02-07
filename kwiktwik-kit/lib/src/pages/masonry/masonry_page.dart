import 'package:flutter/material.dart';

class MasonryPage extends StatelessWidget {
  final List<String> imagePaths;
  const MasonryPage({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    // Mock infinite feed by repeating images (prod: use API pagination)
    final infiniteImages = List.generate(50, (i) => imagePaths[i % imagePaths.length]);
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.7, // vary for masonry feel
        ),
        itemCount: infiniteImages.length,
        itemBuilder: (context, index) {
          final heightFactor = (index % 3 + 1) * 100.0; // random height sim
          return Container(
            height: heightFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(infiniteImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}