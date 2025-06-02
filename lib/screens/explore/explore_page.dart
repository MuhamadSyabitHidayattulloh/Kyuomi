import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../models/source.dart';
import '../source/source_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String searchQuery = '';

  List<Source> get filteredSources {
    if (searchQuery.isEmpty) {
      return availableSources;
    }
    return availableSources
        .where(
          (source) =>
              source.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jelajah')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search manga...',
                prefixIcon: const Icon(LineIcons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSources.length,
              itemBuilder: (context, index) {
                final source = filteredSources[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(LineIcons.book)),
                  title: Text(source.name),
                  subtitle: Text('Language: ${source.language}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SourceScreen(sourceName: source.name),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
