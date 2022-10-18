// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_field, unnecessary_null_comparison
import 'dart:io';
import '../widgets/adaptiveFlatButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;
  NewTransaction(this.newTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>  {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate;
  _NewTransactionState() {
    print('Constructor _NewTransaction State ');
  }
  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('DidUpdate Widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('Dispose()');
    super.dispose();
  }

  void _submitData() {
    if (_amountControler.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.newTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Enter Title'),
                controller: _titleControler,
                // onChanged: (val1) {
                //   titleInput = val1;
                // },
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Enter Amount'),
                controller: _amountControler,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val2) {
                //   amountInput = val2;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date choosen'
                            : 'Picked Date ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    AdaptiveFlatButton("Choose date", _datePicker),
                    // TextButton(
                    //   onPressed: _datePicker,
                    //   child: Text("Choose date"),
                    // ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button?.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
