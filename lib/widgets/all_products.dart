// import 'package:flutter/material.dart';

// import '../models/product.dart';
// import 'product_item.dart';

// class AllProducts extends StatelessWidget {
//   const AllProducts({super.key, required this.products});

//   final List<Product> products;

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     // List<Product> recentProducts = products.getRange(0, 2).toList();
//     // List<Product> otherProducts =
//     //     products.getRange(2, products.length).toList();

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Text(
//               'Recent Product Reviews',
//               style: theme.textTheme.titleSmall,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Column(
//             children: products.map((Product product) {
//               return ProductItem(product: product);
//             }).toList(),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Text(
//               'Most Helpful Reviews',
//               style: theme.textTheme.titleSmall,
//             ),
//           ),
//           const SizedBox(height: 10),
//           // Column(
//           //   children: otherProducts.map((Product product) {
//           //     return ProductItem(product: product);
//           //   }).toList(),
//           // ),
//           const SizedBox(height: 80),
//         ],
//       ),
//     );
//   }
// }
