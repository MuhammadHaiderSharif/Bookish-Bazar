bool login = false;

Book toBookBookmark(Map<String, dynamic> book) {
  return Book(
    title: book['title'],
    subtitle: book['subtitle'],
    image: book['image'],
    rating: book['rating'],
    description: book['description'],
    price: book['price'],
  );
}

Book toBookCart(Map<String, dynamic> book) {
  return Book(
    title: book['title'],
    subtitle: book['subtitle'],
    image: book['image'],
    rating: book['rating'],
    description: book['description'],
    price: book['price'],
    quantity: book['quantity'],
  );
}

class Book {
  Book({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.description,
    required this.price,
    this.quantity = 1,
  });

  final String title, subtitle, image, description;
  final double rating, price;
  int quantity;

  Map<String, dynamic> toMapCart() {
    return {
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'rating': rating,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toMapBookmark() {
    return {
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'rating': rating,
      'description': description,
      'price': price,
    };
  }
}
