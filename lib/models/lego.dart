class Lego {
  final String? id;
  final String name;
  final int? year;
  final double? price;
  final int? pieces;
  final int? minifigures;

  Lego({
    this.id,
    required this.name,
    this.year,
    this.price,
    this.pieces,
    this.minifigures,
  });

  factory Lego.fromJson(Map json) {
    final data = json["data"] as Map?;
    return Lego(
      id: json["id"] as String?,
      name: json["name"] ?? "Unnamed",
      year: data?["year"] as int?,
      price: (data?["price"] as num?)?.toDouble(),
      pieces: data?["pieces"] as int?,
      minifigures: data?["minifigures"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "data": {
        "year": year,
        "price": price,
        "pieces": pieces,
        "minifigures": minifigures,
      },
    };
  }
}
