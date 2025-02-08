import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:popular_gitrepos/service_locator/init_service_locators.dart';

import '../../database/database.dart';

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
          // GestureDetector(
          //   onTap: () => Scaffold.of(context).openDrawer(),
          //   child: const Center(
          //     child: Icon(
          //       Icons.menu,
          //       size: 24,
          //     ),
          //   ),
          // ),
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
            onTap: () {
              final db = getIt.get<AppDatabase>();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DriftDbViewer(db)));
            },
            child: Center(
              child: Icon(
                Icons.settings_outlined,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
