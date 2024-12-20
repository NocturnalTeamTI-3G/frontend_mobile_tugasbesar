import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/news/artikel_model.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.artikel,
  });

  final ArtikelModel artikel;

  @override
  Widget build(BuildContext context) {
    final String url = '${Api.baseUrl}/api/image/user/';
    final DateTime dateTime = DateTime.parse(artikel.date);
    final String formatedDate = DateFormat('d MMMM yyyy').format(dateTime);

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Get.toNamed(AppRouters.newsDetail, arguments: artikel.id);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                artikel.image,
                fit: BoxFit.cover,
                height: 95,
                width: 95,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
              ),
            ),
            Expanded(
              child: Container(
                height: 95,
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artikel.category,
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      artikel.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: Image.network(
                                '$url${artikel.authorImg}',
                                height: 26,
                                width: 26,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/default_profile.png',
                                  fit: BoxFit.cover,
                                  height: 26,
                                  width: 26,
                                ),
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    loadingProgress == null
                                        ? child
                                        : const CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              artikel.author,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatedDate,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
