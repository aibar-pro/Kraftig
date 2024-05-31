import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/api_service.dart';
import 'view_models/fitness_plan_view_model.dart';
import 'view_models/home_view_model.dart';
import 'view_models/login_view_model.dart';
import 'view_models/nutrition_plan_view_model.dart';
import 'view_models/profile_view_model.dart';
import 'view_models/photo_gallery_view_model.dart';
import 'view_models/signup_view_model.dart';
import 'views/signup_view.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'views/profile_view.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: 'http://0.0.0.0:8080');
    final homeViewModel = HomeViewModel(apiService: apiService);
    final profileViewModel = ProfileViewModel(apiService: apiService, homeViewModel: homeViewModel);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => homeViewModel),
        ChangeNotifierProvider(create: (_) => LoginViewModel(apiService: apiService, homeViewModel: homeViewModel)),
        ChangeNotifierProvider(create: (_) => SignupViewModel(apiService: apiService)),
        ChangeNotifierProvider(create: (_) => profileViewModel),
        ChangeNotifierProvider(create: (_) => PhotoGalleryViewModel(profileViewModel: profileViewModel)),
        ChangeNotifierProvider(create: (_) => NutritionPlanViewModel(homeViewModel: homeViewModel)),
        ChangeNotifierProvider(create: (_) => FitnessPlanViewModel(homeViewModel: homeViewModel)),
      ],
      child: MaterialApp(
        title: 'Kraftig',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeView(),
        routes: {
          '/home': (context) => const HomeView(),
          '/login':(context) => const LoginView(),
          '/signup':(context) => const SignupView(),
          '/profile': (context) => const ProfileView(),
        },
      ),
    );
  }
}

