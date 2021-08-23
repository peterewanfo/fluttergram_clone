import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/view_model/app_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluttergram_clone/views/home_view/pages/favourite_page.dart';
import 'package:fluttergram_clone/views/home_view/pages/home_page.dart';
import 'package:fluttergram_clone/views/home_view/pages/profile_page.dart';
import 'package:fluttergram_clone/views/home_view/pages/search_page.dart';
import 'package:fluttergram_clone/views/home_view/pages/upload_page.dart';

class HomeView extends HookWidget {

  @override
  Widget build(BuildContext context) {
    useProvider(appStateChangeNotifier);

    final List<Widget> _pages = [
      HomePage(),
      SearchPage(),
      UploadPage(),
      FavouritePage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              //BODY CONTENT
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: _pages[
                  context
                      .read(appStateChangeNotifier)
                      .current_page_index],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (int page){
          context
              .read(appStateChangeNotifier)
              .changeCurrentPageIndex(page);
        },
        currentIndex: context
            .read(appStateChangeNotifier)
            .current_page_index,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (context
                      .read(appStateChangeNotifier)
                      .current_page_index == 0) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: (context
                      .read(appStateChangeNotifier)
                      .current_page_index == 1) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: (context
                      .read(appStateChangeNotifier)
                      .current_page_index == 2) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.star,
                  color: (context
                      .read(appStateChangeNotifier)
                      .current_page_index == 3) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: (context
                      .read(appStateChangeNotifier)
                      .current_page_index == 4) ? Colors.black : Colors.grey),
              backgroundColor: Colors.white),
        ],
      ),
    );
  }
}
