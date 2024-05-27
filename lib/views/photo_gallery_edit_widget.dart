import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/photo_group.dart';
import '../resources/constants.dart';
import '../view_models/photo_gallery_view_model.dart';

class PhotoGalleryEditWidget extends StatelessWidget {
  const PhotoGalleryEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoGalleryViewModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: model.photoGroups.map((group) => _buildEditablePhotoGroup(context, group, model)).toList(),
      ),
    );
  }

  Widget _buildEditablePhotoGroup(BuildContext context, PhotoGroup group, PhotoGalleryViewModel model) {
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
              Expanded(child: 
                Text(
                  group.name ?? DateFormat('dd MMM yyyy').format(group.date),
                  style: AppTextStyles.body,
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(
                  left: AppPadding.small,
                  top: AppPadding.small,
                  bottom: AppPadding.small,
                ),
                onPressed: () => {}, 
                icon: const Icon(Icons.edit, size: AppFontSizes.body,),
              ),
              IconButton(
                padding: const EdgeInsets.only(
                  left: AppPadding.small,
                  top: AppPadding.small,
                  bottom: AppPadding.small,
                ),
                onPressed: () {
                  model.deleteGroup(group.date.toString());
                }, 
                icon: const Icon(Icons.delete, size: AppFontSizes.body,),
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
              return Stack(
                children: [
                  Image.file(
                    File(group.photos[index]),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        model.deletePhoto(group.photos[index], group.date.toString());
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}