import 'package:flutter/material.dart';
import 'package:kraftig/resources/constants.dart';
import 'package:provider/provider.dart';
import 'package:popover/popover.dart';

import '../view_models/photo_gallery_view_model.dart';
import 'photo_gallery_edit_widget.dart';
import 'photo_gallery_view_widget.dart';

class PhotoGalleryView extends StatelessWidget {
  const PhotoGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoGalleryViewModel>(
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Uploaded Photos',
                  style: AppTextStyles.subheadline,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (model.photoGroups.isEmpty) 
                    IconButton(
                      onPressed: () => model.takePhoto(null),
                      icon: const Icon(Icons.photo_camera, size: AppFontSizes.subheadline,),
                    ),
                  if (model.photoGroups.isEmpty) 
                    IconButton(
                      onPressed: () => model.pickImage(null),
                      icon: const Icon(Icons.upload_file, size: AppFontSizes.subheadline,),
                    ),
                  if (model.photoGroups.isNotEmpty) 
                  //FIXME: Popover position 
                    IconButton(
                      onPressed: () => showPopover(
                        context: context,
                        bodyBuilder: (context) => 
                          Column(
                            children: [
                              TextButton.icon(
                                onPressed: () => model.toggleEditMode(), 
                                label: const Text("Edit gallery", style: AppTextStyles.body,),
                                icon: const Icon(Icons.edit, size: AppFontSizes.body,),
                              ),
                              TextButton.icon(
                                onPressed: () => model.createGroup(null, DateTime.now(), model.userLogin), 
                                label: const Text("Add group", style: AppTextStyles.body,),
                                icon: const Icon(Icons.edit, size: AppFontSizes.body,),
                              ),
                            ],
                          ), 
                      ),
                      icon: const Icon(Icons.more_vert, size: AppFontSizes.subheadline,),
                    ),
                ],
              ),
            ],
          ),
          model.isEditing ? const PhotoGalleryEditWidget() : const PhotoGalleryViewWidget(),
        ],
      ),
    );
  }
}