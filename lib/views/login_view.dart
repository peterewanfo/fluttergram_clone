import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/custom_designs/cached_image_widget.dart';
import 'package:fluttergram_clone/routes/routes.dart';
import 'package:fluttergram_clone/services/repositories/user_repositories.dart';
import 'package:fluttergram_clone/view_model/user_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttergram_clone/custom_designs/custom_button.dart';
import 'package:fluttergram_clone/style/__style.dart';

class LoginView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useProvider(userViewModel);

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Fluttergram',
                style: CustomStyle.logoTextStyle,
              ),
              SizedBox(
                height: 100,
              ),
              StreamBuilder(
                  stream: context
                      .read(userAccessRepositoryProvider)
                      .authStateChanges,
                  builder: (context, snapshot) {
                    User? user =
                        context.read(userViewModel).getCurrentUser();
                    if (snapshot.hasData && user != null) {
                      print(user.photoURL);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Loggedin as:"),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: context
                                        .read(userViewModel)
                                        .getCurrentUser() !=
                                    null
                                ? CachedImageWidget(
                                    img_url: user.photoURL.toString(),
                                    width: 100,
                                    height: 100,
                                  )
                                : Center(
                                    child: Text("Pic"),
                                  ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(user.displayName.toString()),
                          SizedBox(
                            height: 20.0,
                          ),
                          CustomButton(
                            button_width: 100,
                            title: "Go to Home",
                            onTap: (){
                              Navigator.of(context).pushNamed(Routes.home_view);
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          InkWell(
                            onTap: ()async{
                              await context
                                  .read(userViewModel)
                                  .signOut();
                            },
                            child: Text(
                              "LOGOUT",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return InkWell(
                        onTap: () async {
                          await context
                              .read(userViewModel)
                              .signInWithGoogle();

                          final data = await context
                              .read(userViewModel)
                              .getCurrentUser();

                          if (data != null) {
                            context
                                .read(userViewModel)
                                .logged_in = true;
                            // Navigator.of(context).pushNamed(Routes.home_view);
                          }

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/google_signin_button.png",
                              width: 225.0,
                            ),
                            context.read(userViewModel).is_loading
                                ? SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.redAccent),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
