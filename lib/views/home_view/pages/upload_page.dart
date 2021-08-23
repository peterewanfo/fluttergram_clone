import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/models/feedModel.dart';
import 'package:fluttergram_clone/view_model/feeds_viewmodel.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:fluttergram_clone/views/home_view/pages/components/content_img_picker_widget.dart';
import 'package:fluttergram_clone/views/home_view/pages/components/content_uploader_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final fileContentProvider = StateProvider<File?>((ref) {
  return null;
});

class UploadPage extends HookWidget {

  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    useProvider(feedViewModel);
    useProvider(fileContentProvider);

    return context.read(fileContentProvider).state == null
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Content upload",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContentImagePickerWidget(
                      selectedImage: (File? file) {
                        context.read(fileContentProvider).state = file;
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : ContentUploaderWidget(
            file: context.read(fileContentProvider).state!,
            onBackPressed: () {
              context.read(fileContentProvider).state = null;
            },
            postContent: (String location, String description) async {

              await context.read(feedViewModel).uploadContent(
                  context.read(fileContentProvider).state!, FeedModel(
                username: context.read(userViewModel).getCurrentUser()!.uid.toString(),
                location: location,
                description: description,
                ownerId: context.read(userViewModel).getCurrentUser()!.uid.toString()
              ));

              //IMAGE UPLOADED SUCCESSFULLY
              context.read(fileContentProvider).state = null;

              Fluttertoast.showToast(msg: "Post successfully uploaded");

            },
          );
  }
}
