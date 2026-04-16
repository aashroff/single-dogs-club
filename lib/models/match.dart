enum MatchStatus { pending, matched, rejected }

class DogMatch {
  final String id;
  final String fromDogId;
  final String toDogId;
  final String fromOwnerId;
  final String toOwnerId;
  final MatchStatus status;
  final DateTime createdAt;
  final DateTime? matchedAt;

  const DogMatch({
    required this.id,
    required this.fromDogId,
    required this.toDogId,
    required this.fromOwnerId,
    required this.toOwnerId,
    required this.status,
    required this.createdAt,
    this.matchedAt,
  });

  bool get isMatch => status == MatchStatus.matched;

  Map<String, dynamic> toJson() => {
        'id': id,
        'fromDogId': fromDogId,
        'toDogId': toDogId,
        'fromOwnerId': fromOwnerId,
        'toOwnerId': toOwnerId,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'matchedAt': matchedAt?.toIso8601String(),
      };

  factory DogMatch.fromJson(Map<String, dynamic> json) => DogMatch(
        id: json['id'] as String,
        fromDogId: json['fromDogId'] as String,
        toDogId: json['toDogId'] as String,
        fromOwnerId: json['fromOwnerId'] as String,
        toOwnerId: json['toOwnerId'] as String,
        status: MatchStatus.values.byName(json['status'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        matchedAt: json['matchedAt'] != null
            ? DateTime.parse(json['matchedAt'] as String)
            : null,
      );
}
