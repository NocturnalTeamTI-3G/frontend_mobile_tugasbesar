import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/pages/product_detail_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/pages/product_list_page.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/providers/product_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/widgets/custom_search_product.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/widgets/product_card.dart';
import 'package:frontend_mobile_tugasbesar/app/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.getAllProduct();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppbar(),
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
                      builder: (context) => const CustomSearchProduct(),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                return SizedBox(
                  height: 78,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        left: 20, top: 20, bottom: 20, right: 12),
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemCount: 5, // Number of buttons
                    itemBuilder: (context, index) {
                      final buttonText = [
                        'Normal',
                        'Whitehead',
                        'Blackhead',
                        'Pustula',
                        'Papula'
                      ][index];
                      final isSelected = index == productProvider.selectedCategory;
                      final textColor =
                          isSelected ? AppColors.mainColor : Colors.grey[500];
                      final borderColor = isSelected
                          ? AppColors.mainColor
                          : Colors.grey.shade300;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: borderColor, width: 1),
                          ),
                          elevation: 1,
                          onPressed: () {
                            productProvider.setSelectedCategory(index);
                            _scrollToCenter(index);
                          },
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
              return productProvider.isLoading
                  ? SizedBox(
                      height: 280,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20, bottom: 15),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: _buildSkeletonCarousel(),
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: 280,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20, bottom: 15),
                        scrollDirection: Axis.horizontal,
                        itemCount: productProvider.carouselProducts.length,
                        itemBuilder: (context, index) {
                          final product =
                              productProvider.carouselProducts[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: MaterialButton(
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              elevation: 2,
                              onPressed: () {
                                setState(() {
                                  Get.to(const ProductDetailPage(),
                                      arguments: product.id);
                                });
                              },
                              child: Container(
                                width: 190,
                                height: 265,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 165,
                                      decoration: BoxDecoration(
                                        // gradient: LinearGradient(
                                        //   colors: [
                                        //     AppColors.secondaryColor,
                                        //     AppColors.cardColor,
                                        //   ],
                                        //   begin: Alignment.topLeft,
                                        //   end: Alignment.bottomRight,
                                        // ),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.network(
                                          product.imageUrl,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 8),
                                      width: double.infinity,
                                      height: 88,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            product.nutrition.split(',')[0],
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          // const Spacer(),
                                          // Container(
                                          //   alignment: Alignment.centerRight,
                                          //   child: Text(
                                          //     // '\$${product.price.toString()}',
                                          //     '',
                                          //     style: const TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 22,
                                          //       fontWeight: FontWeight.w700,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Newest Products',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(const ProductListPage());
                        },
                        icon: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                  Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      return productProvider.isLoading
                          ? SizedBox(
                              height: 250,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: _buildSkeletonCard(),
                                  );
                                },
                              ),
                            )
                          : Transform.translate(
                              offset: const Offset(0, -5),
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minHeight: 250),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      productProvider.newestProducts.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        productProvider.newestProducts[index];
                                    return ProductCard(product: product);
                                  },
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollToCenter(int index) {
    const itemWidth = 120;
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _buildSkeletonCarousel() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 240,
        width: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  _buildSkeletonCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
