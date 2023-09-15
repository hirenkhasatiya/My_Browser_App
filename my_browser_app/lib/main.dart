import 'package:flutter/material.dart';
import 'package:my_browser_app/controller/web_controller.dart';
import 'package:my_browser_app/views/screens/browser_Page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => pagecontroller(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => BrowserPage(),
      },
    );
  }
}
