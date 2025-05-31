import 'package:flutter/material.dart';
import 'package:kyuomi/screens/reader/reader_page.dart';
import 'package:line_icons/line_icons.dart';

class MangaDetailPage extends StatefulWidget {
  const MangaDetailPage({super.key});

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  bool isFavorite = false;
  String selectedSource = 'Source 1'; // Default source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMangaInfo(),
                  const SizedBox(height: 16),
                  _buildSourceSelector(),
                  const SizedBox(height: 16),
                  _buildChaptersList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBatchDownloadOptions(),
        icon: const Icon(LineIcons.download),
        label: const Text('Unduh'),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://placeholder.com/manga-cover',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ],
        ),
        title: const Text(
          'Manga Title',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            isFavorite ? LineIcons.heartAlt : LineIcons.heart,
            color: Colors.white,
          ),
          onPressed: () => setState(() => isFavorite = !isFavorite),
        ),
      ],
    );
  }

  Widget _buildMangaInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Penulis: Author Name', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Genre 1', 'Genre 2'].map((genre) {
            return Chip(
              label: Text(genre),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        const Text('Status: Ongoing', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text('Penerbit: Publisher Name', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        const Text(
          'Sinopsis',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Lorem ipsum dolor sit amet...',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSourceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sumber',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedSource,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: ['Source 1', 'Source 2'].map((source) {
            return DropdownMenuItem(value: source, child: Text(source));
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedSource = value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildChaptersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Chapter',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Chapter ${index + 1}'),
              subtitle: const Text('Chapter Title'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(LineIcons.bookReader),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReaderPage(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LineIcons.download),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _showBatchDownloadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(LineIcons.download),
                title: const Text('Unduh Semua Chapter'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(LineIcons.alternateList),
                title: const Text('Pilih Chapter'),
                onTap: () {
                  Navigator.pop(context);
                  _showChapterSelectionDialog();
                },
              ),
              ListTile(
                leading: const Icon(LineIcons.history),
                title: const Text('Unduh 20 Chapter Terakhir'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChapterSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih Chapter'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text('Chapter ${index + 1}'),
                  value: false,
                  onChanged: (bool? value) {},
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Unduh'),
            ),
          ],
        );
      },
    );
  }
}
