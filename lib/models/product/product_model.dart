class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String type;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.type,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      type: json['type'],
    );
  }
}

class ProductData {
  List<ProductModel> productList = [
    ProductModel(
        id: '1',
        name: 'Product 1',
        description: 'This is product 1',
        price: 100,
        imageUrl:
            'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-181716263675.png',
        category: 'Normal',
        type: 'Kandungan'),
    ProductModel(
      id: '2',
      name: 'Product 2',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-041716263409.png',
      category: 'Normal',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '3',
      name: 'Product 3',
      description: 'This is product 3',
      price: 300,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-141715668434.png',
      category: 'Normal',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '1',
      name: 'Product 4',
      description: 'This is product 1',
      price: 100,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-181716263675.png',
      category: 'Whitehead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Product 5',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-041716263409.png',
      category: 'Whitehead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '3',
      name: 'Product 6',
      description: 'This is product 3',
      price: 300,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-141715668434.png',
      category: 'Whitehead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '1',
      name: 'Product 7',
      description: 'This is product 1',
      price: 100,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-181716263675.png',
      category: 'Blackhead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Product 8',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-041716263409.png',
      category: 'Blackhead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '3',
      name: 'Product 9',
      description: 'This is product 3',
      price: 300,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-141715668434.png',
      category: 'Blackhead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '1',
      name: 'Product 10',
      description: 'This is product 1',
      price: 100,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-181716263675.png',
      category: 'Pustula',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Product 11',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-041716263409.png',
      category: 'Pustula',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '3',
      name: 'Product 12',
      description: 'This is product 3',
      price: 300,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-141715668434.png',
      category: 'Pustula',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '1',
      name: 'Product 13',
      description: 'This is product 1',
      price: 100,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-181716263675.png',
      category: 'Papula',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Product 14',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-041716263409.png',
      category: 'Papula',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '3',
      name: 'Product 15',
      description: 'This is product 3',
      price: 300,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-2-141715668434.png',
      category: 'Papula',
      type: 'Kandungan',
    ),
  ];

  List<ProductModel> getProductByCategory(String category) {
    return productList
        .where((element) => element.category == category)
        .toList();
  }

  List<ProductModel> productBundleList = [
    ProductModel(
      id: '1',
      name: 'Paket Product 1',
      description: 'This is product 1',
      price: 100,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-201716179175.png',
      category: 'Normal',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Paket Product 2',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-141715668441.png',
      category: 'Normal',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '3',
      name: 'Paket Product 3',
      description: 'This is product 3',
      price: 300,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/paket-flex1716256141.png',
      category: 'Normal',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '1',
      name: 'Paket Product 4',
      description: 'This is product 1',
      price: 100,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-201716179175.png',
      category: 'Whitehead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Paket Product 5',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/produk-3-141715668441.png',
      category: 'Whitehead',
      type: 'Kandungan',
    ),
    ProductModel(
      id: '2',
      name: 'Paket Product 6',
      description: 'This is product 2',
      price: 200,
      imageUrl:
          'https://beningsindonesia.com/assets/uploads/media-uploader/paket-flex1716256141.png',
      category: 'Whitehead',
      type: 'Kandungan',
    ),
  ];

  List<ProductModel> getProductBundle() => productBundleList;
  List<ProductModel> getAllProducts() => productList;
}
