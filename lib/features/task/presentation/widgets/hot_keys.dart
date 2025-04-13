// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// CallbackHandle? hotKeyCallbackHandle;

// class CallbackShort extends StatefulWidget {
//   const CallbackShort({super.key});

//   @override
//   State<CallbackShort> createState() => _CallbackShortState();
// }

// class _CallbackShortState extends State<CallbackShort> {
//   @override
//   Widget build(BuildContext context) {
//     return CallbackShortcuts(
//       bindings: {
//         SingleActivator(LogicalKeyboardKey.arrowLeft): () {
//           onPrevious();
//         },
//         SingleActivator(LogicalKeyboardKey.arrowRight): () {
//           onNext();
//         },
//       },
//       child: Focus(
//           focusNode: hotKeyCallbackHandle,
//           autofocus: true,
//           child: Row(
//             children: [
//               IconButton(
//                   tooltip: 'Hot Key : <-',
//                   onPressed: () {},
//                   icon: Icon(Icons.arrow_back)),
//               IconButton(
//                   tooltip: 'HotKey : ->',
//                   onPressed: () {},
//                   icon: Icon(Icons.arrow_back))
//             ],
//           )),
//     );
//   }
// }
