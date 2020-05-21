import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({
    @required this.radius,
    this.photoUrl,
  });

  final double radius;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
        )
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.indigo,
        backgroundImage: photoUrl!=null ? NetworkImage(photoUrl) : AssetImage('assets/img/default_avatar.jpg'),
      ),
    );
  }
}
