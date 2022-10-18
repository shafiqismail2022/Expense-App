// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_literals_to_create_immutables
import './transaction_Item.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transaction.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transaction available',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'lib/Assets/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              })
            : ListView(
                children: transaction
                    .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTx: deleteTx))
                    .toList(),
              )
        // : ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       return TransactionItem(transaction: transaction[index], deleteTx: deleteTx);
        //     },
        //     itemCount: transaction
        //         .length,
        //          ),
        // listView uses the height of the parent widget used for short list and list.builder is used for long list
        // children: transaction.map((tx) {}).toList(),
        // return Card(
        //   child: Row(
        //     children: <Widget>[
        //       Container(
        //         // Styling a container
        //         margin:
        //             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //         decoration: BoxDecoration(
        //             border: Border.all(
        //                 width: 2,
        //                 color: Theme.of(context).primaryColor)),
        //         padding: EdgeInsets.all(10),
        //         child: Text(
        //           '\$${transaction[index].amount.toStringAsFixed(2)}', //string interpolation using $ e.g $tx outputs instance of tx
        //           // tx.amount.toString(),
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 29,
        //             color: Colors.purple,
        //           ),
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(transaction[index].title,
        //               style: Theme.of(context).textTheme.headline6),
        //           Text(
        //             DateFormat.yMMMd().format(transaction[index]
        //                 .date), //It can also be written as DateFormat(yyyy/MM/dd).format(tx.date)
        //             style: TextStyle(
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // );

        );
  }
}
