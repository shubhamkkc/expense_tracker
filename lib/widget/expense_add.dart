import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd({required this.expenseAdd, super.key});
  final void Function(ExpenseModel expense) expenseAdd;

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool isDatePicked = false;
  // List<String> modeOfTransaction = Mode.values.map((e) => e.name).toList();
  Mode _selectedMode = Mode.lesiure;
  String? title;
  double? amount;
  DateTime? date;

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
        date = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      // color: Colors.white,
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
                  if (value == null || value.isEmpty) {
                    return "please enter a title";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                maxLength: 40,
                onSaved: (newValue) => setState(() {
                  title = newValue!;
                }),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: TextFormField(
                          onSaved: (newValue) => setState(() {
                                amount = double.tryParse(newValue!);
                              }),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == '0.0') {
                              return "please enter a valid Amount";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            suffixText: '₹',
                            label: Text("Amount"),
                          ))),
                  const SizedBox(
                    width: 65,
                  ),
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
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    value: _selectedMode,
                    items: Mode.values.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val == null) {
                        return;
                      }
                      setState(() {
                        _selectedMode = val;
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
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            widget.expenseAdd(ExpenseModel(
                                title: title!,
                                amount: amount!,
                                date: date ?? DateTime.now(),
                                mode: _selectedMode));
                            Navigator.of(context).pop();
                          }
                          return;
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
