// import 'package:flutter/material.dart';
// import '../../models/task.dart';

// class TaskCard extends StatelessWidget {
//   final Task task;

//   const TaskCard({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 4,
//       child: ListTile(
//         leading: Icon(task.icon),
//         title: Text(task.title),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(task.description),
//             SizedBox(height: 4),
//             Text(
//               task.date,
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }