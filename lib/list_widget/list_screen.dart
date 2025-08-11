import 'package:flutter/material.dart';
import 'package:learn_flutter/main_layout.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key, required Map<String, String> data});

  final List<Map<String, String>> articles = [
    {
      'title': 'Roblox Military',
      'description': 'Shap',
      'image': 'https://i.imgflip.com/8qpcqb.jpg',
    },
    {
      'title': 'Mie Ayam',
      'description': 'Lapar',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlPkL1JxjaeA_k_n6dbHYNzessJXYJGDNCQTRt_CDoeaPYf5onwHdS3PP_Y443tm9onnc&usqp=CAU',
    },
    {
      'title': 'GET A JOB',
      'description': 'GET A JOB',
      'image':
          'https://tr.rbxcdn.com/180DAY-d92b1e0a1cad806ea3f331639df0e1fd/500/280/Image/Jpeg/noFilter',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Artikel',
      body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleListScreen(data: article),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6)
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        image: DecorationImage(
                          image: NetworkImage(article['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(article['title']!,
                              style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
