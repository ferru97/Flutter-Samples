import 'package:expenses_monitor/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0.0, (sum, item) => sum + (item["amount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding( //Like container but used only to give padding
          padding: EdgeInsets.all(10),
          child: Row(children: [
            ...groupedTransactionValues.map((tx) {
              return Flexible(
                //flex: x, //takex x more thananother   --- - -- flex 3-2-1
                fit: FlexFit.tight,
                child: ChartBar(
                  tx["day"].toString(),
                  (tx["amount"] as double),
                  maxSpending==0 ? 0.0 : (tx["amount"] as double) / maxSpending,
                ),
              );
            }).toList(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,),
        ),
      );
  }
}
