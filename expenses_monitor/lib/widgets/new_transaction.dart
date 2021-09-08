import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String titleInput = "";
  DateTime? selectedDate; //? ALLOW NULLABLE TYPE
  String amountInput = "";

  void _addTransaction() {
    if (this.titleInput.isEmpty || this.amountInput.isEmpty || selectedDate==null) return;
    this.widget.addTransaction(
          this.titleInput,
          double.parse(this.amountInput),
          selectedDate,
        );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate==null)
        return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top:10, left:10, right:10, bottom: MediaQuery.of(context).viewInsets.bottom+10 ), //bottom depend on keyboard
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                onChanged: (String val) => this.titleInput = val,
                onSubmitted: (_) => _addTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                onChanged: (String val) => this.amountInput = val,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate==null ? 'No Date' : DateFormat.yMd().format(selectedDate!)
                      ),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        "Choose date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _addTransaction,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                child: Text("Add Transaction"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
