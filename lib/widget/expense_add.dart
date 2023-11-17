import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd(this.expenseAdd,{super.key});
  final Function expenseAdd;

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
    final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool isDatePicked = false;
  List<String> modeOfTransaction = Mode.values.map((e) => e.name).toList();
  String _selectedMode = "Lesiure";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isDatePicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   late  String title;
    late  double amount;
   late  DateTime date;
   late  String mode;
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty)
                  {
                    return "please enter a title";
                  }
                   return null;
                } ,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                maxLength: 40,
                onSaved: (newValue) => 
                title = newValue!,
              ),
              
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: TextFormField(
                         validator: (value) {
                  if(value==null || value.isEmpty|| value=='0.0' )
                  {
                    return "please enter a valid Amount";
                  }
                   return null;
                } ,
                          decoration: const InputDecoration(
                    label: Text("Amount"),
                  ))),
                  (isDatePicked == false)
                      ? const Text("No date selected")
                      : Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_month)),
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: _selectedMode,
                    items: modeOfTransaction.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedMode = val!;
                      });
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();

                   widget.expenseAdd(
                   ExpenseModel( title: title , amount: amount, date: date, mode: mode)
                   );

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Expenses Added")));
                          }
                        },
                        child: const Text("Add"),
                      )
                    ],
                  ),
                ],
              )
            ],

          ),

        ),
      ),
    );
  }
}
