import 'package:flutter/material.dart';
import 'package:todo_list/views/widgets/custom_tab_widget.dart';

class TaskHeader extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabs;
  final ValueChanged<int> onTabSelected;

  const TaskHeader({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Header Container
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 208, 214, 248),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
          ),
          padding: const EdgeInsets.only(top: 60.0, bottom: 70.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 24.0,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Hi! User',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'This is just a sample UI.\nOpen to create your style :D',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Custom Tab Bar
        Positioned(
          bottom: -16,
          left: 16.0,
          right: 16.0,
          child: Center(
            child: CustomTabWidget(
              tabs: tabs,
              selectedIndex: selectedIndex,
              onTabSelected: onTabSelected,
            ),
          ),
        ),
      ],
    );
  }
}