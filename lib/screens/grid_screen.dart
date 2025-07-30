import 'package:flutter/material.dart';
import '/dummy_data.dart';
import 'list_screen.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portofolio Designer')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListScreen(
                    categoryId: cat['id']!,
                    categoryName: cat['name']!,
                  ),
                ),
              );
            },
            child: GridTile(
              footer: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.black54,
                child: Text(cat['name']!,
                    style: const TextStyle(color: Colors.white)),
              ),
              child: Image.network(cat['image']!, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
