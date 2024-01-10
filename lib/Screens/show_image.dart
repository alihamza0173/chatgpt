import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BeautifulImageScreen extends StatelessWidget {
  final String img;
  const BeautifulImageScreen({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Beautiful Image'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: img,
              child: CachedNetworkImage(imageUrl: img,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                height: 600,
                width: 600,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
