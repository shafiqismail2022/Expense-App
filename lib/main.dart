import 'dart:io';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import './widgets/new_transaction.dart';

// import './widgets/transaction_list.dart';
import './widgets/adaptiveFlatButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import './widgets/chart.dart';
import 'package:expenseapp/widgets/new_transaction.dart';
import 'package:expenseapp/widgets/transaction_list.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([  //Restricting the app in portrait Mode
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense App',
      theme: ThemeData(
          //Changing the theme changes colors of all widgets
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  //Applying changes to all titles in the app bar
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
          )), // primarySwatch uses a single color with different shades
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> with WidgetsBindingObserver {
  final List<Transaction> transactions = [];
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 120.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Clothes',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'New phone',
    //   amount: 200,
    //   date: DateTime.now(),
    // ),
  ];
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }
 
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifeCycleState(AppLifecycleState state) {
    print(state);
  }

  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txamount, DateTime chossenDate) {
    final newtx = Transaction(
      title: txTitle,
      amount: txamount,
      id: DateTime.now().toString(),
      date: chossenDate,
    );

    setState(() {
      _userTransaction.add(newtx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      return _userTransaction.removeWhere((tx) => tx.id == id);
    });

    // print('***********Debug********');
  }

  List<Widget> _buildLandscapeMode(MediaQueryData mediaQuerry,
      PreferredSizeWidget appBar, Widget TxListWidget) {
    return [
      Row(
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuerry.size.height -
                      appBar.preferredSize.height -
                      mediaQuerry.padding.top) *
                  0.7,
              child: Chart(_recentTransaction),
            )
          : TxListWidget
    ];
  }

  List<Widget> _buildPortraitMode(MediaQueryData mediaQuerry,
      PreferredSizeWidget appBar, Widget TxListWidget) {
    return [
      Container(
        height: (mediaQuerry.size.height -
                appBar.preferredSize.height -
                mediaQuerry.padding.top) *
            0.7,
        child: Chart(_recentTransaction),
      ),
      TxListWidget,
    ];
  }

  //   late String titleInput;
  //  late String amountInput;
  @override
  Widget build(BuildContext context) {
    final mediaQuerry = MediaQuery.of(context);
    final isLandScape = mediaQuerry.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Perosnal Expense Appp'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expense App'),
            actions: <Widget>[
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              )
            ],
          )) as PreferredSizeWidget;
    final TxListWidget = Container(
      height: (mediaQuerry.size.height -
              appBar.preferredSize.height -
              mediaQuerry.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );
    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        //Allows to scroll the entire page
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandScape)
                ..._buildLandscapeMode(mediaQuerry, appBar, TxListWidget),
              if (!isLandScape)
                ..._buildPortraitMode(mediaQuerry, appBar, TxListWidget),

              // Container(
              //   width: double.infinity,
              //   child: Card(
              //     //The card size depend on the size of its child
              //     color: Colors.blue,
              //     //child:Container(
              //     // width: 100,
              //     child: Text('Chart'), elevation: 5,
              //   ),
              // ), // We also wrap the card in the container to increase its size
              // NewTransaction(),
              // TransactionList()
              // Card(
              //   color: Colors.red,
              //   child: Text('List of Transaction'),
              // ),
            ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
