import 'package:custom_window/drawer_menu_item.dart';
import 'package:flutter/material.dart';

const maxMobileWidth = 600;
const maxTabWidth = 960;
const maxDesktopWidth = 1200;

class MenuItemData {
  final int index;
  final IconData icon;
  final String title;

  const MenuItemData({
    required this.index,
    required this.icon,
    required this.title,
  });
}

const List<MenuItemData> menuItems = [
  MenuItemData(index: 0, icon: Icons.home, title: 'Home'),
  MenuItemData(index: 1, icon: Icons.favorite, title: 'Account'),
];

void main() {
  runApp(
    MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildPage() {
    switch (selectedIndex) {
      case 0:
        return const Center(
          key: PageStorageKey('home'),
          child: Text('Home Page'),
        );
      case 1:
        return const Center(
          key: PageStorageKey('favorites'),
          child: Text('Favorites Page'),
        );
      default:
        return const Center(
          key: PageStorageKey('not-found'),
          child: Text('Page Not Found'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= maxTabWidth;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('AppBar with hamburger button'),
        elevation: 4, // ← Adds shadow
        shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
        surfaceTintColor:
            Colors.transparent, // Optional: remove default Material 3 tint
        leading: !isDesktop
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              )
            : null,
      ),
      drawer: !isDesktop
          ? AppSidebar(
              selectedIndex: selectedIndex,
              onTap: (i) => setState(() => selectedIndex = i),
              isDesktop: false,
              onClose: () => _scaffoldKey.currentState?.closeDrawer(),
            )
          : null,
      body: Row(
        children: [
          if (isDesktop)
            AppSidebar(
              selectedIndex: selectedIndex,
              onTap: (i) => setState(() => selectedIndex = i),
              isDesktop: true,
            ),
          if (isDesktop) const VerticalDivider(width: 1),
          Expanded(child: Center(child: buildPage())),
        ],
      ),
    );
  }
}

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final bool isDesktop;
  final VoidCallback? onClose;

  const AppSidebar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.isDesktop,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      Container(
        // padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Image.asset('assets/instamojo.png'),
        ),
      ),
      ...menuItems.map((item) {
        return DrawerMenuItem(
          index: item.index,
          selectedIndex: selectedIndex,
          icon: item.icon,
          title: item.title,
          onTap: onTap,
        );
      }),
    ];

    return isDesktop
        ? Container(
            width: 280,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: ListView(padding: EdgeInsets.zero, children: items),
          )
        : Drawer(
            width: 280,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: onClose,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ...items,
              ],
            ),
          );
  }
}
