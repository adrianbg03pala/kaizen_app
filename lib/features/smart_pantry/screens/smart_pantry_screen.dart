import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

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
    {'name': 'Huevos (docena)', 'price': 4.50, 'category': 'Proteínas', 'checked': false},
    {'name': 'Manzanas', 'price': 2.20, 'category': 'Frutas', 'checked': false},
  ];

  double get _total => _products.fold(0, (sum, item) => sum + (item['price'] as num));
  int get _checkedCount => _products.where((p) => p['checked'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Pantry - Lista de Compra'),
        backgroundColor: AppTheme.darkGrey,
      ),
      body: Container(
        color: AppTheme.darkBg,
        child: Column(
          children: [
            // Total estimado
            Container(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: AppTheme.darkGrey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total estimado',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$_checkedCount comprados',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Productos
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    color: AppTheme.darkGrey,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: CheckboxListTile(
                      value: product['checked'] as bool,
                      activeColor: AppTheme.primaryColor,
                      onChanged: (value) {
                        setState(() => _products[index]['checked'] = value ?? false);
                      },
                      title: Text(
                        product['name'] as String,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['category'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                          Text(
                            '\$${(product['price'] as num).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          // TODO: Abrir diálogo para agregar producto
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Funcionalidad en desarrollo'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: AppTheme.darkBg,
        ),
      ),
    );
  }
}
