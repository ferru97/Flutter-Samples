import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_sreen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreens extends StatefulWidget {
  ProductOverviewScreens({Key? key}) : super(key: key);

  @override
  _ProductOverviewScreensState createState() => _ProductOverviewScreensState();
}

class _ProductOverviewScreensState extends State<ProductOverviewScreens> {
  bool _showOnlyFavrites = false;

  @override
  Widget build(BuildContext context) {
    //final products = Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      body: ProductGrid(_showOnlyFavrites),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  //products.showFavoritesOnly();
                  _showOnlyFavrites = true;
                } else {
                  //products.showAll();
                  _showOnlyFavrites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
            builder: (_, cartData, child) {
                return Badge(
                  child: child!,
                  value: cartData.itemCount.toString(),
                  color: Theme.of(context).accentColor,
            );
          }),
        ],
        title: Text("MyShop"),
      ),
    );
  }
}
