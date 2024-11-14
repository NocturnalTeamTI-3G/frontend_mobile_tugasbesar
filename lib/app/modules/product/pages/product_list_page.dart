import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/providers/product_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/widgets/custom_search_product.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/widgets/product_list_card.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String? searchQuery;

  const ProductListPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _scrollController = ScrollController();
  late String query;
  late ProductProvider _productProvider;

  @override
  void initState() {
    super.initState();
    query = Get.arguments as String? ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = Provider.of<ProductProvider>(context);
    if (query.isNotEmpty) _productProvider.searchProduct(query);
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
                  },
                  icon: Icon(Icons.home_filled, color: AppColors.mainColor),
                ),
              ),
            ],
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomSearchProduct(
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
                              query.isNotEmpty ? query : 'Search for Product',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 220),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20,
                childAspectRatio: 0.6,
              ),
              itemCount: _productProvider.listProducts.length,
              itemBuilder: (context, index) {
                final product = _productProvider.listProducts[index];
                return ProductListCard(product: product);
              },
            ),
          ),
        ),
      ),
    );
  }
}
