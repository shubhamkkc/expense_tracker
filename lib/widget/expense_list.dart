import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
   ExpenseList(List<ExpenseModel> expensesList,  {super.key});
 late  List<ExpenseModel> expensesList;


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
        itemBuilder: (BuildContext context, int index) => Container(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.expensesList[index].title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(widget.expensesList[index].amount.toString()+' ₹'),

                    Row(
                      children: [
                        Icon(Icons.abc),
                        Text( "${widget.expensesList[index].date.day}/${widget.expensesList[index].date.month}/${widget.expensesList[index].date.year}")
                      ],
                    )
                    ],

                  )],
                ),
            ));
  }
}
