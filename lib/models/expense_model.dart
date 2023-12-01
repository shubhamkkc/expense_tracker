import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var formater = DateFormat.yMd();

const uuid = Uuid();

enum Mode { food, travel, lesiure, work }

const categoryIcons = {
  Mode.food: Icons.lunch_dining,
  Mode.travel: Icons.flight_takeoff,
  Mode.work: Icons.work,
  Mode.lesiure: Icons.movie
};

class ExpenseModel {
  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.mode})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Mode mode;

  get formatDate {
    return formater.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.mode, this.expenses);

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.mode)
      : expenses =
            allExpenses.where((expense) => expense.mode == mode).toList();

  final Mode mode;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
