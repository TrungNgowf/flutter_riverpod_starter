/// Song model representing a music track
class Song {
  final String id;
  final String name;
  final String artist;
  final String? cover;
  final String? genre;
  final DateTime? releaseDate;
  final DateTime? createdAt;

  const Song({
    required this.id,
    required this.name,
    required this.artist,
    this.cover,
    this.genre,
    this.releaseDate,
    this.createdAt,
  });

  /// Creates a Song from JSON map
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String,
      cover: json['cover'] as String?,
      genre: json['genre'] as String?,
      releaseDate: json['releaseDate'] != null
          ? DateTime.tryParse(json['releaseDate'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  /// Converts Song to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'cover': cover,
      'genre': genre,
      'releaseDate': releaseDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// Creates a copy with modified fields
  Song copyWith({
    String? id,
    String? name,
    String? artist,
    String? cover,
    String? genre,
    DateTime? releaseDate,
    DateTime? createdAt,
  }) {
    return Song(
      id: id ?? this.id,
      name: name ?? this.name,
      artist: artist ?? this.artist,
      cover: cover ?? this.cover,
      genre: genre ?? this.genre,
      releaseDate: releaseDate ?? this.releaseDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artist: $artist}';
  }
}
