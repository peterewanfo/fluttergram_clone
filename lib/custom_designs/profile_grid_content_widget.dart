import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/custom_designs/cached_image_widget.dart';
import 'package:fluttergram_clone/models/owner_user_model.dart';
import 'package:fluttergram_clone/services/repositories/user_repositories.dart';
import 'package:fluttergram_clone/view_model/feeds_viewmodel.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttergram_clone/models/feedModel.dart';

class ProfileGridContentWidget extends HookWidget {
  final FeedModel feedModel;

  ProfileGridContentWidget({required this.feedModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedImageWidget(
        img_url: feedModel.mediaUrl.toString(),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
