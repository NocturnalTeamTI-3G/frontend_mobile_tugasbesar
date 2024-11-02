import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/models/news/artikel_model.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:frontend_mobile_tugasbesar/views/news/widgets/custom_card.dart';
import 'package:frontend_mobile_tugasbesar/widgets/custom_search_screen.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var listArtikel = ArtikelData().getAllArticles();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: AppColors.mainColor),
          ),
        ),
        leadingWidth: 40,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomSearchScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text('Search for news',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.filter_list_alt, color: AppColors.mainColor)),
        // ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Terbaru'),
            Tab(text: 'Terfavorit'),
          ],
          indicatorColor: AppColors.mainColor,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.mainColor,
          unselectedLabelColor: Colors.grey,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listArtikel.length,
                  itemBuilder: (context, index) {
                    return CustomCard(artikel: listArtikel[index]);
                  },
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listArtikel.length,
                  itemBuilder: (context, index) {
                    return CustomCard(artikel: listArtikel[index]);
                  },
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listArtikel.length,
                  itemBuilder: (context, index) {
                    return CustomCard(artikel: listArtikel[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
