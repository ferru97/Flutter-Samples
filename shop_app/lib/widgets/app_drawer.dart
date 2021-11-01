import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello  Friend!"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            title: Text("Shop"),
            leading: Icon(Icons.shop),
            onTap: ()=>Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            title: Text("Orders"),
            leading: Icon(Icons.payment),
            onTap: ()=>Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
          ),
          Divider(),
          ListTile(
            title: Text("Manage Products"),
            leading: Icon(Icons.edit),
            onTap: ()=>Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}
