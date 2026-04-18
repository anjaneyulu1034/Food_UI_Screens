import 'package:flutter/material.dart';

import 'package:food_app/models/cart_line.dart';
import 'package:food_app/state/cart_controller.dart';

class CartLineTile extends StatelessWidget {
  const CartLineTile({super.key, required this.line, required this.controller});

  final CartLine line;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.network(
                line.item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (
                      BuildContext context,
                      Object objectError,
                      StackTrace? stackTrace,
                    ) {
                      return const ColoredBox(
                        color: Color(0xFFF3F4F6),
                        child: Icon(Icons.fastfood_rounded),
                      );
                    },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  line.item.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${line.item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFFFF7A45),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    QtyButton(
                      icon: Icons.remove,
                      onTap: () => controller.decreaseItem(line.item),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        line.quantity.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    QtyButton(
                      icon: Icons.add,
                      onTap: () => controller.addItem(line.item),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => controller.removeItem(line.item),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QtyButton extends StatelessWidget {
  const QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
