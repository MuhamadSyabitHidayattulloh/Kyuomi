import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _searchController = TextEditingController();
  final List<String> _sources = ['Comick', 'KomikCast', 'Batoto', 'MangaDex'];
  String _selectedSource = 'Comick';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Jelajah'),
              floating: true,
              snap: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(110),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Cari manga...',
                          prefixIcon: const Icon(LineIcons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: _sources.map((source) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(source),
                              selected: _selectedSource == source,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedSource = source;
                                  });
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(LineIcons.filter),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const FilterBottomSheet(),
                    );
                  },
                ),
              ],
            ),
          ];
        },
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20, // Placeholder count
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Icon(LineIcons.book,
                            size: 40, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Manga Title',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Genre'),
            Wrap(
              spacing: 8,
              children: [
                'Action',
                'Adventure',
                'Comedy',
                'Drama',
                'Fantasy',
                'Romance',
                'Slice of Life',
                'Sports',
              ]
                  .map((genre) => FilterChip(
                        label: Text(genre),
                        selected: false,
                        onSelected: (selected) {
                          // TODO: Implement genre filter
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text('Status'),
            Wrap(
              spacing: 8,
              children: [
                'Ongoing',
                'Completed',
                'Hiatus',
              ]
                  .map((status) => FilterChip(
                        label: Text(status),
                        selected: false,
                        onSelected: (selected) {
                          // TODO: Implement status filter
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text('Sort By'),
            ListTile(
              title: const Text('A-Z'),
              leading: Radio(
                value: 'az',
                groupValue: 'az',
                onChanged: (value) {
                  // TODO: Implement sort
                },
              ),
            ),
            ListTile(
              title: const Text('Rating'),
              leading: Radio(
                value: 'rating',
                groupValue: 'az',
                onChanged: (value) {
                  // TODO: Implement sort
                },
              ),
            ),
            ListTile(
              title: const Text('Latest Update'),
              leading: Radio(
                value: 'latest',
                groupValue: 'az',
                onChanged: (value) {
                  // TODO: Implement sort
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
