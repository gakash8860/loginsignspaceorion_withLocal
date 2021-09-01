// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class ZAnimatedToggle extends StatefulWidget {
//   final List<String> values;
//   final ValueChanged onToggleBack;
//
//   const ZAnimatedToggle({Key key, this.values, this.onToggleBack}) : super(key: key);
//
//   @override
//   _ZAnimatedToggleState createState() => _ZAnimatedToggleState();
// }
//
// class _ZAnimatedToggleState extends State<ZAnimatedToggle> {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider=Provider.of<ThemeProvider>(context);
//     double width=MediaQuery.of(context).size.width;
//     return Container(
//       height: width*0.13,
//       width: width*0.7,
//       child: Stack(
//         children: <Widget>[
//           GestureDetector(
//             onTap: (){
//                 widget.onToggleBack(1);
//             },
//             child: Container(
//               height: width*0.13,
//               width: width*0.7,
//               decoration: ShapeDecoration(
//                 color: themeProvider.themeMode().toggleBackgroundColor,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width*0.1)),
//               ),
//               child: Row(
//                 children:
//                   List.generate(widget.values.length,(index)=>Padding(padding: EdgeInsets.symmetric(horizontal: width*0.1),
//                   child: Text(widget.values[index],style: TextStyle(fontSize: width*0.5,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF918f95),
//                   ),),
//                   ))
//               ),
//             ),
//           ),
//           AnimatedAlign(alignment: themeProvider.isLightTheme?Alignment.centerLeft:Alignment.centerRight,
//             duration: Duration(milliseconds: 350),
//             curve: Curves.ease,
//             child: Container(width: width*0.35,height: width*0.13,
//               decoration: ShapeDecoration(
//                 color: themeProvider.themeMode().toggleButtonColor,
//                 shadows: themeProvider.themeMode().shadow,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(width*0.1)
//                 )
//               ),
//               child: Text(themeProvider.isLightTheme?widget.values[0]:widget.values[1]
//               ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.45),
//               ),
//
//           ),
//
//           )
//         ],
//       ),
//     );
//   }
// }
