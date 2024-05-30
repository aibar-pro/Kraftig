import 'package:flutter/material.dart';

import '../models/plan_model.dart';

class FitnessPlanViewModel extends ChangeNotifier {
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
    // Implement navigation to the fitness plan detail view
  }

  void setActivePlan(Plan plan) {
    activePlan = plan;
    state = PlanState.activePlan;
    notifyListeners();
  }
}