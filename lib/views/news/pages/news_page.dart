import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/providers/news_provider.dart';
import 'package:frontend_mobile_tugasbesar/utils/color.dart';
import 'package:frontend_mobile_tugasbesar/views/news/pages/news_list_page.dart';
import 'package:frontend_mobile_tugasbesar/views/news/widgets/custom_card.dart';
import 'package:frontend_mobile_tugasbesar/views/news/widgets/card_carousel.dart';
import 'package:frontend_mobile_tugasbesar/widgets/custom_appbar.dart';
import 'package:frontend_mobile_tugasbesar/widgets/custom_search_screen.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppbar(
          title: 'Information',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomSearchScreen(),
                    ),
                  );
                },
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
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
      
            // Carousel Section
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Trending News',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                initialPage: newsProvider.currentPage,
                onPageChanged: (index, _) {
                  newsProvider.setCurrentPage(index);
                },
                height: 280,
              ),
              items: newsProvider.listCarousel
                  .map(
                    (artikel) => CardCarousel(artikel: artikel),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < newsProvider.listCarousel.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 3),
                    height: 10,
                    width: i == newsProvider.currentPage ? 30 : 10,
                    decoration: BoxDecoration(
                      color: i == newsProvider.currentPage
                          ? AppColors.mainColor
                          : Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
              ],
            ),
      
            // Article List Section
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 16, top: 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'For you',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewsListPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 250),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newsProvider.listArtikel.length,
                        itemBuilder: (context, index) {
                          final artikel = newsProvider.listArtikel[index];
                          return CustomCard(artikel: artikel);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
