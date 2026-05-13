import 'package:flutter/material.dart';

class SmartPantryScreen extends StatefulWidget {
  const SmartPantryScreen({super.key});

  @override
  State<SmartPantryScreen> createState() => _SmartPantryScreenState();
}

class _SmartPantryScreenState extends State<SmartPantryScreen> {
  final List<Map<String, dynamic>> _products = [
    {'name': 'Pollo pechuga', 'price': 8.50, 'category': 'Proteínas', 'checked': false},
    {'name': 'Arroz integral', 'price': 3.20, 'category': 'Carbohidratos', 'checked': false},
    {'name': 'Brócoli', 'price': 2.80, 'category': 'Verduras', 'checked': false},
    {'name': 'Batata', 'price': 1.50, 'category': 'Carbohidratos', 'checked': false},
  ];

  double get _total => _products.fold(0, (sum, item) => sum + (item['price'] as num));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Pantry')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total estimado', style: Theme.of(context).textTheme.titleMedium),
                    Text('\$${_total.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: CheckboxListTile(
                    value: product['checked'] as bool,
                    onChanged: (value) {
                      setState(() => _products[index]['checked'] = value ?? false);
                    },
                    title: Text(product['name'] as String),
                    subtitle: Text('${product['category']} • \$${product['price']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
