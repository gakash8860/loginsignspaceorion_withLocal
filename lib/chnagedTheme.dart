// import 'package:flutter/material.dart';
// import 'package:loginsignspaceorion/modelProviders/theme_providers.dart';
// import 'package:loginsignspaceorion/pages/homeTheme.dart';
// import 'package:path_provider/path_provider.dart' as pathProvider;
// import 'package:provider/provider.dart';
// import 'package:hive/hive.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//     final appDocumentary=await pathProvider.getApplicationDocumentsDirectory();
//     Hive.init(appDocumentary.path);
//     final settings= await Hive.openBox('settings');
//     bool isLightTheme=settings.get('isLightTheme')?? false;
//
//   runApp(ChangeNotifierProvider(create: (_)=>ThemeProvider(isLightTheme: isLightTheme),
//     child: AppStart(),
//   ));
// }
//
// class AppStart extends StatelessWidget{
//   const AppStart({Key key}) : super(key: key);
// @override
//   Widget build(BuildContext context) {
//     ThemeProvider themeProvider =Provider.of<ThemeProvider>(context);
//     return ChangedTheme();
//   }
//
// }
//
// class ChangedTheme extends StatefulWidget with WidgetsBindingObserver{
//   final ThemeProvider themeProvider;
//
//   const ChangedTheme({Key key, this.themeProvider}) : super(key: key);
//   @override
//   _ChangedThemeState createState() => _ChangedThemeState();
// }
//
// class _ChangedThemeState extends State<ChangedTheme> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: widget.themeProvider.themeData(),
//       home: HomeTheme(),
//     );
//   }
// }
