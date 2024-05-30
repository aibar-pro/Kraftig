import 'package:flutter/material.dart';
import 'package:kraftig/resources/constants.dart';
import 'package:provider/provider.dart';

import '../models/plan_model.dart';
import '../view_models/nutrition_plan_view_model.dart';

class NutritionBanner extends StatelessWidget {
  const NutritionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NutritionPlanViewModel>(
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
              color: Colors.blueAccent.shade200,
              borderRadius: BorderRadius.circular(AppBorderRadius.large),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: AppPadding.small),
                      child: 
                        Icon(Icons.food_bank, size: AppFontSizes.body, color: AppColors.whiteText,),
                    ),
                    Text(
                      'Nutrition Plan',
                      style: TextStyle(fontSize: AppFontSizes.subheadline, fontWeight: FontWeight.w600, color: AppColors.whiteText,),
                    ),
                  ],  
                ),
                const SizedBox(height: AppPadding.small),
                if (model.state == PlanState.invitation)
                  const Text(
                    'Apply for a Nutrition Plan',
                    style: TextStyle(fontSize: AppFontSizes.body, color: AppColors.whiteText,),
                  )
                else if (model.state == PlanState.requestInProgress)
                  const Text(
                    'Your Nutrition Plan Request is in progress',
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