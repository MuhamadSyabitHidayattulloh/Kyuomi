import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MangaSource {
  final String title;
  final String latestChapter;
  final String type;
  final List<String> genres;

  MangaSource({
    required this.title,
    required this.latestChapter,
    required this.type,
    required this.genres,
  });
}

class SourceScreen extends StatefulWidget {
  final String sourceName;

  const SourceScreen({super.key, required this.sourceName});

  @override
  State<SourceScreen> createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  String searchQuery = '';
  String selectedSort = 'latest';
  List<String> selectedGenres = [];
  String selectedType = 'all';

  final List<String> genres = [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Slice of Life',
  ];

  final List<String> types = ['all', 'manga', 'manhwa', 'manhua'];

  // Temporary data for demonstration
  final List<MangaSource> mangaList = List.generate(
    20,
    (index) => MangaSource(
      title: 'Manga Title $index',
      latestChapter: 'Chapter ${index + 1}',
      type: ['manga', 'manhwa', 'manhua'][index % 3],
      genres: ['Action', 'Adventure', 'Fantasy'],
    ),
  );

  List<MangaSource> get filteredManga {
    return mangaList.where((manga) {
      final matchesSearch =
          searchQuery.isEmpty ||
          manga.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesType = selectedType == 'all' || manga.type == selectedType;
      final matchesGenres =
          selectedGenres.isEmpty ||
          selectedGenres.every((genre) => manga.genres.contains(genre));
      return matchesSearch && matchesType && matchesGenres;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sourceName),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.filter),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          if (selectedGenres.isNotEmpty || selectedType != 'all')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (selectedType != 'all')
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(selectedType),
                        onDeleted: () {
                          setState(() {
                            selectedType = 'all';
                          });
                        },
                      ),
                    ),
                  ...selectedGenres.map(
                    (genre) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(genre),
                        onDeleted: () {
                          setState(() {
                            selectedGenres.remove(genre);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredManga.length,
              itemBuilder: (context, index) {
                final manga = filteredManga[index];
                return _buildMangaCard(manga);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMangaCard(MangaSource manga) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: const Center(child: Icon(LineIcons.book, size: 40)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  manga.title,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  manga.latestChapter,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sort By',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Latest'),
                        selected: selectedSort == 'latest',
                        onSelected: (selected) {
                          setState(() {
                            selectedSort = 'latest';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Popular'),
                        selected: selectedSort == 'popular',
                        onSelected: (selected) {
                          setState(() {
                            selectedSort = 'popular';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Type', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: types
                        .map(
                          (type) => ChoiceChip(
                            label: Text(type),
                            selected: selectedType == type,
                            onSelected: (selected) {
                              setState(() {
                                selectedType = selected ? type : 'all';
                              });
                              Navigator.pop(context);
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Genres',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: genres
                        .map(
                          (genre) => FilterChip(
                            label: Text(genre),
                            selected: selectedGenres.contains(genre),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedGenres.add(genre);
                                } else {
                                  selectedGenres.remove(genre);
                                }
                              });
                              Navigator.pop(context);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
