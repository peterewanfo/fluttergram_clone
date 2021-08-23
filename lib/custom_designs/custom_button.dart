import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttergram_clone/style/__style.dart';

class CustomButton extends HookWidget {
  String title;
  Function()? onTap; //VoidCallback
  Color title_color;
  Color button_color;
  Color border_color;
  double button_height;
  double button_width;
  bool is_processing;
  double border_radius;
  Widget preffix_icon;
  bool is_border_button;

  CustomButton({
    this.title = "",
    this.onTap,
    this.title_color = CustomColors.primaryColor,
    this.button_color = CustomColors.buttonColor,
    this.border_color = Colors.black,
    this.button_height = 50.0,
    this.button_width = double.infinity,
    this.is_processing = false,
    this.border_radius = 10.0,
    this.preffix_icon = const SizedBox(),
    this.is_border_button = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        child: Container(
          width: button_width,
          height: button_height,
          decoration: BoxDecoration(
            color: button_color,
            borderRadius: BorderRadius.circular(border_radius),
            border: is_border_button
                ? Border.all(
              color: border_color,
            )
                : Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              preffix_icon,
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      this.is_processing
                          ? SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.transparent,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              title
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
