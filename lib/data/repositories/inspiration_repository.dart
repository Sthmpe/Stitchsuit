import '../models/inspiration_item.dart';

abstract class InspirationRepository {
  Future<List<InspirationItem>> fetchAll();
}

class MockInspirationRepository implements InspirationRepository {
  @override
  Future<List<InspirationItem>> fetchAll() async {
    // simulate network
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      InspirationItem(
        id: '1',
        title: 'Classic Navy Suit',
        imageUrl: 'https://images.unsplash.com/photo-1520975922224-c6dfc2c2b8f2',
        tags: ['Suit', 'Formal', 'Classic'],
        author: 'Ahmed Couture',
      ),
      InspirationItem(
        id: '2',
        title: 'Earth-Tone Ankara Jacket',
        imageUrl: 'https://images.unsplash.com/photo-1533219057251-3c9d1c0f0a64',
        tags: ['Ankara', 'Jacket', 'Bold'],
        author: 'Maison Kente',
      ),
      InspirationItem(
        id: '3',
        title: 'Minimal Linen Set',
        imageUrl: 'https://images.unsplash.com/photo-1516822003754-cca485356ecb',
        tags: ['Linen', 'Casual', 'Summer'],
        author: 'Linen Lab',
      ),
      InspirationItem(
        id: '4',
        title: 'Wedding Tux with Satin Lapel',
        imageUrl: 'https://images.unsplash.com/photo-1520975960058-7a6b1d2f134b',
        tags: ['Tuxedo', 'Wedding', 'Black-Tie'],
        author: 'Black Tie Co.',
      ),
      InspirationItem(
        id: '5',
        title: 'Textured Blazer',
        imageUrl: 'https://images.unsplash.com/photo-1544441893-675973e31985',
        tags: ['Blazer', 'Texture', 'Smart'],
        author: 'Atelier 9',
      ),
      InspirationItem(
        id: '6',
        title: 'Pattern Mix Set',
        imageUrl: 'https://images.unsplash.com/photo-1519345182560-3f2917c472ef',
        tags: ['Pattern', 'Street', 'Creative'],
        author: 'Pattern Haus',
      ),
    ];
  }
}
