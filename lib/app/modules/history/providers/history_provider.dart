import 'package:flutter/material.dart';
import 'package:frontend_mobile_tugasbesar/app/models/history/history_model.dart';
import 'package:frontend_mobile_tugasbesar/app/modules/history/services/history_service.dart';
import 'package:frontend_mobile_tugasbesar/app/utils/routes/router.dart';
import 'package:get/get.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryModel> historyList = [];
  List<HistoryModel> acneHistoryList = [];
  List<HistoryModel> healthyHistoryList = [];
  bool _isLoading = false;
  final HistoryService _historyService = HistoryService();

  bool get isLoading => _isLoading;

  Future<void> getHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _historyService.getHistory();
      if (response.statusCode == 200) {
        final data = response.data['data'];
        historyList = List<HistoryModel>.from(
            data.map((json) => HistoryModel.fromJson(json)));
        acneHistoryList =
            historyList.where((element) => element.disease != 'Sehat').toList();
        healthyHistoryList =
            historyList.where((element) => element.disease == 'Sehat').toList();
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

  Future<HistoryModel?> getHistoryById(int id) async {
    try {
      _isLoading = true;
      notifyListeners();

      HistoryModel history;

      final response = await _historyService.getHistoryById(id);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        history = HistoryModel.fromJson(data);
      } else {
        throw ('History tidak ditemukan');
      }

      _isLoading = false;
      notifyListeners();
      return history;
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat mengambil data history user. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> deleteHistoryById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _historyService.deleteHistory(id);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Sukses',
          'History Berhasil Dihapus',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.toNamed(AppRouters.main, arguments: 1);
      } else {
        throw ('History tidak ditemukan');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak dapat menghapus data history. Silahkan coba lagi atau Hubungi admin.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      _isLoading = false;
      notifyListeners();
    }
  }
}
