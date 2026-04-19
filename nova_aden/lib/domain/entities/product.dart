class Product {
  final int? id;
  final String name;
  final String code;
  final double cost;
  final double price;
  final int stock;
  final int minStock;
  final String unit;

  Product({
    this.id,
    required this.name,
    required this.code,
    required this.cost,
    required this.price,
    this.stock = 0,
    this.minStock = 5,
    this.unit = 'und',
  });

  bool get isLowStock => stock <= minStock;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'cost': cost,
      'price': price,
      'stock': stock,
      'min_stock': minStock,
      'unit': unit,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      code: map['code'] as String,
      cost: (map['cost'] as num).toDouble(),
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int? ?? 0,
      minStock: map['min_stock'] as int? ?? 5,
      unit: map['unit'] as String? ?? 'und',
    );
  }
}