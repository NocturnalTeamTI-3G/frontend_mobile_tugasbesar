import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/news/providers/news_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({Key? key}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late int id;

  @override
  void initState() {
    super.initState();
    id = Get.arguments as int;
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    final String url = '${Api.baseUrl}/api/image/user/';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.3),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black.withOpacity(0.3),
                    child: const Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: newsProvider.getArticleById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Article not found'));
          } else {
            final artikel = snapshot.data!;
            final DateTime dateTime = DateTime.parse(artikel.date);
            final String formatedDate =
                DateFormat('d MMMM yyyy').format(dateTime);
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Image.network(
                    artikel.image,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.52,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.48,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 36, bottom: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          )
                                        ]),
                                    child: Text(
                                      artikel.category,
                                      style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    artikel.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    formatedDate,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          '$url${artikel.authorImg}',
                                          height: 32,
                                          width: 32,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/default_profile.png',
                                            fit: BoxFit.cover,
                                            height: 32,
                                            width: 32,
                                          ),
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : const CircularProgressIndicator(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: 85,
                                        child: Text(
                                          artikel.author,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        artikel.views.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<NewsProvider>(
                                    builder: (context, newsProvider, _) {
                                  return GestureDetector(
                                    onTap: () {
                                      newsProvider.likeArticle(artikel.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            newsProvider.isLiked
                                                ? Icons.thumb_up_alt
                                                : Icons.thumb_up_alt_outlined,
                                            size: 26,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            newsProvider.likeCount.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              artikel.content,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Rekomendasi Artikel',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios_rounded),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 223,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    newsProvider.recommendedArticle.length,
                                itemBuilder: (context, index) {
                                  final article =
                                      newsProvider.recommendedArticle[index];
                                  final DateTime dateTime =
                                      DateTime.parse(article.date);
                                  final String formatedDate =
                                      DateFormat('d MMMM yyyy')
                                          .format(dateTime);
                                  return GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(AppRouters.newsDetail,
                                          arguments: article.id);
                                    },
                                    child: Container(
                                      width: 200,
                                      margin: const EdgeInsets.only(right: 20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: AppColors.cardColor2,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  article.image,
                                                  height: 120,
                                                  width: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                height: 120,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.3),
                                                        Colors.transparent,
                                                        Colors.black
                                                            .withOpacity(0.3),
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              Container(
                                                height: 120,
                                                width: 200,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Text(
                                                        article.category,
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .mainColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        ClipOval(
                                                          child: Image.network(
                                                            '$url${article.authorImg}',
                                                            height: 30,
                                                            width: 30,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Image.asset(
                                                              'assets/images/default_profile.png',
                                                              fit: BoxFit.cover,
                                                              height: 30,
                                                              width: 30,
                                                            ),
                                                            loadingBuilder: (context,
                                                                    child,
                                                                    loadingProgress) =>
                                                                loadingProgress ==
                                                                        null
                                                                    ? child
                                                                    : const CircularProgressIndicator(),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          article.author,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            article.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            formatedDate,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
