import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? Column(
        children: [
          Text(
            "No data yet",
            style: Theme
                .of(context)
                .textTheme
                .title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 200,
              child: Image.asset(
                "assets/images/sleep.png",
                fit: BoxFit.cover,
              )),
        ],
      )
          : ListView.builder(
        //differ from listVIew() that is simply a scrollable column. This instead render only the widget that are actually on screen
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text("\$${transactions[index].amount}"),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme
                    .of(context)
                    .errorColor,
                onPressed: () {
                  deleteTx(transactions[index].id);
                },
              ),
            ),
          );

          /*Card( //you can use instead ListTile that have preconfigured leading-title-subtitle-trailing
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "\$${transactions[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );*/
        },
      ); //toList since map returns an it return an iterable;,
  }
}
