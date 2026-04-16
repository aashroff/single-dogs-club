enum OwnerType { single, couple, family }

enum MatchPreference { friendsOnly, openToAll }

class UserProfile {
  final String id;
  final String displayName;
  final String? email;
  final String? avatarUrl;
  final String location;
  final double? latitude;
  final double? longitude;
  final OwnerType ownerType;
  final MatchPreference matchPreference;
  final List<String> dogIds;
  final DateTime createdAt;
  final DateTime lastActive;

  const UserProfile({
    required this.id,
    required this.displayName,
    this.email,
    this.avatarUrl,
    required this.location,
    this.latitude,
    this.longitude,
    required this.ownerType,
    required this.matchPreference,
    required this.dogIds,
    required this.createdAt,
    required this.lastActive,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'email': email,
        'avatarUrl': avatarUrl,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'ownerType': ownerType.name,
        'matchPreference': matchPreference.name,
        'dogIds': dogIds,
        'createdAt': createdAt.toIso8601String(),
        'lastActive': lastActive.toIso8601String(),
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        displayName: json['displayName'] as String,
        email: json['email'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
        location: json['location'] as String,
        latitude: json['latitude'] as double?,
        longitude: json['longitude'] as double?,
        ownerType: OwnerType.values.byName(json['ownerType'] as String),
        matchPreference: MatchPreference.values
            .byName(json['matchPreference'] as String),
        dogIds: List<String>.from(json['dogIds'] as List),
        createdAt: DateTime.parse(json['createdAt'] as String),
        lastActive: DateTime.parse(json['lastActive'] as String),
      );
}
