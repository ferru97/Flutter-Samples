import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final _showOnlyFavorites;

  const ProductGrid(this._showOnlyFavorites);

  @override
  Widget build(BuildContext context) {
    final ProductsProvider data = Provider.of<ProductsProvider>(context);
    final List<Product> products = _showOnlyFavorites ? data.favoriteItems : data.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(
            products[index].id,
            products[index].title,
            products[index].imageUrl,
          ),
        ));
  }
}
