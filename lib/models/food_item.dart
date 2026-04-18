class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.deliveryTime,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final double rating;
  final String deliveryTime;
  final String imageUrl;
}
