import 'package:cssd/provider/splash_provider.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/navigation_observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
      ],
      child: MaterialApp(
        //  title: 'Centralized Sterilization and Supply Department',
        title: 'CSSD',
        navigatorObservers: [MyNavigatorObserver()],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.cssdDashboard,
        routes: Routes.routes,
      ),
    );
  }
}
