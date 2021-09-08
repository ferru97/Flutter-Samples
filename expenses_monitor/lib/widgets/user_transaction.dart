
import 'package:expenses_monitor/models/transaction.dart';
import 'package:expenses_monitor/widgets/transactionList.dart';
import 'package:flutter/material.dart';

import 'new_transaction.dart';

class UserTransaction extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => UserTransactionState();

}

class UserTransactionState extends State<UserTransaction> {

  final List<Transaction> transactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
        id: "t2",
        title: "Weekly Groceries",
        amount: 20.15,
        date: DateTime.now()),
  ];


  void _addNewTransaction(String title, double amount){
    final Transaction newTransaction = Transaction(id:DateTime.now().toString(), title:title, amount:amount, date:DateTime.now());
    setState(() {
      transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [


    ],);
  }

}
