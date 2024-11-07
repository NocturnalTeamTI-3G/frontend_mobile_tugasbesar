import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/providers/news_list_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/widgets/custom_card.dart';
import 'package:frontend_mobile_tugasbesar/app/widgets/custom_search_screen.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatefulWidget {
  final String? searchQuery;

  const NewsListPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final newsProvider = Provider.of<NewsListProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                builder: (context) => CustomSearchScreen(
                  currentQuery: widget.searchQuery ?? '',
                ),
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
                child: Row(
                  children: [
                    Expanded(
                      child: Text(widget.searchQuery ?? 'Search for news',
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ),
                    const Icon(
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
          dividerHeight: 0,
          labelColor: AppColors.mainColor,
          unselectedLabelColor: Colors.grey,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildArticleList(newsProvider.listArtikel),
          _buildArticleList(newsProvider.listArtikel),
          _buildArticleList(newsProvider.listArtikel),
        ],
      ),
    );
  }

  SingleChildScrollView _buildArticleList(dynamic listArtikel) {
    return SingleChildScrollView(
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
    );
  }
}
