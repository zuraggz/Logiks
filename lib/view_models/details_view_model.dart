import 'package:logiks_crud/services/legos_service.dart';

class DetailsViewModel {
  Future<bool> deleteById(String id) {
    return LegosService.deleteById(id);
  }
}
