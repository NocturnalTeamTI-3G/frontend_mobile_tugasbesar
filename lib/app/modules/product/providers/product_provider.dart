import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/product/product_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/product/services/product_service.dart';
import 'package:get/get.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ProductService _productService = ProductService();
  List<ProductModel> listAllProducts = [];
  List<ProductModel> listProducts = [];
  List<ProductModel> carouselProducts = [];
  List<ProductModel> newestProducts = [];

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;

  List<String> categories = [
    'Normal',
    'Acne Nodules',
    'Rosacea',
    'Melanoma',
    'Dermatitis Perioral',
  ];

  void setSelectedCategory(int index) {
    _selectedCategory = index;
    carouselProducts = listAllProducts
        .where((element) => element.category == categories[index])
        .take(3)
        .toList();

    notifyListeners();
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      listProducts = listAllProducts;
    } else {
      listProducts = listAllProducts
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  Future<void> getAllProduct() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _productService.getAllProducts();

      if (response.statusCode == 200) {
        final data = response.data['data'];
        listAllProducts = List<ProductModel>.from(
            data.map((json) => ProductModel.fromJson(json)));
        listProducts = listAllProducts;
        carouselProducts = listAllProducts
            .where((element) => element.category == 'Normal')
            .take(3)
            .toList();
        newestProducts = listAllProducts.take(5).toList();
      } else {
        throw ('Terjadi kesalahan dalam pengambilan data produk');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data produk. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ProductModel?> getProductById(int id) async {
    try {
      ProductModel product;

      final response = await _productService.getProductById(id);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        product = ProductModel.fromJson(data);
      } else {
        throw ('Produk tidak ditemukan');
      }

      return product;
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data produk. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return null;
    }
  }
}
