import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStateNotifier extends ChangeNotifier {
  int current_page_index = 0;

  void changeCurrentPageIndex(int destination_index) {
    this.current_page_index = destination_index;
    notifyListeners();
  }

}

final appStateChangeNotifier = ChangeNotifierProvider<AppStateNotifier>((ref) {
  return AppStateNotifier();
});
