import 'package:flutter/material.dart';

import 'dashboard_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CategoryCard(title: 'Fruits', icon: Icons.local_florist),
                  CategoryCard(
                      title: 'Vegetables', icon: Icons.local_grocery_store),
                  CategoryCard(title: 'Dairy', icon: Icons.icecream),
                  CategoryCard(title: 'Meat', icon: Icons.fastfood),
                  CategoryCard(title: 'Grains', icon: Icons.rice_bowl),
                ],
              ),
            ),
            SizedBox(height: 20), // Spasi antara ListView dan tombol
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(
                      username: 'DashboardPage',
                    ), // Ganti dengan halaman utama Anda
                  ),
                );
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryCard({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(title, style: TextStyle(fontSize: 20)),
        onTap: () {
          // Handle category tap
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected $title')),
          );
        },
      ),
    );
  }
}
