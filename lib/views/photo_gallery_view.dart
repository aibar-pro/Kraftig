import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/photo_gallery_view_model.dart';
import '../resources/constants.dart';
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
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            final RenderBox button = context.findRenderObject() as RenderBox;
                            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                            final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);
                            final RelativeRect rect = RelativeRect.fromRect(
                              Rect.fromPoints(
                                position,
                                position.translate(button.size.width, button.size.height),
                              ),
                              Offset.zero & overlay.size,
                            );
                            showMenu(
                              context: context,
                              position: rect,
                              items: [
                                PopupMenuItem(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the popover
                                      model.toggleEditMode();
                                    },
                                    icon: const Icon(Icons.edit, size: AppFontSizes.body),
                                    label: const Text("Edit gallery", style: AppTextStyles.body),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the popover
                                      model.createGroup(null, DateTime.now(), model.userLogin);
                                    },
                                    icon: const Icon(Icons.add, size: AppFontSizes.body),
                                    label: const Text("Add group", style: AppTextStyles.body),
                                  ),
                                ),
                              ],
                            );
                          },
                          icon: const Icon(Icons.more_vert, size: AppFontSizes.subheadline),
                        );
                      },
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