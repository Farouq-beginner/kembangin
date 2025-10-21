class BaseModel {
  String getInfo() => "BaseModel info";
}

class Product extends BaseModel {
  String _name;
  int _price;
  int _stock;
  String _image;
  String _description;
  int _quantity;

  Product({
    required String name,
    required int price,
    required int stock,
    required String image,
    String description = '',
    int quantity = 1,
  })  : _name = name,
        _price = price,
        _stock = stock,
        _image = image,
        _description = description,
        _quantity = quantity;

  // Getter & Setter
  String get name => _name;
  set name(String value) => _name = value;

  int get price => _price;
  set price(int value) => _price = value;

  int get stock => _stock;
  set stock(int value) => _stock = value;

  String get image => _image;
  set image(String value) => _image = value;

  String get description => _description;
  set description(String value) => _description = value;

  int get quantity => _quantity;
  set quantity(int value) => _quantity = value;

  // Format harga ke bentuk Rp
  String get formattedPrice {
    return "Rp${_price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => "${m[1]}.",
    )}";
  }

  // Info lengkap produk
  @override
  String getInfo() =>
      "Product: $_name | Price: $_price | Stock: $_stock | Qty: $_quantity | Desc: $_description";
}
