
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/constants.dart';
import '../view_models/profile_view_model.dart';
import '../view_components/primary_button.dart';
import '../view_components/secondary_button.dart';
import '../view_components/weight_picker_wrapper.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Container(
        decoration: AppViewBackgrounds.mainViewBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title: const Text(
              'Profile',
              style: AppTextStyles.headline,
            ),
            actions: [
              if (!model.isEditing)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: model.toggleEditMode,
                ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.small,
                left: AppPadding.extraLarge,
                right: AppPadding.extraLarge,
              ),
              child: model.isEditing ? _buildEditView(context, model) : _buildViewMode(model),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewMode(ProfileViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, ${model.userProfile?.name ?? model.userProfile?.login}!',
          maxLines: 1,
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppPadding.large),
        Text(
          'Age: ${model.userProfile?.age ?? ''}',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: AppPadding.medium),
        Text(
          'Height: ${model.userProfile?.height ?? ''}',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: AppPadding.medium),
        Text(
          'Weight: ${model.userProfile?.weight ?? ''}',
          style: AppTextStyles.body,
        ),
      ],
    );
  }

  Widget _buildEditView(BuildContext context, ProfileViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edit Profile',
          style: AppTextStyles.headline,
        ),
        const SizedBox(height: AppPadding.large),
        TextFormField(
          initialValue: model.userProfile?.name ?? '',
          onChanged: (value) => model.setName(value),
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            ),
          ),
        ),
        const SizedBox(height: AppPadding.medium),
        TextFormField(
          initialValue: model.userProfile?.age?.toString() ?? '',
          onChanged: (value) => model.setAge(int.parse(value)),
          decoration: InputDecoration(
            labelText: 'Age',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppPadding.medium),
        TextFormField(
          initialValue: model.userProfile?.height?.toString() ?? '',
          onChanged: (value) => model.setHeight(double.parse(value)),
          decoration: InputDecoration(
            labelText: 'Height',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppPadding.medium),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: AppBorderRadius.medium),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textMediumEmphasis),
                borderRadius: BorderRadius.circular(AppBorderRadius.medium),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.extraLarge),
                child: WeightPickerWrapper(
                  initialValue: model.userProfile?.weight ?? 70, 
                  min: 0, 
                  max: 500, 
                  onChange: (value) => model.setWeight(value),
                ),
              ),
            ),
            const Positioned(
              top: AppBorderRadius.medium * 1.5,
              left: AppBorderRadius.medium * 0.5,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: AppBorderRadius.medium,
                  left: AppBorderRadius.medium,
                  right: AppBorderRadius.medium,
                ),
                child: Text(
                  'Weight',
                  style: AppTextStyles.hintText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppPadding.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SecondaryButton(
              text: 'Cancel',
              onPressed: model.toggleEditMode,
            ),
            const SizedBox(width: AppPadding.medium),
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
    );
  }
}
