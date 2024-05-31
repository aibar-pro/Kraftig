import 'package:flutter/material.dart';
import 'package:kraftig/models/user_profile_model.dart';

import '../models/plan_model.dart';
import 'home_view_model.dart';

class FitnessPlanViewModel extends ChangeNotifier {
  final HomeViewModel homeViewModel;

  PlanState state = PlanState.invitation;
  Plan? activePlan;

  FitnessPlanViewModel({required this.homeViewModel});

  UserProfileModel? get userProfile => homeViewModel.userProfile;

  void requestNewPlan() {
    state = PlanState.requestInProgress;
    notifyListeners();
  }

  void viewRequestStatus() {
    // Implement navigation to the request status view
  }

  void viewPlanDetails() {
    // Implement navigation to the fitness plan detail view
  }

  void setActivePlan(Plan plan) {
    activePlan = plan;
    state = PlanState.activePlan;
    notifyListeners();
  }
}