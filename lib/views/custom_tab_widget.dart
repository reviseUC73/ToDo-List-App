import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomTabWidget({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(color: Colors.white, offset: Offset(-3, -3), blurRadius: 6),
          BoxShadow(color: Colors.grey.shade400, offset: Offset(3, 3), blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          Color.fromARGB(255, 139, 212, 255),
                          Color.fromARGB(255, 90, 126, 224),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: isSelected
                    ? [BoxShadow(color: const Color.fromARGB(68, 11, 11, 11), blurRadius: 10, offset: Offset(-1, 4))]
                    : null,
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}