import 'package:expenses_monitor/widgets/new_transaction.dart';
import 'package:expenses_monitor/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transactionList.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          //user as default by floating button
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          )),
      home: MyHomePage(title: 'Expenses Monitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  List<Transaction> get _recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final Transaction newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final app_bar = AppBar(
      title: Text(
        widget.title,
      ),
      actions: [
        IconButton(
          onPressed: () {
            startAddNewTransactionModal(context);
          },
          icon: Icon(Icons.add),
        )
      ],
    );

    var showChart = false;
    final isHorizontal = MediaQuery.of(context).orientation == Orientation.landscape;
    var txList = Container(
        height: (MediaQuery.of(context).size.height -
            app_bar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
        child: TransactionList(transactions, _deleteTransaction)) ;
    var chart = Container(
        height: (MediaQuery.of(context).size.height -
            app_bar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
        child: Chart(_recentTransaction));

    return Scaffold(
        appBar: app_bar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startAddNewTransactionModal(context);
          },
        ),
        body: SingleChildScrollView(
          //Need to know the height of the widget can work with column but only if wrapped with Container
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if(isHorizontal)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(value: showChart, onChanged: (val){
                    print(val);
                    setState(() {
                      showChart = val;
                      print(val);
                    });
                  }),
                ],
              ),
              if(!isHorizontal) chart,
              if(!isHorizontal) txList,
              isHorizontal && showChart
              ? chart
              : txList,
            ],
          ),
        ));
  }
}
