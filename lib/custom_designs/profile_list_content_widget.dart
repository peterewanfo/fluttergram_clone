import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/models/owner_user_model.dart';
import 'package:fluttergram_clone/services/repositories/user_repositories.dart';
import 'package:fluttergram_clone/view_model/feeds_viewmodel.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttergram_clone/models/feedModel.dart';

class ProfileListContentWidget extends HookWidget {
  final FeedModel feedModel;

  ProfileListContentWidget({required this.feedModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder<OwnerUserModel?>(
            future: context
                .read(userAccessRepositoryProvider)
                .getUserByOwnerId(owner_id: feedModel.ownerId.toString()),
            builder: (context, snapshot) {
              OwnerUserModel? ownerUserModel = snapshot.data;

              if (ownerUserModel != null) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        ownerUserModel.photo_url.toString()),
                    backgroundColor: Colors.grey,
                  ),
                  title: GestureDetector(
                    child: Text(
                      ownerUserModel.username.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // openProfile(context, ownerId);
                    },
                  ),
                  subtitle: Text(feedModel.location.toString()),
                  trailing: const Icon(Icons.more_vert),
                );
              }

              // snapshot data is null here
              return Container();
            },
          ),
          GestureDetector(
            onDoubleTap: () {
              context.read(feedViewModel).likeContent(
                    context
                        .read(userViewModel)
                        .getCurrentUser()!
                        .uid
                        .toString(),
                    feedModel.postId.toString(),
                    true,
                  );
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: feedModel.mediaUrl.toString(),
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: CupertinoActivityIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                (context.read(feedViewModel).likeClicked == feedModel.postId.toString())
                    ? Positioned(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Opacity(
                              opacity: 0.85,
                              child: FlareActor(
                                "assets/flare/Like.flr",
                                animation: "Like",
                              )),
                        ),
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
