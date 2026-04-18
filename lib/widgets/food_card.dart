import 'package:flutter/material.dart';

import 'package:food_app/models/food_item.dart';

class FoodCard extends StatefulWidget {
  const FoodCard({
    super.key,
    required this.item,
    required this.onTap,
    this.compact = false,
  });

  final FoodItem item;
  final VoidCallback onTap;
  final bool compact;

  @override
  State<FoodCard> createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = widget.compact ? 160 : double.infinity;

    return SizedBox(
      width: cardWidth,
      child: AnimatedScale(
        scale: isPressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.onTap,
          onTapDown: (TapDownDetails details) {
            setState(() {
              isPressed = true;
            });
          },
          onTapCancel: () {
            setState(() {
              isPressed = false;
            });
          },
          onTapUp: (TapUpDetails details) {
            setState(() {
              isPressed = false;
            });
          },
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: 'food-image-${widget.item.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AspectRatio(
                        aspectRatio: widget.compact ? 1.1 : 1.4,
                        child: Image.network(
                          widget.item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (
                                BuildContext context,
                                Object objectError,
                                StackTrace? stackTrace,
                              ) {
                                return Container(
                                  color: const Color(0xFFF2F2F2),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.fastfood_rounded),
                                );
                              },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.deliveryTime,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFB200),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(widget.item.rating.toStringAsFixed(1)),
                      const Spacer(),
                      Text(
                        '\$${widget.item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
