import 'package:logiks_crud/models/lego.dart';
import 'package:logiks_crud/services/legos_service.dart';

class LegoAddViewModel {
  Future<bool> submit({
    required String name,
    int? year,
    double? price,
    int? pieces,
    int? minifigures,
  }) {
    final lego = Lego(
      name: name,
      year: year,
      price: price,
      pieces: pieces,
      minifigures: minifigures,
    );
    return LegosService.create(lego);
  }
}
