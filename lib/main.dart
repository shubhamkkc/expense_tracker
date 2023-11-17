

import 'package:expense_tracker/ui/expenses.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)),
    home: Expenses(),
  ));
}