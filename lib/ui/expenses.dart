import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expense_add.dart';
import 'package:expense_tracker/widget/expense_list.dart';
import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<ExpenseModel> expensesList = [];
  void addExpense(ExpenseModel expense) {
    setState(() {
      expensesList.add(expense);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Expenses Added")));
  }

  void removeExpense(ExpenseModel expense) {
    final expenseIndex = expensesList.indexOf(expense);
    setState(() {
      expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "undo",
            onPressed: () => setState(() {
                  expensesList.insert(expenseIndex, expense);
                })),
        content: const Text("expense deleted")));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = expensesList.isEmpty
        ? Center(child: Text("No Expenses Available"))
        : ExpenseList(expensesList: expensesList, removeExpense: removeExpense);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return ExpenseAdd(expenseAdd: addExpense);
                  });
            },
            icon: const Icon(Icons.add))
      ], title: const Text("Expense Tracker")),
      body: Column(
        children: [
          Chart(
            expenses: expensesList,
          ),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
