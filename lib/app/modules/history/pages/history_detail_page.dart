import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/providers/history_provider.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/api/api.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({Key? key}) : super(key: key);

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  late Future<HistoryModel?> _historyFuture;
  late HistoryProvider historyProvider;
  late int id;

  @override
  void initState() {
    super.initState();
    id = Get.arguments as int;
    _historyFuture = Future.value(null);

    // Pastikan penggunaan context dilakukan setelah build selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      historyProvider = Provider.of<HistoryProvider>(context, listen: false);
      setState(() {
        _historyFuture = historyProvider.getHistoryById(id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String url = '${Api.baseUrl}/api/image/history_scan/';

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.3),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await historyProvider.deleteHistoryById(id);
              },
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black.withOpacity(0.3),
                    child: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            // Tampilkan indikator loading
            return const Center(child: CircularProgressIndicator());
          }

          // Lanjutkan dengan FutureBuilder jika isLoading false
          return FutureBuilder<HistoryModel?>(
            future: _historyFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("Data tidak ditemukan"));
              } else {
                final history = snapshot.data!;
                final DateTime dateTime = DateTime.parse(history.date);
                String formattedDate =
                    DateFormat('d MMMM yyyy').format(dateTime);

                // Konten lainnya tetap sama
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.62,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            '$url${history.image}',
                            fit: BoxFit.cover,
                            width: 225,
                            height: 400,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/icon/face-id.png',
                                width: 225,
                                height: 225,
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
                                          height: 225,
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.55),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                history.disease,
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Deskripsi',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              history.description,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Solusi',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              history.solution,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Rekomendasi Produk',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed(AppRouters.productList);
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 235,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: history.products.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRouters.productDetail,
                                            arguments:
                                                history.products[index].id);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              history.products[index].imageUrl,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                return loadingProgress == null
                                                    ? child
                                                    : Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        child: Container(
                                                          height: 150,
                                                          width: 150,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            history.products[index].name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            history.products[index].nutrition
                                                .split(',')[0],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
