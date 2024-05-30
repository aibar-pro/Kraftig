import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/constants.dart';
import '../view_models/profile_view_model.dart';
import '../view_components/primary_button.dart';
import '../view_components/secondary_button.dart';
import '../view_components/weight_picker_wrapper.dart';
import '../view_components/inline_edit_button.dart';
import '../views/photo_gallery_view.dart';

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
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.small,
                left: AppPadding.extraLarge,
                right: AppPadding.extraLarge,
              ),
              child: ListView(
                children: [
                  if (model.isEditing) 
                    _buildEditView(context, model)
                  else ...[
                    _buildViewMode(context, model),
                    const SizedBox(height: AppPadding.large),
                    const PhotoGalleryView(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewMode(BuildContext context, ProfileViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello${model.userProfile?.username != null ? ', ${model.userProfile?.username}' : ''}!',
              maxLines: 1,
              style: AppTextStyles.headline,
            ),
            TextButton.icon(
              onPressed: () { 
                model.homeViewModel.logout();
                Navigator.pop(context);
              }, 
              label: const Text('logout', style: AppTextStyles.body,),
              icon: const Icon(Icons.logout, size: AppFontSizes.body,),
            ),
          ],
        ),
        
        const SizedBox(height: AppPadding.large),
        Container(
          padding: const EdgeInsets.all(AppPadding.medium,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            color: AppColors.cardBackground,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Age: ${model.userProfile?.age ?? ''}',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(width: AppPadding.medium,),
                        Text(
                          'Height: ${model.userProfile?.height ?? '-'}',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppPadding.medium,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Weight: ${model.userProfile?.weight ?? '-'}',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InlineEditButton(onPressed: model.toggleEditMode),
            ],
          ),
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
          initialValue: model.userProfile?.username ?? '',
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
                    SnackBar(
                      content: const Text('Profile updated successfully'),
                      backgroundColor: Colors.green.shade300,
                    ),
                  );
                  model.toggleEditMode();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Failed to update profile'),
                      backgroundColor: Colors.red.shade300,
                    ),
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
