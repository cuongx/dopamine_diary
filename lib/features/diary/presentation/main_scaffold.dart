import 'package:dopamine_diary/features/diary/presentation/analytics/analytics_page.dart';
import 'package:dopamine_diary/features/diary/presentation/detox/detox_active_page.dart';
import 'package:dopamine_diary/features/diary/presentation/home/home_page.dart';
import 'package:dopamine_diary/features/diary/presentation/settings/settings_page.dart';
import 'package:dopamine_diary/features/diary/presentation/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';

/// Shell chứa 4 tab — IndexedStack giữ state mỗi tab khi switch.
class MainScaffold extends StatefulWidget {
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => const MainScaffold(),
      );

  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  static const _pages = <Widget>[
    HomePage(),
    AnalyticsPage(),
    DetoxActivePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
