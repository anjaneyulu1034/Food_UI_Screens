import 'package:flutter/material.dart';

import 'package:food_app/models/cart_line.dart';
import 'package:food_app/models/food_item.dart';

class CartController extends ChangeNotifier {
  final Map<String, CartLine> linesById = <String, CartLine>{};

  List<CartLine> get lines => linesById.values.toList(growable: false);

  int get itemCount {
    return linesById.values.fold<int>(
      0,
      (int total, CartLine line) => total + line.quantity,
    );
  }

  double get subtotal {
    return linesById.values.fold<double>(
      0,
      (double total, CartLine line) => total + line.total,
    );
  }

  double get deliveryFee => lines.isEmpty ? 0 : 2.5;

  double get total => subtotal + deliveryFee;

  bool contains(FoodItem item) => linesById.containsKey(item.id);

  void addItem(FoodItem item) {
    final CartLine? line = linesById[item.id];

    if (line == null) {
      linesById[item.id] = CartLine(item: item, quantity: 1);
    } else {
      linesById[item.id] = line.copyWith(quantity: line.quantity + 1);
    }

    notifyListeners();
  }

  void decreaseItem(FoodItem item) {
    final CartLine? line = linesById[item.id];

    if (line == null) {
      return;
    }

    if (line.quantity <= 1) {
      linesById.remove(item.id);
    } else {
      linesById[item.id] = line.copyWith(quantity: line.quantity - 1);
    }

    notifyListeners();
  }

  void removeItem(FoodItem item) {
    linesById.remove(item.id);
    notifyListeners();
  }

  int quantityFor(FoodItem item) => linesById[item.id]?.quantity ?? 0;
}
