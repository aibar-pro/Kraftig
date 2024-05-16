import 'package:flutter/material.dart';

import '../services/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService apiService;

  HomeViewModel({required this.apiService});
}