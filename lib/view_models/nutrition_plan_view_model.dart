import 'package:flutter/material.dart';

import '../models/plan_model.dart';
import '../models/user_profile_model.dart';
import 'home_view_model.dart';

class NutritionPlanViewModel extends ChangeNotifier {
  final HomeViewModel homeViewModel;

  PlanState state = PlanState.invitation;
  Plan? activePlan;

  NutritionPlanViewModel({required this.homeViewModel});

  UserProfileModel? get userProfile => homeViewModel.userProfile;

  void requestNewPlan() {
    state = PlanState.requestInProgress;
    notifyListeners();
  }

  void viewRequestStatus() {
    // Implement navigation to the request status view
  }

  void viewPlanDetails() {
    // Implement navigation to the nutrition plan detail view
  }

  void setActivePlan(Plan plan) {
    activePlan = plan;
    state = PlanState.activePlan;
    notifyListeners();
  }
}