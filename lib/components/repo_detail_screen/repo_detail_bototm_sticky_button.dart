// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class RepoDetailBototmStickyButton extends StatelessWidget {
  final bool hasError;
  final String githubUrl;
  const RepoDetailBototmStickyButton({
    super.key,
    required this.githubUrl,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return AbsorbPointer(
      absorbing: hasError,
      child: Opacity(
        opacity: hasError ? 0.4 : 1,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: kPrimaryColor.withValues(alpha: 0.05),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: hasError
                    ? Colors.grey.withValues(alpha: 0.6)
                    : kPrimaryColor.withValues(alpha: isDarkTheme ? 0.6 : 0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                try {
                  talker!.info('launching url $githubUrl...');
                  if (!await launchUrl(Uri.parse(githubUrl))) {
                    talker!.info('launched url $githubUrl');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch $githubUrl')),
                    );
                  }
                } catch (e) {
                  talker!.error(e, 'failed to launch');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error launching URL')),
                  );
                }
              },
              child: Text(
                hasError ? 'View Failed' : 'View on GitHub',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RepoDetailBototmStickyButtonSkeletor extends StatelessWidget {
  const RepoDetailBototmStickyButtonSkeletor({super.key});

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Skeletonizer(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: kPrimaryColor.withValues(alpha: 0.05),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.06,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  kPrimaryColor.withValues(alpha: isDarkTheme ? 0.6 : 0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'View on GitHub',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
