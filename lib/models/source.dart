class Source {
  final String id;
  final String name;
  final String language;
  final bool isActive;
  final String baseUrl;

  Source({
    required this.id,
    required this.name,
    required this.language,
    this.isActive = true,
    required this.baseUrl,
  });
}

// Sample sources
final List<Source> availableSources = [
  Source(
    id: 'mangadex',
    name: 'MangaDex',
    language: 'en',
    baseUrl: 'https://mangadex.org',
  ),
  Source(
    id: 'mangaplus',
    name: 'Manga Plus',
    language: 'en',
    baseUrl: 'https://mangaplus.shueisha.co.jp',
  ),
  Source(
    id: 'komiku',
    name: 'Komiku',
    language: 'id',
    baseUrl: 'https://komiku.id',
  ),
];
