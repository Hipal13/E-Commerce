import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridView extends StatelessWidget {
  final List<dynamic> products;
  final bool isLoading;
  final bool isSorting;
  final Function(dynamic product) onProductTap;

  const ProductGridView({
    Key? key,
    required this.products,
    required this.isLoading,
    required this.isSorting,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading || isSorting
        ? GridView.builder(
      itemCount: 10, // Show placeholder for 10 products
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () => onProductTap(product),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: product["image"],
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Image.network(product['image']),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.gabarito(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$${product['price']}",
                    style: GoogleFonts.gabarito(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
