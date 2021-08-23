import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/view_model/feeds_viewmodel.dart';
import 'package:fluttergram_clone/views/home_view/pages/upload_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentImagePickerWidget extends HookWidget {
  ImagePicker imagePicker = ImagePicker();

  Function(File? file) selectedImage;

  ContentImagePickerWidget({
    required this.selectedImage,
});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Create a Post'),
                      children: [
                        SimpleDialogOption(
                            child: const Text('Take a photo'),
                            onPressed: () async {
                              Navigator.pop(context);
                              PickedFile? imageFile = await imagePicker.getImage(
                                  source: ImageSource.camera,
                                  maxWidth: 1920,
                                  maxHeight: 1200,
                                  imageQuality: 80);

                              if (imageFile != null) {
                                selectedImage.call(File(imageFile.path) );
                              }
                            }),
                        SimpleDialogOption(
                            child: const Text('Choose from Gallery'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              PickedFile? imageFile = await imagePicker.getImage(
                                source: ImageSource.gallery,
                                maxWidth: 1920,
                                maxHeight: 1200,
                                imageQuality: 80,
                              );

                              if (imageFile != null) {
                                selectedImage.call(File(imageFile.path) );
                              }
                            }),
                        SimpleDialogOption(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  })
            },
          ),
          Text("UPLOAD")
        ],
      ),
    );
  }
}
