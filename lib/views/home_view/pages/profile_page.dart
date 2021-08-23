import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/custom_designs/cached_image_widget.dart';
import 'package:fluttergram_clone/custom_designs/custom_button.dart';
import 'package:fluttergram_clone/custom_designs/profile_grid_content_widget.dart';
import 'package:fluttergram_clone/custom_designs/profile_info_widget.dart';
import 'package:fluttergram_clone/custom_designs/profile_list_content_widget.dart';
import 'package:fluttergram_clone/custom_designs/profile_tabbar_widget.dart';
import 'package:fluttergram_clone/models/feedModel.dart';
import 'package:fluttergram_clone/services/repositories/feed_repositories.dart';
import 'package:fluttergram_clone/style/__style.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookWidget {
  final selectedTabProvider = StateProvider<int>((ref) {
    return 0;
  });

  @override
  Widget build(BuildContext context) {
    useProvider(userViewModel);
    useProvider(selectedTabProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          context.read(userViewModel).getCurrentUser()!.displayName.toString(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    CachedImageWidget(
                      img_url: context
                          .read(userViewModel)
                          .getCurrentUser()!
                          .photoURL
                          .toString(),
                      width: 90,
                      height: 90,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ProfileInfoWidget(
                                  count: context
                                      .read(userViewModel)
                                      .total_post
                                      .toString(),
                                  label: "posts"),
                              ProfileInfoWidget(
                                  count: context
                                      .read(userViewModel)
                                      .total_followers
                                      .toString(),
                                  label: "followers"),
                              ProfileInfoWidget(
                                  count: context
                                      .read(userViewModel)
                                      .total_following
                                      .toString(),
                                  label: "following"),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CustomButton(
                            is_border_button: true,
                            button_height: 40.0,
                            button_color: Colors.white,
                            border_color: Colors.black.withOpacity(0.4),
                            title: "Edit Profile",
                            title_color: Colors.black,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  left: CustomDimensions.defaultMargin,
                ),
                child: Text(
                  context
                      .read(userViewModel)
                      .getCurrentUser()!
                      .displayName
                      .toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(),
              ProfileTabBarWidget(
                selectedIndex: context
                    .read(selectedTabProvider)
                    .state,
                onTap: (value) {
                  context
                      .read(selectedTabProvider)
                      .state = value;
                },
              ),
              Divider(),
              FutureBuilder<List<FeedModel>>(
                  future: context.read(feedsRepositoryProvider).getUserPost(
                      profileId:
                      context.read(userViewModel).getCurrentUser()!.uid),
                  builder: (context, snapshot) {
                    print(snapshot.data.toString() + "jjj");

                    if (!snapshot.hasData) {
                      return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40.0,
                              ),
                              Text("Sorry you have no posts available !!!"),
                            ],
                          ));
                    } else {
                      // return Text(snapshot.data.toString());

                      return Container(
                        child: context
                            .read(selectedTabProvider)
                            .state == 0 ? GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            padding: const EdgeInsets.all(0.5),
                            mainAxisSpacing: 1.5,
                            crossAxisSpacing: 1.5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.map(
                                  (FeedModel feedModel) {
                                return GridTile(
                                  child: ProfileGridContentWidget(
                                    feedModel: feedModel,
                                  ),
                                );
                              },
                            ).toList()) : ListView(
                            padding: const EdgeInsets.all(0.5),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.map(
                                  (FeedModel feedModel) {
                                return ProfileListContentWidget(
                                  feedModel: feedModel,
                                );
                              },
                            ).toList()),
                      );
                    }
                    })
            ],
          ),
        ),
      ),
    );
  }
}
