// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:red_software_assessment/cubit/food.dart';
//
// class FoodItem extends StatelessWidget {
//   final Food food;
//
//   const FoodItem({super.key, required this.food});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//         ),
//         width: 183,
//         height: 196,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 163,
//               width: 108,
//               child: Image.network(
//                 food.imageUrl,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   food.foodName,
//                   style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   "${food.calories}Cal",
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff959595)),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "25\$",
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Container(
//                       height: 32,
//                       width: 65,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: const Color(0xffF25700),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Add",
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
