import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/custom_designs/profile_list_content_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttergram_clone/models/feedModel.dart';
import 'package:fluttergram_clone/services/repositories/feed_repositories.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fluttergram',
          style: const TextStyle(
              fontFamily: "Billabong", color: Colors.black, fontSize: 35.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: FutureBuilder<List<FeedModel>>(
            future: context.read(feedsRepositoryProvider).getUserPost(
                profileId: context.read(userViewModel).getCurrentUser()!.uid),
            builder: (context, snapshot) {
              print(snapshot.data.toString() + "jjj");

              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Text("Sorry you have no posts available !!!"),
                    ],
                  ),
                );
              } else {
                return Container(
                  child: ListView(
                    padding: const EdgeInsets.all(0.5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.map(
                      (FeedModel feedModel) {
                        return ProfileListContentWidget(
                          feedModel: feedModel,
                        );
                      },
                    ).toList(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
