import 'package:flutter/material.dart';

class ProfileTabBarWidget extends StatelessWidget {

  int selectedIndex;
  Function(int val)? onTap;

  ProfileTabBarWidget({
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.grid_on,
              color: selectedIndex == 0 ? Colors.blueAccent : Colors.black26,),
            onPressed: () {
              if(onTap != null){
                onTap!.call(0);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.list, color: selectedIndex == 1 ? Colors.blueAccent : Colors.black26,),
            onPressed: () {
              onTap!.call(1);
            },
          ),
        ],
      ),
    );
  }
}
