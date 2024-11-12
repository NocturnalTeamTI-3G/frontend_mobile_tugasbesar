import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/services/history_service.dart';
import 'package:get/get.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryModel> historyList = [];
  List<HistoryModel> acneHistoryList = [];
  List<HistoryModel> healthyHistoryList = [];
  bool _isLoading = false;
  final HistoryService _historyService = HistoryService();

  bool get isLoading => _isLoading;

  Future<void> getHistory() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _historyService.getHistory();
      if (response.statusCode == 200) {
        final data = response.data['data'];
        historyList = List<HistoryModel>.from(
            data.map((json) => HistoryModel.fromJson(json)));
        acneHistoryList = historyList.where((element) => element.disease != 'Sehat').toList();
        healthyHistoryList = historyList.where((element) => element.disease == 'Sehat').toList();
        notifyListeners();
      } else {
        throw ('Anda tidak terautentikasi');
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data history user. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }
}
