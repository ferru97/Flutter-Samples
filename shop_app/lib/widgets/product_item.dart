import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    Product prod = Provider.of<Product>(context);
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return Consumer<Product>(
      builder: (ctx, prod, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            footer: GridTileBar(
              leading: IconButton(
                icon: Icon(
                  prod.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => prod.toggleFavoriteStatus(),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  cart.addItem(prod.id, prod.price, prod.title);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Added item to cart"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () => cart.removeItem(id),
                    ),
                  ));
                },
              ),
              title: Text(
                prod.title,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black87,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.nameRoute,
                    arguments: prod.id);
              },
              child: Image.network(
                prod.imageUrl,
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
