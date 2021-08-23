import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  String? locationName;
  Function()? onTap;

  LocationWidget({
    this.locationName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: locationName != null
          ? InkWell(
              onTap: onTap,
              child: Center(
                child: Container(
                  //width: 100.0,
                  height: 30.0,
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  margin: EdgeInsets.only(
                    right: 3.0,
                    left: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      locationName!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
