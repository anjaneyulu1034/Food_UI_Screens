import 'package:flutter/material.dart';

import 'package:food_app/state/cart_controller.dart';
import 'package:food_app/widgets/cart_line_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.controller});

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? animatedChild) {
          final Widget pageContent = controller.lines.isEmpty
              ? const Center(
                  key: ValueKey<String>('cart-empty'),
                  child: Text('Your cart is empty. Add something tasty!'),
                )
              : SafeArea(
                  key: const ValueKey<String>('cart-items'),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          itemCount: controller.lines.length,
                          itemBuilder: (BuildContext context, int index) {
                            final line = controller.lines[index];
                            return CartLineTile(
                              line: line,
                              controller: controller,
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color(0x11000000),
                              blurRadius: 14,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            priceRow('Subtotal', controller.subtotal),
                            const SizedBox(height: 8),
                            priceRow('Delivery', controller.deliveryFee),
                            const Divider(height: 20),
                            priceRow(
                              'Total',
                              controller.total,
                              highlight: true,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF7A45),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text('Checkout'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.98, end: 1).animate(animation),
                  child: child,
                ),
              );
            },
            child: pageContent,
          );
        },
      ),
    );
  }

  Widget priceRow(String label, double value, {bool highlight = false}) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: highlight ? 16 : 14,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: highlight ? 18 : 14,
            fontWeight: FontWeight.w700,
            color: highlight ? const Color(0xFFFF7A45) : null,
          ),
        ),
      ],
    );
  }
}
