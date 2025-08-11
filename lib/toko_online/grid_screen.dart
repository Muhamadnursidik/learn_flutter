import 'package:flutter/material.dart';
import '/toko_data.dart';
import 'list_screen.dart';

class TokoGrid extends StatelessWidget {
  const TokoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toko online')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: product.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          final cat = product[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ListScreen(
                    productId: cat['id']!,
                    productName: cat['name']!,
                    productLoc: cat['location']!,
                    productPrice: cat['price']!,
                    productImage: cat['image']!,
                    productDesc: cat['desc']!,
                    productStock: cat['stok']!,
                  ),
                ),
              );
            },
            child: GridTile(
              footer: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cat['name']!,
                        style: const TextStyle(color: Colors.white)),
                    Text(cat['location']!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                    Text(cat['price']!,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              child: Image.network(cat['image']!, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
