// import 'package:flutter/material.dart';
// import 'package:symptopharm/pages/product_display_page.dart';
// import 'package:symptopharm/pages/profile_page.dart';
// import 'ex_custom_card.dart';

// class MyWidget1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 1,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProductDisplayPage()),
//               );
//             },
//             icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81))),
//         centerTitle: true,
//         title: Text(
//           'Витамины',
//           style: TextStyle(
//             color: Colors.black, // Set the text color to black
//           ),
//         ),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         padding: EdgeInsets.all(16.0),
//         children: [
//           CustomCard(
//             imageUrl: 'assets/acipol.jpg',
//             title: 'БАД Аципол® Малыш',
//             subtitle: 'БАД',
//             rating: 4.5,
//             price: 7100, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/kompl.jpg',
//             title: 'БАД Компливит® Суперэнергия с гуараной',
//             subtitle: 'БАД',
//             rating: 4.2,
//             price: 4030, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/antis.jpg',
//             title: 'БАД Компливит® Антистресс',
//             subtitle: 'БАД',
//             rating: 3.9,
//             price: 2860, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/45.jpg',
//             title: 'БАД Компливит® для женщин 45 плюс',
//             subtitle: 'БАД',
//             rating: 4.5,
//             price: 2270, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/dia.jpg',
//             title: 'БАД Компливит® Диабет',
//             subtitle: 'БАД',
//             rating: 2,
//             price: 2790, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/sun.jpg',
//             title: ' БАД Асвитол® Солнышко',
//             subtitle: 'БАД',
//             rating: 2.9,
//             price: 900, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/komli.jpg',
//             title: ' БАД Компливит®',
//             subtitle: 'БАД',
//             rating: 4.7,
//             price: 2390, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           CustomCard(
//             imageUrl: 'assets/deti.jpg',
//             title: ' БАД Компливит® АКТИВные Детишки',
//             subtitle: 'БАД',
//             rating: 4.87,
//             price: 3770,  isFavorite: true, onFavoritePressed: () {  },
//           ),
//             CustomCard(
//             imageUrl: 'assets/otc.jpg',
//             title: ' Асвитол®',
//             subtitle: 'Витамины',
//             rating: 4.92,
//             price: 400, isFavorite: true, onFavoritePressed: () {  },
//           ),
//           // Add more CustomCard widgets as needed
//         ],
//       ),
//     );
//   }
// }