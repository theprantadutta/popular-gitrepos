import 'package:flutter/material.dart';

class ReusableCircleAvatar extends StatelessWidget {
  final String avatarUrl;
  final double radius;

  const ReusableCircleAvatar({
    super.key,
    required this.avatarUrl,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'avatar-hero-$avatarUrl',
      transitionOnUserGestures: true,
      child: Center(
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
            avatarUrl,
          ),
        ),
      ),
    );
  }
}
