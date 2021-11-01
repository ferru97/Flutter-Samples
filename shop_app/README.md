# shop_app

Shop_App

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- State Manadgement
- const
- ListTile and GridTile
- ChangeNotifier PROVIDER & LISTENER PATTERN!
- [..._items] return a copy of the array for SAFETY
- Provider.of<ProductsProvider>(context) looks up one levet at time until find a ProductsProvider with also listen: false
- ChangeNotifierProvider.value instead of previous if we do not need the ctx in create, USE IT IN LIST
- when creating a new object use Provider.of<ProductsProvider>(context) since most efficient, otherwise use .value if reuse objects
- Consumer<> instead of Provider.of<>, useful if you want to wrap a subpart of the et with Consumer<> to avoid extra rebuild of all tre wt
- Chip
- Dismissable
- SnackBar
- TextEditingController
- Form widget  REMEMBER TO DISPOSE FOCUSNODES WHEN EXIT A SCREEN!
- Expanded widget
- Form element if you have controller you cannot have initialValue
- Custom exceptions
- Futurebuilder widget
- Try on catch
- ChangeNotifyProxyProvider: rebuild provider when another provider change
- SharedPreferences package for persistent storage