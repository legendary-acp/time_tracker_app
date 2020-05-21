import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  EmptyContent(
      {Key key,
      this.title = 'Nothing Here',
      this.message = 'Add a new Item to see something'})
      : super(key: key);

  final title;
  final message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 32.0,
            ),
          ),
          Text(
          message,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.0,
          ),
          )
        ],
      ),
    );
  }
}
