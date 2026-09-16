import 'package:logiks_crud/models/lego.dart';
import 'package:logiks_crud/services/legos_service.dart';

class EditViewModel {
  Future<Lego?> submit({
    required String id,
    required String name,
    int? year,
    double? price,
    int? pieces,
    int? minifigures,
  }) async {
    final lego = Lego(
      id: id,
      name: name,
      year: year,
      price: price,
      pieces: pieces,
      minifigures: minifigures,
    );
    final success = await LegosService.updateById(id, lego);
    return success ? lego : null;
  }
}
