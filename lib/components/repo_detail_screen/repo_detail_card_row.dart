import 'package:flutter/material.dart';

class RepoDetailCardRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;

  const RepoDetailCardRow({
    super.key,
    required this.title,
    required this.value,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 18, color: kPrimaryColor),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
