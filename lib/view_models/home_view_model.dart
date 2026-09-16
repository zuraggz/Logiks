import 'package:flutter/foundation.dart';
import 'package:logiks_crud/models/lego.dart';
import 'package:logiks_crud/services/legos_service.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = true;
  bool hasError = false;
  List<Lego> items = [];

  Future<void> fetchLegos() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final result = await LegosService.fetchAll();
      if (result != null) {
        items = result;
      } else {
        hasError = true;
      }
    } catch (_) {
      hasError = true;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> deleteById(String id) async {
    final success = await LegosService.deleteById(id);
    if (success) {
      items.removeWhere((item) => item.id == id);
      notifyListeners();
    }
    return success;
  }
}
