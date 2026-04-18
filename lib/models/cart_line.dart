import 'food_item.dart';

class CartLine {
  const CartLine({required this.item, required this.quantity});

  final FoodItem item;
  final int quantity;

  double get total => item.price * quantity;

  CartLine copyWith({FoodItem? item, int? quantity}) {
    return CartLine(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}
