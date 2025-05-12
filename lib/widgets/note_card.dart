import 'package:flutter/material.dart';

// class NoteCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final bool isPinned;
//   final VoidCallback onPinTap;
//   final VoidCallback onEditTap;
//   final VoidCallback onDeleteTap;

//   const NoteCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.isPinned,
//     required this.onPinTap,
//     required this.onEditTap,
//     required this.onDeleteTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     isPinned ? Icons.push_pin : Icons.push_pin_outlined,
//                     color: isPinned ? Colors.orange : Colors.grey,
//                   ),
//                   onPressed: onPinTap,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 8),

//             Text(
//               description,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 16),
//             ),

//             const SizedBox(height: 12),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.blueAccent),
//                   onPressed: onEditTap,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.redAccent),
//                   onPressed: onDeleteTap,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final Timestamp date;
  final bool isPinned;
  final VoidCallback onPinTap;
  final VoidCallback? onTap;
  Color? bgColor;
  NoteCard({
    super.key,
    this.bgColor,
    required this.title,
    required this.description,
    required this.date,
    required this.isPinned,
    required this.onPinTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'MMMM d, yyyy',
    ).format(date.toDate());

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor ?? Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),

              // Pin Icon Button
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: isPinned ? Colors.orange : Colors.grey,
                  ),
                  onPressed: onPinTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
