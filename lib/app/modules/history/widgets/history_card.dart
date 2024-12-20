import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/themes/color.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.data,
  });

  final HistoryModel data;

  @override
  Widget build(BuildContext context) {
    final String url = '${Api.baseUrl}/api/image/history_scan/';
    final DateTime dateTime = DateTime.parse(data.date);
    final String formatedDate = DateFormat('d MMMM yyyy').format(dateTime);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          child: MaterialButton(
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Get.toNamed(AppRouters.historyDetail, arguments: data.id);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '$url${data.image}',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/icon/face-id.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.disease,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
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
                  ),
                  Text(
                    data.disease == 'Sehat' ? 'Sehat' : 'Jerawat',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          data.disease == 'Sehat' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 43),
            child: Container(
              height: 20,
              width: 5,
              decoration: BoxDecoration(
                color: data.disease == 'Sehat' ? Colors.green : Colors.red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
