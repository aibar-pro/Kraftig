import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/plan_model.dart';
import '../resources/constants.dart';
import '../view_models/fitness_plan_view_model.dart';

class FitnessBanner extends StatelessWidget {
  const FitnessBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessPlanViewModel>(
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            if (model.state == PlanState.invitation) {
              model.requestNewPlan();
            } else if (model.state == PlanState.requestInProgress) {
              model.viewRequestStatus();
            } else if (model.state == PlanState.activePlan) {
              model.viewPlanDetails();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppPadding.medium,),
            decoration: BoxDecoration(
              color: Colors.orangeAccent.shade200,
              borderRadius: BorderRadius.circular(AppBorderRadius.large),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: AppPadding.small),
                      child: 
                        Icon(Icons.fitness_center, size: AppFontSizes.body, color: AppColors.whiteText,),
                    ),
                    Text(
                      'Fitness Plan',
                      style: TextStyle(fontSize: AppFontSizes.subheadline, fontWeight: FontWeight.w600, color: AppColors.whiteText,),
                    ),
                  ],
                ),
                const SizedBox(height: AppPadding.small),
                if (model.state == PlanState.invitation)
                  const Text(
                    'Apply for a Fitness Plan',
                    style: TextStyle(fontSize: AppFontSizes.body, color: AppColors.whiteText,),
                  )
                else if (model.state == PlanState.requestInProgress)
                  const Text(
                    'Your Fitness Plan Request is in progress',
                    style: TextStyle(fontSize: AppFontSizes.body, color: AppColors.whiteText,),
                  )
                else if (model.state == PlanState.activePlan && model.activePlan != null)
                  Text(
                    'Active Plan: ${model.activePlan!.summary}',
                    style: const TextStyle(fontSize: AppFontSizes.body, color: AppColors.whiteText,),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}