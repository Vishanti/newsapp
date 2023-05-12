import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/pages.dart';
import 'package:newsapp/src/providers/providers.dart';
import 'package:newsapp/src/services/services.dart';
import 'package:newsapp/src/theme/my_theme.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavigatorProvider()),
          ChangeNotifierProvider(create: (context) => NewsService()),
        ],
        child:
            const Scaffold(body: _Pages(), bottomNavigationBar: _Navigation()));
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigatorProvider = Provider.of<NavigatorProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigatorProvider.currentPage,
      onTap: (value) => navigatorProvider.currentPage = value,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezado')
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigatorProvider = Provider.of<NavigatorProvider>(context);

    return PageView(
      // physics: const BouncingScrollPhysics(),
      controller: navigatorProvider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tab1Page(), Tab2Page()],
    );
  }
}
