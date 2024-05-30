import 'package:flutter/material.dart';

import '../models/plan_model.dart';

class NutritionPlanViewModel extends ChangeNotifier {
  PlanState state = PlanState.invitation;
  Plan? activePlan;

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