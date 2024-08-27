class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String ?image;
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    price: double.parse(json['price'].toString()),
    description: json['description'],
    category: json['category'],
    image: json['image'],
    rating: Rating.fromJson(json['rating']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,

  };
}

class Rating {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: double.parse((json['rate']??0).toString()),
    count: json['count']??0,
  );

  Map<String, dynamic> toJson() => {
    'rate': rate,
    'count': count,
  };
}
