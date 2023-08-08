import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                child: CustomCarousel(urls: product.images),
              ),
            ),
            const SizedBox(height: 30),
            Text('brand: \n${product.brand}'),
            const SizedBox(height: 30),
            Text('Category: \n${product.category}'),
            const SizedBox(height: 30),
            Text('Description: \n${product.description}'),
            const SizedBox(height: 30),
            Text('price: \n\$${product.price.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('rating: \n${product.rating.toStringAsFixed(2)}'),
            const SizedBox(height: 30),
            Text('stock: \n${product.stock}'),
          ],
        ),
      ),
    );
  }
}

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key, required this.urls});
  final List<String> urls;

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.urls.length,
      itemBuilder: (context, index) => CachedNetworkImage(
        imageUrl: widget.urls[index],
        fit: BoxFit.fill,
        placeholder: (context, url) => const LinearProgressIndicator(
          color: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
