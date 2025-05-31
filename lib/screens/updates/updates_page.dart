import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembaruan'),
      ),
      body: ListView.builder(
        itemCount: 10, // Placeholder count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Chapter 123'),
                  Text(
                    timeago.format(
                        DateTime.now().subtract(const Duration(hours: 2))),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(LineIcons.bookReader),
                    onPressed: () {
                      // TODO: Open reader
                    },
                  ),
                  IconButton(
                    icon: const Icon(LineIcons.download),
                    onPressed: () {
                      // TODO: Download chapter
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
