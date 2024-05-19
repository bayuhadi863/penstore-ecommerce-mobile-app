// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ButtonBottomWidget extends StatefulWidget {

//   const ButtonBottomWidget({super.key});

//   @override
//   State<ButtonBottomWidget> createState() => _ButtonBottomWidgetState();
// }

// class _ButtonBottomWidgetState extends State<ButtonBottomWidget> {

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryHeight = MediaQuery.of(context).size.height;
//     final mediaQueryWidth = MediaQuery.of(context).size.width;
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         width: mediaQueryWidth * 0.9,
//         height: mediaQueryHeight * 0.088,
//         margin: const EdgeInsets.only(bottom: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF91E0DD).withOpacity(0.3),
//               blurRadius: 16,
//               offset: const Offset(1, 1),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 24,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF91E0DD).withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Checkbox(
//                     value: isCheckedAll,
//                     onChanged: _onCheckedAllChanged,
//                     activeColor: Colors.transparent,
//                     checkColor: const Color(0xFF6BCCC9),
//                     side: BorderSide.none,
//                   ),
//                 ),
//                 SizedBox(width: mediaQueryWidth * 0.02),
//                 Text(
//                   'Semua',
//                   style: const TextStyle(
//                     color: Color(0xFF424242),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                   ),
//                 )
//               ],
//             ),
//             Container(
//               width: mediaQueryWidth * 0.351,
//               height: mediaQueryHeight * 0.048,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border.all(
//                   color: const Color(0xFF6BCCC9),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: const Text(
//                   'Rp 80.000.000,-',
//                   style: TextStyle(
//                     color: Color(0xFF6BCCC9),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                   ),
//                   maxLines: 1,
//                 ),
//               ),
//             ),
//             Container(
//               width: mediaQueryWidth * 0.251,
//               height: mediaQueryHeight * 0.048,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF6BCCC9),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   Get.toNamed('/checkout');
//                 },
//                 child: const Text(
//                   'Periksa',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
