import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/cart_provider.dart';

class Order{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({required this.id, required this.amount, required this.products, required this.dateTime});
}

class OrdersProvider with ChangeNotifier{
  List<Order> _orders = [];

  List<Order> get orders{
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double total){
    _orders.insert(0, Order(id:DateTime.now().toString(), amount: total, dateTime: DateTime.now(), products: products));
    notifyListeners();
  }
}