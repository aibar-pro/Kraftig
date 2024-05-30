enum PlanState {
  invitation,
  requestInProgress,
  activePlan,
}

class Plan {
  final String id;
  final String summary;

  Plan({required this.id, required this.summary});
}