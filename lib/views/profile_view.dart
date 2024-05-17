import 'package:flutter/material.dart';
import 'package:kraftig/view_components/primary_button.dart';
import 'package:provider/provider.dart';

import '../resources/constants.dart';
import '../view_models/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Container(
        decoration: AppViewBackgrounds.mainViewBackground,
        child: Scaffold (
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title: 
              const Text(
                'Profile', 
                style: AppTextStyles.headline,
              ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.small,
                left: AppPadding.extraLarge,
                right: AppPadding.extraLarge,
              ), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${model.userProfile?.name?? model.userProfile?.login}!',
                    maxLines: 1,
                    style: AppTextStyles.headline
                  ),
                  const SizedBox(height: AppPadding.large),
                  TextField(
                    onChanged: (value) => model.setName(value),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                    ),
                    controller: TextEditingController(text: model.userProfile?.name ?? ''),
                  ),
                  const SizedBox(height: AppPadding.medium),
                  TextField(
                    onChanged: (value) => model.setAge(int.parse(value)),
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                      ),
                    ),
                    controller: TextEditingController(text: model.userProfile?.age?.toString() ?? ''),
                  ),
                  const SizedBox(height: AppPadding.large),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                        text: 'Save', 
                        onPressed: () async {
                          bool success = await model.updateProfile();
                          if (!context.mounted) return;
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated successfully')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to update profile')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}