import 'package:expense_tracker/models/expense_model.dart';

import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList(
      {super.key, required this.expensesList, required this.removeExpense});
  final List<ExpenseModel> expensesList;
  final Function(ExpenseModel expense) removeExpense;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.expensesList.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              ),
              key: ValueKey(widget.expensesList[index]),
              onDismissed: (DismissDirection direction) =>
                  widget.removeExpense(widget.expensesList[index]),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.expensesList[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${widget.expensesList[index].amount.toStringAsFixed(2)} ₹'),
                          Row(
                            children: [
                              Icon(categoryIcons[
                                  widget.expensesList[index].mode]),
                              // Text( "${widget.expensesList[index].date.day}/${widget.expensesList[index].date.month}/${widget.expensesList[index].date.year}")
                              Text(widget.expensesList[index].formatDate)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
