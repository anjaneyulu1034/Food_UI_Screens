import 'package:food_app/models/food_item.dart';

const List<String> foodCategories = <String>[
  'All',
  'Pizza',
  'Burger',
  'Salad',
  'Dessert',
  'Drinks',
];

const List<FoodItem> foodItems = <FoodItem>[
  FoodItem(
    id: '1',
    name: 'Margherita Pizza',
    category: 'Pizza',
    description:
        'Fresh basil, mozzarella, and rich tomato sauce on wood-fired crust.',
    price: 9.99,
    rating: 4.8,
    deliveryTime: '20-25 min',
    imageUrl:
        'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=1200',
  ),
  FoodItem(
    id: '2',
    name: 'Classic Beef Burger',
    category: 'Burger',
    description:
        'Juicy grilled patty with cheddar, lettuce, caramelized onion, and house sauce.',
    price: 7.49,
    rating: 4.7,
    deliveryTime: '15-20 min',
    imageUrl:
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=1200',
  ),
  FoodItem(
    id: '3',
    name: 'Caesar Salad',
    category: 'Salad',
    description:
        'Romaine, parmesan, croutons, and creamy Caesar dressing with lemon.',
    price: 6.25,
    rating: 4.5,
    deliveryTime: '10-15 min',
    imageUrl:
        'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=1200',
  ),
  FoodItem(
    id: '4',
    name: 'Double Cheese Burger',
    category: 'Burger',
    description:
        'Two beef patties, double cheddar, pickles, and smoky chipotle mayo.',
    price: 8.99,
    rating: 4.9,
    deliveryTime: '20-25 min',
    imageUrl:
        'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
  ),
  FoodItem(
    id: '5',
    name: 'Pepperoni Pizza',
    category: 'Pizza',
    description:
        'Thin-crust pizza loaded with pepperoni, mozzarella, and oregano.',
    price: 11.49,
    rating: 4.8,
    deliveryTime: '25-30 min',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=1200',
  ),
  FoodItem(
    id: '6',
    name: 'Chocolate Lava Cake',
    category: 'Dessert',
    description:
        'Warm chocolate cake with molten center and vanilla cream topping.',
    price: 5.75,
    rating: 4.7,
    deliveryTime: '10-12 min',
    imageUrl:
        'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=1200',
  ),
];
