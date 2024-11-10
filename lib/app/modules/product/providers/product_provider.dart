import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/product/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> allProducts = ProductData().getAllProducts();
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
  List<List<ProductModel>> listAllProducts = [];
  List<ProductModel> bundleProducts = ProductData().getProductBundle();

  ProductProvider() {
    listAllProducts.add(allProducts);
    listProducts.add(normalProducts);
    listProducts.add(whiteheadProducts);
    listProducts.add(blackheadProducts);
    listProducts.add(pustulaProducts);
    listProducts.add(papulaProducts);
    listAllProducts.addAll(listProducts);
  }

  List<ProductModel> getProductsByCategory(int index) {
    return listProducts[index];
  }

  List<ProductModel> getBundleProducts() {
    return bundleProducts;
  }
}
