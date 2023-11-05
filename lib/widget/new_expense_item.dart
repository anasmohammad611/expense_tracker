import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpenseItem extends StatefulWidget {
  NewExpenseItem({super.key, required this.onAddExpense});

  void Function(Expense) onAddExpense;

  @override
  State<NewExpenseItem> createState() => _NewExpenseItemState();
}

class _NewExpenseItemState extends State<NewExpenseItem> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _category = Category.work;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void clear() {
    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitResponse() {
    double? enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Invalid'),
            content:
                const Text('Fill the correct data before saving the expense'),
            actions: [
              TextButton(
                onPressed: () {
                  return Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        category: _category,
        date: _selectedDate!,
        amount: enteredAmount,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Add Title'),
              ),
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              controller: _amountController,
              maxLength: 50,
              decoration: const InputDecoration(
                prefixText: '₹ ',
                label: Text('Add amount'),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    value: _category,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _category = value;
                      });
                    },
                  ),
                  const Spacer(),
                  Text(_selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(onPressed: clear, child: const Text('clear')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel')),
                ElevatedButton(
                  onPressed: _submitResponse,
                  child: const Text('Submit'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
