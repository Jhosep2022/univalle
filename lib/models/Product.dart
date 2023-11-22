class Product {
  final int id;
  final String nameProduct;
  final String description;
  final int stock;
  final double priceBase;
  final String imageUrl;

  Product({
    required this.id,
    required this.nameProduct,
    required this.description,
    required this.stock,
    required this.priceBase,
    required this.imageUrl,
  });

  Product.empty(this.id, this.nameProduct, this.description, this.stock,
      this.priceBase, this.imageUrl);

  factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
    nameProduct: json['name_product'] as String? ?? '',
    description: json['description_product'] as String? ?? '', 
    stock: int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
    priceBase: double.tryParse(json['price_base']?.toString() ?? '0.0') ?? 0.0,
    imageUrl: json['Image'] as String? ?? 'url_de_tu_imagen_por_defecto', 
  );
}
}
