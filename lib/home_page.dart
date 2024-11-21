import 'package:flutter/material.dart';
import 'package:food_app/category_page.dart';
import 'package:food_app/dashboard_page.dart';
import 'package:food_app/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar item makanan dengan nama dan path gambar lokal
  final List<Map<String, String>> foodItems = [
    {
      'name': 'Pizza',
      'image': 'assets/images/pizza.png',
    },
    {
      'name': 'Pasta',
      'image': 'assets/images/pasta.png',
    },
    {
      'name': 'Salad',
      'image': 'assets/images/salad.png',
    },
    {
      'name': 'Drinks',
      'image': 'assets/images/pizza.png',
    },
  ];

  final Map<String, int> cartItems = {};

  void addToCart(String item) {
    setState(() {
      cartItems[item] = (cartItems[item] ?? 0) + 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Produk berhasil ditambahkan dalam keranjang"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void removeFromCart(String item) {
    setState(() {
      if (cartItems.containsKey(item) && cartItems[item]! > 1) {
        cartItems[item] = cartItems[item]! - 1;
      } else {
        cartItems.remove(item);
      }
    });
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardPage(
                        username: 'DashboardPage',
                      )), // Navigasi ke halaman dashboard
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: navigateToCart,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          String itemName = foodItems[index]['name']!;
          String itemImage = foodItems[index]['image']!;

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: 20, // Tinggi maksimal gambar
                      width: 20, // Lebar maksimal gambar
                      child: Image.asset(
                        itemImage,
                        fit: BoxFit
                            .cover, // Menjaga gambar sesuai dengan pembungkus
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        itemName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => removeFromCart(itemName),
                          ),
                          Text(
                            '${cartItems[itemName] ?? 0}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => addToCart(itemName),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final Map<String, int> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                String item = cartItems.keys.elementAt(index);
                int quantity = cartItems[item]!;
                return ListTile(
                  title: Text(item),
                  trailing: Text('Quantity: $quantity'),
                );
              },
            ),
    );
  }
}
