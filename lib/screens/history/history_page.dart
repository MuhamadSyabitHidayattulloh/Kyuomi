import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.trash),
            onPressed: () {
              // TODO: Implement clear all history
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Hapus Riwayat'),
                  content: const Text(
                      'Apakah anda yakin ingin menghapus semua riwayat?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Clear history logic
                        Navigator.pop(context);
                      },
                      child: const Text('Hapus'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Placeholder count
        itemBuilder: (context, index) {
          return ExpansionTile(
            leading: Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Icon(LineIcons.book, color: Colors.grey[600]),
              ),
            ),
            title: const Text(
              'Manga Title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Terakhir dibaca ${timeago.format(DateTime.now().subtract(const Duration(minutes: 5)))}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            children: List.generate(
              3,
              (chapterIndex) => ListTile(
                contentPadding: const EdgeInsets.only(left: 72, right: 16),
                title: Text('Chapter ${100 - chapterIndex}'),
                subtitle: Text(
                  'Dibaca ${timeago.format(DateTime.now().subtract(Duration(days: chapterIndex)))}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(LineIcons.bookReader),
                  onPressed: () {
                    // TODO: Open reader
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
