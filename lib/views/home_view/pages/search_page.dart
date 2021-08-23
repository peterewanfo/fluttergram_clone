import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Form(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Search for a user...'),
            // onFieldSubmitted: submit,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Search users"),
          )
        ],
      ),
    );
  }
}
