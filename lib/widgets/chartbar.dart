// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String labeling;
  final double spendingAmount;
  final double spendingPercentTotal;
  const ChartBar(this.labeling, this.spendingAmount, this.spendingPercentTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.05,
                child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.5,
                width: 10,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(
                          220,
                          220,
                          220,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingPercentTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.05,
                child: FittedBox(
                  child: Text(labeling),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
