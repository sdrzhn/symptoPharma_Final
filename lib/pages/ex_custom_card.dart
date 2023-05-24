// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CustomCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String subtitle;
//   final double rating;
//   final double price;

//   const CustomCard({
//     required this.imageUrl,
//     required this.title,
//     required this.subtitle,
//     required this.rating,
//     required this.price, required Null Function() onFavoritePressed, required bool isFavorite,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2.0,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Image.asset(
//             imageUrl,
//             fit: BoxFit.cover,
//             height: 91.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4.0),
//                 Text(
//                   subtitle,
//                   style: TextStyle(fontSize: 12.0),
//                 ),
//                 SizedBox(height: 8.0),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.star,
//                       color: Colors.yellow,
//                       size: 16.0,
//                     ),
//                     SizedBox(width: 4.0),
//                     Text(
//                       rating.toString(),
//                       style: TextStyle(fontSize: 14.0),
//                     ),
//                     SizedBox(width: 8.0),
//                     Text(
//                       '\$$price',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }