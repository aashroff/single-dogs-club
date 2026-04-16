enum DogSize { small, medium, large, giant }

enum ActivityLevel { low, medium, high }

enum Temperament { calm, friendly, playful, energetic, nervous, independent }

enum DogSex { male, female }

class DogProfile {
  final String id;
  final String name;
  final String breed;
  final int ageYears;
  final DogSize size;
  final ActivityLevel activityLevel;
  final Temperament temperament;
  final DogSex sex;
  final bool isNeutered;
  final String? bio;
  final List<String> photoUrls;
  final String ownerId;
  final DateTime createdAt;

  const DogProfile({
    required this.id,
    required this.name,
    required this.breed,
    required this.ageYears,
    required this.size,
    required this.activityLevel,
    required this.temperament,
    required this.sex,
    required this.isNeutered,
    this.bio,
    required this.photoUrls,
    required this.ownerId,
    required this.createdAt,
  });

  String get sizeLabel => size.name[0].toUpperCase() + size.name.substring(1);
  String get activityLabel =>
      activityLevel.name[0].toUpperCase() + activityLevel.name.substring(1);
  String get temperamentLabel =>
      temperament.name[0].toUpperCase() + temperament.name.substring(1);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'breed': breed,
        'ageYears': ageYears,
        'size': size.name,
        'activityLevel': activityLevel.name,
        'temperament': temperament.name,
        'sex': sex.name,
        'isNeutered': isNeutered,
        'bio': bio,
        'photoUrls': photoUrls,
        'ownerId': ownerId,
        'createdAt': createdAt.toIso8601String(),
      };

  factory DogProfile.fromJson(Map<String, dynamic> json) => DogProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        breed: json['breed'] as String,
        ageYears: json['ageYears'] as int,
        size: DogSize.values.byName(json['size'] as String),
        activityLevel:
            ActivityLevel.values.byName(json['activityLevel'] as String),
        temperament:
            Temperament.values.byName(json['temperament'] as String),
        sex: DogSex.values.byName(json['sex'] as String),
        isNeutered: json['isNeutered'] as bool,
        bio: json['bio'] as String?,
        photoUrls: List<String>.from(json['photoUrls'] as List),
        ownerId: json['ownerId'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
