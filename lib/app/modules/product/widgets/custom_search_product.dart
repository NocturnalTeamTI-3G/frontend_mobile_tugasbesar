import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';

class CustomSearchProduct extends StatefulWidget {
  final String? currentQuery;
  const CustomSearchProduct({Key? key, this.currentQuery}) : super(key: key);

  @override
  _CustomSearchProductState createState() => _CustomSearchProductState();
}

class _CustomSearchProductState extends State<CustomSearchProduct> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi searchController hanya sekali pada initState
    searchController = TextEditingController(text: widget.currentQuery ?? '');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        leadingWidth: 40,
        title: Container(
          height: 45, // Atur tinggi TextField di sini
          margin: const EdgeInsets.only(right: 16, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: searchController,
            autofocus: true,
            maxLines: 1,
            cursorHeight: 20,
            decoration: InputDecoration(
              hintText: 'Search for news',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            onEditingComplete: () {
              Get.toNamed(AppRouters.productList,
                  arguments: searchController.text);
            },
            onSubmitted: (value) {
              Get.toNamed(AppRouters.productList, arguments: value);
            },
          ),
        ),
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade300, // Warna border bawah
            height: 1, // Ketebalan border bawah
          ),
        ),
      ),
    );
  }
}
