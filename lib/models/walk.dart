enum WalkDifficulty { easy, moderate, challenging }

enum PlaceCategory {
  cafe,
  pub,
  restaurant,
  hotel,
  park,
  beach,
  woodland,
  field,
}

class DogWalk {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final double distanceKm;
  final WalkDifficulty difficulty;
  final List<String> features; // e.g. 'off-lead', 'riverside', 'shaded'
  final double averageRating;
  final int reviewCount;
  final String? imageUrl;
  final String createdBy;

  const DogWalk({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
    required this.difficulty,
    required this.features,
    required this.averageRating,
    required this.reviewCount,
    this.imageUrl,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'distanceKm': distanceKm,
        'difficulty': difficulty.name,
        'features': features,
        'averageRating': averageRating,
        'reviewCount': reviewCount,
        'imageUrl': imageUrl,
        'createdBy': createdBy,
      };

  factory DogWalk.fromJson(Map<String, dynamic> json) => DogWalk(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        distanceKm: (json['distanceKm'] as num).toDouble(),
        difficulty:
            WalkDifficulty.values.byName(json['difficulty'] as String),
        features: List<String>.from(json['features'] as List),
        averageRating: (json['averageRating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        imageUrl: json['imageUrl'] as String?,
        createdBy: json['createdBy'] as String,
      );
}

class DogFriendlyPlace {
  final String id;
  final String name;
  final PlaceCategory category;
  final String address;
  final double latitude;
  final double longitude;
  final double averageRating;
  final int reviewCount;
  final String? imageUrl;
  final String? website;
  final String? phone;

  const DogFriendlyPlace({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.averageRating,
    required this.reviewCount,
    this.imageUrl,
    this.website,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category.name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'averageRating': averageRating,
        'reviewCount': reviewCount,
        'imageUrl': imageUrl,
        'website': website,
        'phone': phone,
      };

  factory DogFriendlyPlace.fromJson(Map<String, dynamic> json) =>
      DogFriendlyPlace(
        id: json['id'] as String,
        name: json['name'] as String,
        category:
            PlaceCategory.values.byName(json['category'] as String),
        address: json['address'] as String,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        averageRating: (json['averageRating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        imageUrl: json['imageUrl'] as String?,
        website: json['website'] as String?,
        phone: json['phone'] as String?,
      );
}

class ServiceProvider {
  final String id;
  final String name;
  final String category; // walker, groomer, physio, sitter, vet, shop
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final double averageRating;
  final int reviewCount;
  final String? imageUrl;
  final String? website;
  final String? phone;

  const ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.averageRating,
    required this.reviewCount,
    this.imageUrl,
    this.website,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'averageRating': averageRating,
        'reviewCount': reviewCount,
        'imageUrl': imageUrl,
        'website': website,
        'phone': phone,
      };

  factory ServiceProvider.fromJson(Map<String, dynamic> json) =>
      ServiceProvider(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        description: json['description'] as String,
        address: json['address'] as String,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        averageRating: (json['averageRating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        imageUrl: json['imageUrl'] as String?,
        website: json['website'] as String?,
        phone: json['phone'] as String?,
      );
}
