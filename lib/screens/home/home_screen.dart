import 'package:flutter/material.dart';
import 'package:food_app/data/mock_food_data.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/state/cart_controller.dart';
import 'package:food_app/widgets/category_chip.dart';
import 'package:food_app/widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final CartController controller;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  final PageController bannerController = PageController(viewportFraction: 0.9);
  int activeBannerIndex = 0;

  List<FoodItem> get bannerItems => foodItems.take(3).toList(growable: false);

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }

  List<FoodItem> get filteredItems {
    if (selectedCategory == 'All') {
      return foodItems;
    }

    return foodItems
        .where((FoodItem item) => item.category == selectedCategory)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
                child: Row(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Location',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Madhapur, Hyderabad',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: widget.controller,
                      builder: (BuildContext context, Widget? animatedChild) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext routeContext) =>
                                        CartScreen(
                                          controller: widget.controller,
                                        ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_bag_outlined),
                            ),
                            if (widget.controller.itemCount > 0)
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${widget.controller.itemCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: Text(
                  'Hungry?\nFind your favorite food',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search dishes, restaurants...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 46,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: foodCategories.length,
                  separatorBuilder:
                      (BuildContext separatorContext, int separatorIndex) =>
                          const SizedBox(width: 10),
                  itemBuilder: (BuildContext context, int index) {
                    final category = foodCategories[index];
                    return CategoryChip(
                      label: category,
                      selected: category == selectedCategory,
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: bannerController,
                  itemCount: bannerItems.length,
                  onPageChanged: (int index) {
                    setState(() {
                      activeBannerIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final FoodItem item = bannerItems[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(18, 14, 8, 0),
                      child: GestureDetector(
                        onTap: () {
                          widget.controller.addItem(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} added to cart'),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (
                                      BuildContext context,
                                      Object objectError,
                                      StackTrace? stackTrace,
                                    ) {
                                      return const ColoredBox(
                                        color: Color(0xFFFFE5D9),
                                        child: Icon(Icons.fastfood_rounded),
                                      );
                                    },
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color(0x22000000),
                                      Color(0xC8000000),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Special Offer',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tap to add for \$${item.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(bannerItems.length, (
                    int index,
                  ) {
                    final bool isActive = index == activeBannerIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 18 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFFF7A45)
                            : const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Popular now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFFFF7A45),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredItems.take(4).length,
                  separatorBuilder:
                      (BuildContext separatorContext, int separatorIndex) =>
                          const SizedBox(width: 14),
                  itemBuilder: (BuildContext context, int index) {
                    final item = filteredItems[index];
                    return FoodCard(
                      compact: true,
                      item: item,
                      onTap: () => showDetails(item),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
                child: Text(
                  'Recommended for you',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
              sliver: SliverList.separated(
                itemCount: filteredItems.length,
                separatorBuilder:
                    (BuildContext separatorContext, int separatorIndex) =>
                        const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredItems[index];
                  return FoodCard(item: item, onTap: () => showDetails(item));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget? animatedChild) {
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext routeContext) =>
                      CartScreen(controller: widget.controller),
                ),
              );
            },
            backgroundColor: const Color(0xFFFF7A45),
            foregroundColor: Colors.white,
            icon: const Icon(Icons.shopping_bag_outlined),
            label: Text('${widget.controller.itemCount} items'),
          );
        },
      ),
    );
  }

  Future<void> showDetails(FoodItem item) async {
    int quantity = 1;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (
                BuildContext context,
                void Function(void Function()) setBottomSheetState,
              ) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: 1.65,
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        style: const TextStyle(color: Color(0xFF6B7280)),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB200),
                          ),
                          const SizedBox(width: 4),
                          Text(item.rating.toStringAsFixed(1)),
                          const SizedBox(width: 12),
                          const Icon(Icons.access_time_rounded, size: 18),
                          const SizedBox(width: 4),
                          Text(item.deliveryTime),
                          const Spacer(),
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFFFF7A45),
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: quantity > 1
                                      ? () {
                                          setBottomSheetState(() {
                                            quantity--;
                                          });
                                        }
                                      : null,
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setBottomSheetState(() {
                                      quantity++;
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                for (int count = 0; count < quantity; count++) {
                                  widget.controller.addItem(item);
                                }
                                Navigator.of(context).pop();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFFF7A45),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: Text(
                                'Add to cart \$${(item.price * quantity).toStringAsFixed(2)}',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
        );
      },
    );
  }
}
