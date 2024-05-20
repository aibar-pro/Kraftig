
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kraftig/view_components/inline_edit_button.dart';
import 'package:provider/provider.dart';

import '../models/photo_group.dart';
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
                    _buildPhotoGallery(context, model),
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
              'Hello${model.userProfile?.name != null ? ', ${model.userProfile?.name}' : ''}!',
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

  Widget _buildPhotoGallery(BuildContext context, ProfileViewModel model) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Gallery',
                style: AppTextStyles.subheadline,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  padding: const EdgeInsets.only(
                    left: AppPadding.small,
                    top: AppPadding.small,
                    bottom: AppPadding.small,
                  ),
                  onPressed: () => model.takePhoto(), 
                  icon: const Icon(Icons.photo_camera, size: AppFontSizes.subheadline,),
                ),
                IconButton(
                  padding: const EdgeInsets.only(
                    left: AppPadding.small,
                    top: AppPadding.small,
                    bottom: AppPadding.small,
                  ),
                  onPressed: () => model.pickImage(), 
                  icon: const Icon(Icons.upload_file, size: AppFontSizes.subheadline,),
                ),
              ],
            ),
          ],
        ),
         ...model.photoGroups.map((group) => _buildPhotoGroup(context, group, model)).toList(),
        // Container(
        //   padding: const EdgeInsets.all(AppPadding.medium),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        //     color: AppColors.cardBackground,
        //   ),
        //   child: Stack(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           InlineEditButton(onPressed: () {}),
        //         ],
        //       ),
        //       const SizedBox(height: AppPadding.medium),
        //       GridView.builder(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //           crossAxisSpacing: 8,
        //           mainAxisSpacing: 8,
        //         ),
        //         itemCount: model.photos.length,
        //         itemBuilder: (context, index) {
        //           return GestureDetector(
        //             onTap: () {
        //               // Handle photo tap
        //             },
        //             child: Image.file(
        //               File(model.photos[index]),
        //               fit: BoxFit.cover,
        //             ),
        //           );
        //         },
        //       ),          
        //     ],
        //   ),
        // ),
      ],
    );
  }

   Widget _buildPhotoGroup(BuildContext context, PhotoGroup group, ProfileViewModel model) {
    return Container(
      margin: const EdgeInsets.only(top: AppPadding.large),
      padding: const EdgeInsets.all(AppPadding.medium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        color: AppColors.cardBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                group.name ?? DateFormat('dd MMM yyyy').format(group.date),
                style: AppTextStyles.body,
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to the photo group edit view
                },
              ),
            ],
          ),
          const SizedBox(height: AppPadding.medium),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: group.photos.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Handle photo tap
                },
                child: Image.file(
                  File(group.photos[index]),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
