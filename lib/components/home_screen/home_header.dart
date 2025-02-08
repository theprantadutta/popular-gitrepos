import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/settings_screen.dart';
import '../shared/hero_icon_component.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Popular',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(
                  text: 'GitRepos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 2,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.push(SettingsScreen.kRouteName),
            child: HeroIconComponent(),
          ),
        ],
      ),
    );
  }
}
