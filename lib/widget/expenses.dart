import 'package:expense_tracker/widget/expenseList/expenses_list.dart';
import 'package:flutter/material.dart';

import '../model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter course",
      category: Category.work,
      date: DateTime.now(),
      amount: 999.99,
    ),
    Expense(
      title: "Netflix subscription",
      category: Category.leisure,
      date: DateTime.now(),
      amount: 199,
    ),
    Expense(
      title: "Dinner",
      category: Category.food,
      date: DateTime.now(),
      amount: 1400,
    ),
    Expense(
      title: "Long drive",
      category: Category.travel,
      date: DateTime.now(),
      amount: 4000,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text("Expense chart"),
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
