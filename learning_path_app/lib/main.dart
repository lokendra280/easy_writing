import 'package:flutter/material.dart';
import 'package:learning_path_app/pages/splash_page.dart';
import 'package:learning_path_app/provider/provider_setup.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Purchases.configure(
      PurchasesConfiguration('appl_lYCFkXYStpSCThkzEbUTozbfAaL'));
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
      ),
    );
  }
}
