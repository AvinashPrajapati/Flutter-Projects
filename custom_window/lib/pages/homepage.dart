import 'package:custom_window/pages/dashboard_tabs.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 565;

    return isMobile
        ? Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: const [
                      LogoItem(),
                      HeroItems(),
                      SizedBox(height: 16),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: const DashboardTabs(),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LogoItem(),
                      SizedBox(width: 30),
                      HeroItems(),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    child: const DashboardTabs(),
                  ),
                ],
              ),
            ),
          );
  }
}

class HeroItems extends StatelessWidget {
  const HeroItems({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 565;
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        SizedBox(height: isMobile ? 0 : 30),
        const Text(
          'Avinash Kumar Prajapati',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Text('Main Job : Architecturer'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    3,
                  ), // 👈 Change radius here
                ),
              ),
              onPressed: () {},
              child: const Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Share Profile'),
            ),
            ElevatedButton(onPressed: () {}, child: const Icon(Icons.settings)),
          ],
        ),
      ],
    );
  }
}

class LogoItem extends StatelessWidget {
  const LogoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 130,
        height: 130,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(80),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/a.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
