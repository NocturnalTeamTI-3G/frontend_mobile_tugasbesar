import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/providers/news_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/widgets/custom_card.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/widgets/custom_search_news.dart';
import 'package:get/get.dart';
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
  late String query;
  late NewsProvider _newsProvider;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    query = Get.arguments as String? ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _newsProvider = Provider.of<NewsProvider>(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_newsProvider.listAllArticle.isEmpty) {
          _newsProvider.getAllArticles();
        }

        _newsProvider.searchArticle(query);
      });

      _isInitialized = true;
    } else if (query.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _newsProvider.searchArticle(query);
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          // padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            forceMaterialTransparency: true,
            titleSpacing: 0,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    Icon(Icons.arrow_back_ios_new, color: AppColors.mainColor),
              ),
            ),
            leadingWidth: 40,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRouters.main);
                    query = '';
                  },
                  icon: Icon(Icons.home, color: AppColors.mainColor, size: 30),
                ),
              ),
            ],
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomSearchNews(
                      currentQuery: query,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 10),
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
                          child: Text(
                              query.isNotEmpty ? query : 'Search for Article',
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
          ),
        ),
      ),
      body: _newsProvider.listArticle.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            )
          : Consumer<NewsProvider>(
              builder: (builder, newsProvider, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 250),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newsProvider.listArticle.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              artikel: newsProvider.listArticle[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
