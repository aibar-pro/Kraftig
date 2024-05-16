import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/api_service.dart';
import 'view_models/home_view_model.dart';
import 'view_models/login_view_model.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: '0.0.0.0:8080');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(apiService: apiService)),
        ChangeNotifierProvider(create: (_) => LoginViewModel(apiService: apiService)),
    ],
    child: MaterialApp(
      title: 'Karftig',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
      routes: {
        '/login':(context) => LoginView(),
        '/home': (context) => HomeView()
      },
    ),
    );
  }
}

