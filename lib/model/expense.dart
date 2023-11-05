import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { food, leisure, travel, work }

const categoryIcons = {
  Category.food: Icons.dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.travel_explore,
  Category.work: Icons.work
};

const uuid = Uuid();
var formatter = DateFormat.yMMMEd();

class Expense {
  Expense({
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final Category category;
  final double amount;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expensesList});

  final Category category;
  final List<Expense> expensesList;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expensesList = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenseForACategory {
    double sum = 0;
    for (final expense in expensesList) {
      sum += expense.amount;
    }

    return sum;
  }
}
