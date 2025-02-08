import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? onRetryPressed;

  const SomethingWentWrong({
    super.key,
    this.onRetryPressed,
    this.title = 'Something Went Wrong',
    this.content =
        'This wasn\'t supposed to happen, check your internet connection, if the problem persists, please open an issue at github',
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: 70,
          color: Colors.red[300],
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 30),
        if (onRetryPressed != null)
          GestureDetector(
            onTap: onRetryPressed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7),
              width: 153,
              decoration: BoxDecoration(
                // color: kPrimaryColor,
                border: Border.all(
                  color: kPrimaryColor.withValues(alpha: 0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
