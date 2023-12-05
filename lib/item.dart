import 'package:flutter/material.dart';
import 'package:jobs_app/job.dart';

class Item extends StatelessWidget {
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final Job data;

  const Item({super.key, required this.data, required this.onDeletePressed, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: null,
        border: Border.all(
          color: colors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  data.email,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
