import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/widgets/history_card.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
    required this.list,
  });

  final List<HistoryModel> list;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? const Center(
            child: Text('Tidak ada riwayat'),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28, top: 12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return HistoryCard(data: data);
                  },
                ),
              ),
            ),
          );
  }
}
