import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String id;
  final String? name;
  final String email;
  final String? imageUrl;
  final double ? unit;
  final DateTime createdAt;

  User({
    required this.id,
    this.name,
    required this.email,
    this.imageUrl,
    this.unit,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
