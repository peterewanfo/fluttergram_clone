import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  String img_url;
  double width;
  double height;
  bool isCircular;

  CachedImageWidget(
      {required this.img_url,
      required this.width,
      required this.height,
      this.isCircular = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: img_url,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            width: width,
            height: height,
          );
        },
        placeholder: (context, url) => Center(
          child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.error,
            size: 40.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
