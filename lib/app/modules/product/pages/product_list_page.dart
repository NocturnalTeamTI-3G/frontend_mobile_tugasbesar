import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/providers/product_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/widgets/product_list_card.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/widgets/custom_search_screen.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String? searchQuery;

  const ProductListPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
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
                          child: Text(
                              widget.searchQuery ?? 'Search for Product',
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: SizedBox(
                height: 58,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 12),
                  scrollDirection: Axis.horizontal,
                  // controller: _scrollController,
                  itemCount: 5, // Number of buttons
                  itemBuilder: (context, index) {
                    final buttonText = [
                      'All Skin Type',
                      'Normal Skin',
                      'Whitehead',
                      'Blackhead',
                      'Pustula',
                      'Papula'
                    ][index];
                    final isSelected = index == _selectedIndex;
                    final textColor =
                        isSelected ? AppColors.mainColor : Colors.grey[500];
                    final borderColor =
                        isSelected ? AppColors.mainColor : Colors.grey.shade300;

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
                          setState(() {
                            _selectedIndex = index;
                          });
                          // _scrollToCenter(index);
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
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 250),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.6,
              ),
              itemCount:
                  _productProvider.listAllProducts[_selectedIndex].length,
              itemBuilder: (context, index) {
                final product =
                    _productProvider.listAllProducts[_selectedIndex][index];
                return ProductListCard(product: product);
              },
            ),
          ),
        ),
      ),
    );
  }
}
