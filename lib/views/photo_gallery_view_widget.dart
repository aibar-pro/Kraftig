import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/photo_group.dart';
import '../resources/constants.dart';
import '../view_models/photo_gallery_view_model.dart';

class PhotoGalleryViewWidget extends StatelessWidget {
  const PhotoGalleryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoGalleryViewModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: model.photoGroups.map((group) => _buildPhotoGroup(context, model, group)).toList(),
      ),
    );
  }

  Widget _buildPhotoGroup(BuildContext context, PhotoGalleryViewModel model, PhotoGroup group) {
    return Container(
      margin: const EdgeInsets.only(top: AppPadding.large),
      padding: const EdgeInsets.only(
        left: AppPadding.medium,
        right: AppPadding.medium,
        bottom: AppPadding.medium,
      ),
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
                onPressed: () => model.takePhoto(group.id.toString()), 
                icon: const Icon(Icons.photo_camera, size: AppFontSizes.body,),
              ),
              IconButton(
                padding: const EdgeInsets.only(
                  left: AppPadding.small,
                  top: AppPadding.small,
                  bottom: AppPadding.small,
                ),
                onPressed: () => model.pickImage(group.id.toString()), 
                icon: const Icon(Icons.upload_file, size: AppFontSizes.body,),
              ),
              // IconButton(
              //   icon: const Icon(Icons.edit),
              //   onPressed: () {
              //     // Handle rename logic
              //   },
              // ),
            ],
          ),
          const SizedBox(height: AppPadding.small),
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
              return FutureBuilder<Uint8List>(
                future: model.getDecryptedPhoto(group.photos[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    if (kDebugMode) {
                      print(snapshot.error.toString());
                    }
                    return const Center(child: Icon(Icons.error));
                  } else {
                    return Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}