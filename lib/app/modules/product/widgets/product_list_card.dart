import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/product/product_model.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        Get.toNamed(AppRouters.productDetail, arguments: product.id);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.imageUrl,
              height: 170,
              width: 170,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 170,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.nutrition.split(',')[0],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     '',
                //     // '\$${product.price.toString()}',
                //     style: const TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
