import 'package:custom_window/drawer_menu_item.dart';
import 'package:flutter/material.dart';

const maxMobileWidth = 600;
const maxTabWidth = 960;
const maxDesktopWidth = 1200;

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= maxTabWidth;

    List<Widget> buildDrawerItems() {
      return [
        DrawerMenuItem(
          index: 0,
          selectedIndex: selectedIndex,
          icon: Icons.home,
          title: 'Item 1',
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        DrawerMenuItem(
          index: 1,
          selectedIndex: selectedIndex,
          icon: Icons.favorite,
          title: 'Item 2',
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ];
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('AppBar with hamburger button'),
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
          ? SizedBox(
              width: 280,
              child: Drawer(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _scaffoldKey.currentState?.closeDrawer();
                            },
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
                    ...buildDrawerItems(),
                  ],
                ),
              ),
            )
          : null,
      body: isDesktop
          ? Row(
              children: [
                Container(
                  width: 280,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: buildDrawerItems(), // No header on desktop
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Center(
                    child: Text(
                      selectedIndex == 0 ? 'Home Page' : 'Favorites Page',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                selectedIndex == 0 ? 'Home Page' : 'Favorites Page',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
    );
  }
}
