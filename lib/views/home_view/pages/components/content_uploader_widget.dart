import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/custom_designs/location_widget.dart';
import 'package:fluttergram_clone/utils/location.dart';
import 'package:fluttergram_clone/view_model/feeds_viewmodel.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentUploaderWidget extends HookWidget {
  final addressProvider = StateProvider<String?>((ref) {
    return null;
  });

  File file;
  Function()? onBackPressed;
  Function(String location, String description) postContent;

  ContentUploaderWidget({
    required this.file,
    this.onBackPressed,
    required this.postContent,
  });

  @override
  Widget build(BuildContext context) {
    useProvider(feedViewModel);

    final locationTextEditingController = useTextEditingController();
    final descriptionTextEditingController = useTextEditingController();

    locationTextEditingController.text = "";
    descriptionTextEditingController.text = "";

    initPlatformState() async {
      // Address first = await getUserLocation();
      // context
      //     .read(addressProvider)
      //     .state = first;
      // setState(() {
      //   address = first;
      // });
    }

    initPlatformState();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: onBackPressed,
          ),
          title: const Text(
            'Post to',
            style: const TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                postContent.call(locationTextEditingController.text,
                    descriptionTextEditingController.text);
              },
              child: Text(
                "Post",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                context.read(feedViewModel).isImageUploading
                    ? LinearProgressIndicator()
                    : Padding(padding: EdgeInsets.only(top: 0.0)),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(context
                          .read(userViewModel)
                          .getCurrentUser()!
                          .photoURL
                          .toString()),
                    ),
                    Container(
                      width: 250.0,
                      child: TextField(
                        controller: descriptionTextEditingController,
                        decoration: InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      height: 45.0,
                      width: 45.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: FileImage(file),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.pin_drop),
                  title: Container(
                    width: 250.0,
                    child: TextField(
                      controller: locationTextEditingController,
                      decoration: InputDecoration(
                          hintText: "Where was this photo taken?",
                          border: InputBorder.none),
                    ),
                  ),
                )
              ],
            ),
            Divider(), //scroll view where we will show location to users
            (context.read(addressProvider).state == null)
                ? Container()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 5.0, left: 5.0),
                    child: Row(
                      children: <Widget>[

                        // LocationWidget(
                        //     locationName: context
                        //         .read(addressProvider)
                        //         .state!
                        //         .featureName),
                        // LocationWidget(
                        //     locationName: context
                        //         .read(addressProvider)
                        //         .state!
                        //         .subLocality),
                        // LocationWidget(
                        //     locationName:
                        //         context.read(addressProvider).state!.locality),
                        // LocationWidget(
                        //     locationName: context
                        //         .read(addressProvider)
                        //         .state!
                        //         .subAdminArea),
                        // LocationWidget(
                        //     locationName:
                        //         context.read(addressProvider).state!.adminArea),
                        // LocationWidget(
                        //     locationName: context
                        //         .read(addressProvider)
                        //         .state!
                        //         .countryName),
                      ],
                    ),
                  ),
            (context.read(addressProvider).state == null)
                ? Container()
                : Divider(),
          ],
        ));
    ;
  }
}
