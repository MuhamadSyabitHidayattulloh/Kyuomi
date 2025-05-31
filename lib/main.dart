import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'screens/favorites/favorites_page.dart';
import 'screens/updates/updates_page.dart';
import 'screens/history/history_page.dart';
import 'screens/explore/explore_page.dart';
import 'screens/profile/profile_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kyuomi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        navigationBarTheme: NavigationBarThemeData(
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: Colors.blue.withOpacity(0.1),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const FavoritesPage(),
    const UpdatesPage(),
    const HistoryPage(),
    const ExplorePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        height: 80, // Tinggi yang lebih kecil
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(LineIcons.heart, size: 24),
            label: 'Favorit',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.bell, size: 24),
            label: 'Pembaruan',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.history, size: 24),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.compass, size: 24),
            label: 'Jelajah',
          ),
          NavigationDestination(
            icon: Icon(LineIcons.user, size: 24),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
