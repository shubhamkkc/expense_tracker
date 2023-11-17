import 'package:expense_tracker/widget/chart.dart';
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
  List<ExpenseModel> expensesList = [
    ExpenseModel(
        title: 'cinema', amount: 500, date: DateTime.now(), mode: Mode.Work)
  ];
    addExpense(ExpenseModel expense){
    expensesList.add(expense);

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(actions: [IconButton(onPressed: (){
      showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return  ExpenseAdd(addExpense);
      

    });
      
      }, icon: const Icon(Icons.add))],
      title: const Text("Expense Tracker")),
      body:  Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [Chart(),
          ExpenseList(expensesList)
          ],
      
        ),
      ),
    );
  }
}