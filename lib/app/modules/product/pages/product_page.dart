import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/product/product_model.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/widgets/product_card.dart';
import 'package:frontend_mobile_tugasbesar/app/widgets/custom_appbar.dart';
import 'package:frontend_mobile_tugasbesar/app/widgets/custom_search_screen.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _selectedIndex = 0;
  List<ProductModel> normalProducts =
      ProductData().getProductByCategory('Normal');
  List<ProductModel> whiteheadProducts =
      ProductData().getProductByCategory('Whitehead');
  List<ProductModel> blackheadProducts =
      ProductData().getProductByCategory('Blackhead');
  List<ProductModel> pustulaProducts =
      ProductData().getProductByCategory('Pustula');
  List<ProductModel> papulaProducts =
      ProductData().getProductByCategory('Papula');

  List<List<ProductModel>> listProducts = [];

  List<ProductModel> bundleProducts = ProductData().getProductBundle();

  @override
  Widget build(BuildContext context) {
    listProducts.add(normalProducts);
    listProducts.add(whiteheadProducts);
    listProducts.add(blackheadProducts);
    listProducts.add(pustulaProducts);
    listProducts.add(papulaProducts);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppbar(
          title: 'Products',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                height: 78,
                child: ListView.builder(
                  padding:
                      const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Number of buttons
                  itemBuilder: (context, index) {
                    // Define text and colors for each button
                    final buttonText = [
                      'Normal Skin',
                      'Whitehead',
                      'Blackhead',
                      'Pustula',
                      'Papula'
                    ][index];
                    final isSelected = index == _selectedIndex;
                    final buttonColor =
                        isSelected ? AppColors.mainColor : AppColors.white;
                    final textColor =
                        isSelected ? Colors.white : Colors.grey[600];
                    final borderColor =
                        isSelected ? AppColors.mainColor : Colors.grey.shade300;

                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0), // Spacing between buttons
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        color: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: borderColor, width: 1.5),
                        ),
                        elevation: 2,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = index;
                          });
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
            SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                scrollDirection: Axis.horizontal,
                itemCount: listProducts[_selectedIndex].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: MaterialButton(
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      color: AppColors.bgColor1,
                      elevation: 2,
                      onPressed: () {
                        setState(() {});
                      },
                      child: Container(
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                listProducts[_selectedIndex][index].imageUrl,
                                fit: BoxFit.cover,
                                height: 160,
                                width: 180,
                              ),
                            ),
                            Text(
                              listProducts[_selectedIndex][index].name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              listProducts[_selectedIndex][index].type,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${listProducts[_selectedIndex][index].price.toString()}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bundle Products',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 250),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bundleProducts.length,
                      itemBuilder: (context, index) {
                        final product = bundleProducts[index];
                        return ProductCard(product: product);
                      },
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
