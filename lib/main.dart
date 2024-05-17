import 'package:flutter/material.dart';
import 'package:kraftig/view_models/signup_view_model.dart';
import 'package:kraftig/views/signup_view.dart';
import 'package:provider/provider.dart';

import 'services/api_service.dart';
import 'view_models/home_view_model.dart';
import 'view_models/login_view_model.dart';
import 'view_models/profile_view_model.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'views/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: 'http://0.0.0.0:8080');
    final homeViewModel = HomeViewModel(apiService: apiService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => homeViewModel),
        ChangeNotifierProvider(create: (_) => LoginViewModel(apiService: apiService, homeViewModel: homeViewModel)),
        ChangeNotifierProvider(create: (_) => SignupViewModel(apiService: apiService)),
        ChangeNotifierProvider(create: (_) => ProfileViewModel(apiService: apiService, homeViewModel: homeViewModel)),
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
          '/home': (context) => HomeView(),
          '/login':(context) => LoginView(),
          '/signup':(context) => SignupView(),
          '/profile': (context) => ProfileView(),
        },
      ),
    );
  }
}

