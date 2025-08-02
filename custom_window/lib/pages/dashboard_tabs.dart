import 'package:flutter/material.dart';

class DashboardTabs extends StatefulWidget {
  const DashboardTabs({super.key});

  @override
  State<DashboardTabs> createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabs = const [
    Tab(text: 'Posts'),
    Tab(text: 'Analytics'),
    Tab(text: 'Transactions'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: const Color.fromARGB(255, 219, 219, 219),
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: tabs,
          ),
        ),

        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height - 300,
                              color: Colors.amber,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(10, (index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ), // adjust the radius as needed
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              child: Image.asset(
                                                'assets/b.png',
                                                width: double.infinity,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Avinashishi : ',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text:
                                                          'This is a very long string that represents a post or item in your scrollable list.',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              // Add horizonatal cards in list with a 150 long string , and an image
                            ),
                          ),
                          // const SizedBox(width: 16),
                          // RIGHT COLUMN: Post detail card
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height - 300,
                              color: Colors.blueAccent[100],
                              child: SingleChildScrollView(
                                child: Card(
                                  margin: const EdgeInsets.all(12),
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Post Title',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Date: 2025-08-02',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'This is the detailed content of the post. It could include long paragraphs of text explaining the content, news, or anything else.',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 12),
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          child: Image.asset(
                                            'assets/b.png',
                                            width: double.infinity,
                                            // height: 100,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Analytics Content'),
                    const Center(child: Text('Transactions Content')),
                  ],
                ),
              );
            },
          ),
        ), // //
      ],
    );
  }
}
